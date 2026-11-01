from pathlib import Path
import sqlite3
import pandas as pd
import plotly.express as px
import streamlit as st

ROOT = Path(__file__).resolve().parents[1]
DB = ROOT / "railpredict.db"

st.set_page_config(page_title="RailPredict", page_icon="🚆", layout="wide")

def connect():
    return sqlite3.connect(DB)

def initialize():
    with connect() as con:
        for filename in ["01_schema.sql", "02_seed_data.sql", "03_triggers.sql", "04_views.sql"]:
            con.executescript((ROOT / "sql" / filename).read_text())
        con.commit()

initialize()

st.title("🚆 RailPredict")
st.caption("Railway Passenger Demand Analytics System | SQLite + Python + Streamlit")

with connect() as con:
    occ = pd.read_sql_query("SELECT * FROM vw_train_occupancy ORDER BY occupancy_percent DESC", con)
    routes = pd.read_sql_query("SELECT * FROM vw_route_performance", con)
    monthly = pd.read_sql_query("SELECT * FROM vw_monthly_revenue ORDER BY journey_month", con)
    bookings = pd.read_sql_query("""
        SELECT b.booking_id, p.passenger_name, t.train_number, t.train_name,
               s1.station_name AS source, s2.station_name AS destination,
               b.journey_date, b.fare, b.seats, b.status
        FROM bookings b
        JOIN passengers p ON p.passenger_id=b.passenger_id
        JOIN trains t ON t.train_id=b.train_id
        JOIN routes r ON r.route_id=b.route_id
        JOIN stations s1 ON s1.station_id=r.source_station_id
        JOIN stations s2 ON s2.station_id=r.destination_station_id
        ORDER BY b.booking_id
    """, con)
    audit_count = con.execute("SELECT COUNT(*) FROM booking_audit").fetchone()[0]

confirmed = bookings[bookings.status == "Confirmed"]
c1,c2,c3,c4 = st.columns(4)
c1.metric("Total bookings", f"{len(bookings):,}")
c2.metric("Confirmed bookings", f"{len(confirmed):,}")
c3.metric("Total revenue", f"₹{(confirmed.fare*confirmed.seats).sum():,.0f}")
c4.metric("Audit events", f"{audit_count:,}")

tab1, tab2, tab3, tab4 = st.tabs(["Train Occupancy", "Route Analysis", "Revenue", "Bookings & Export"])
with tab1:
    st.subheader("Train occupancy")
    st.dataframe(occ, use_container_width=True, hide_index=True)
    st.plotly_chart(px.bar(occ, x="train_name", y="occupancy_percent",
                           title="Confirmed seat occupancy by train",
                           labels={"train_name":"Train","occupancy_percent":"Occupancy (%)"}),
                    use_container_width=True)
with tab2:
    st.subheader("Route performance")
    st.dataframe(routes, use_container_width=True, hide_index=True)
    st.plotly_chart(px.bar(routes, x="train_name", y=["total_bookings","cancellations"],
                           barmode="group", title="Bookings and cancellations by route"),
                    use_container_width=True)
with tab3:
    st.subheader("Monthly revenue")
    st.dataframe(monthly, use_container_width=True, hide_index=True)
    st.plotly_chart(px.line(monthly, x="journey_month", y="revenue", markers=True,
                            title="Revenue by journey month"), use_container_width=True)
with tab4:
    st.subheader("Booking records")
    status_filter = st.multiselect("Filter by booking status",
                                   options=sorted(bookings.status.unique()),
                                   default=sorted(bookings.status.unique()))
    filtered = bookings[bookings.status.isin(status_filter)]
    st.dataframe(filtered, use_container_width=True, hide_index=True)
    st.download_button("Download filtered bookings CSV",
                       filtered.to_csv(index=False).encode("utf-8"),
                       file_name="railpredict_bookings.csv", mime="text/csv")

st.divider()
st.caption("Academic demonstration using synthetic sample data. Not connected to live Indian Railways systems.")
