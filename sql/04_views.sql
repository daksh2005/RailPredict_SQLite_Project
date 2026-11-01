DROP VIEW IF EXISTS vw_train_occupancy;
CREATE VIEW vw_train_occupancy AS
SELECT t.train_id, t.train_number, t.train_name, t.total_capacity,
       COALESCE(SUM(CASE WHEN b.status='Confirmed' THEN b.seats ELSE 0 END),0) AS booked_seats,
       ROUND(100.0 * COALESCE(SUM(CASE WHEN b.status='Confirmed' THEN b.seats ELSE 0 END),0)
             / t.total_capacity, 2) AS occupancy_percent
FROM trains t LEFT JOIN bookings b ON t.train_id=b.train_id
GROUP BY t.train_id, t.train_number, t.train_name, t.total_capacity;

DROP VIEW IF EXISTS vw_route_performance;
CREATE VIEW vw_route_performance AS
SELECT r.route_id, t.train_name,
       s1.station_name AS source_station, s2.station_name AS destination_station,
       r.distance_km,
       COUNT(b.booking_id) AS total_bookings,
       SUM(CASE WHEN b.status='Cancelled' THEN 1 ELSE 0 END) AS cancellations
FROM routes r
JOIN trains t ON r.train_id=t.train_id
JOIN stations s1 ON r.source_station_id=s1.station_id
JOIN stations s2 ON r.destination_station_id=s2.station_id
LEFT JOIN bookings b ON r.route_id=b.route_id
GROUP BY r.route_id, t.train_name, s1.station_name, s2.station_name, r.distance_km;

DROP VIEW IF EXISTS vw_monthly_revenue;
CREATE VIEW vw_monthly_revenue AS
SELECT substr(journey_date,1,7) AS journey_month,
       ROUND(SUM(CASE WHEN status='Confirmed' THEN fare*seats ELSE 0 END),2) AS revenue,
       COUNT(*) AS booking_count
FROM bookings
GROUP BY substr(journey_date,1,7);
