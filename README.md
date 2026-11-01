# RailPredict – Railway Passenger Demand Analytics System

A local, beginner-friendly ADBMS mini project using **SQLite + Python + Streamlit**. No Oracle account, server, SQLcl, or paid cloud service is required.

## Features
- Railway stations, trains, routes, passengers and bookings
- Booking validation and automatic booking audit trigger
- Train occupancy, route performance and monthly revenue views
- KPI dashboard and CSV export
- Synthetic sample data for academic demonstration

## Requirements
- macOS / Windows / Linux
- Python 3.10 or newer
- VS Code (recommended)

## Run on macOS
Open Terminal in the project folder and run:

```bash
cd app
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
streamlit run dashboard.py
```

The app creates `railpredict.db` automatically in the project root and loads sample data on first run. Open the local URL shown in Terminal (usually http://localhost:8501).

## Run the SQL scripts manually (optional)
From the project root:

```bash
sqlite3 railpredict.db < sql/01_schema.sql
sqlite3 railpredict.db < sql/02_seed_data.sql
sqlite3 railpredict.db < sql/03_triggers.sql
sqlite3 railpredict.db < sql/04_views.sql
```

If `sqlite3` command-line utility is unavailable, the Streamlit app still works because Python includes SQLite support.

## Important academic note
SQLite is not Oracle PL/SQL. This version demonstrates relational database design, SQL, views, triggers, ETL-style loading, and OLAP-style analysis. Python functions replace Oracle stored procedures/packages. If the course rubric explicitly requires Oracle PL/SQL packages, confirm this substitution with your faculty.
