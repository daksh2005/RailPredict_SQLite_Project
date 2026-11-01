PRAGMA foreign_keys = ON;

CREATE TABLE IF NOT EXISTS stations (
  station_id INTEGER PRIMARY KEY,
  station_code TEXT NOT NULL UNIQUE,
  station_name TEXT NOT NULL,
  city TEXT NOT NULL,
  state TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS trains (
  train_id INTEGER PRIMARY KEY,
  train_number TEXT NOT NULL UNIQUE,
  train_name TEXT NOT NULL,
  total_capacity INTEGER NOT NULL CHECK(total_capacity > 0),
  train_type TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS routes (
  route_id INTEGER PRIMARY KEY,
  train_id INTEGER NOT NULL REFERENCES trains(train_id),
  source_station_id INTEGER NOT NULL REFERENCES stations(station_id),
  destination_station_id INTEGER NOT NULL REFERENCES stations(station_id),
  distance_km INTEGER NOT NULL CHECK(distance_km > 0),
  UNIQUE(train_id, source_station_id, destination_station_id)
);

CREATE TABLE IF NOT EXISTS passengers (
  passenger_id INTEGER PRIMARY KEY,
  passenger_name TEXT NOT NULL,
  age INTEGER CHECK(age BETWEEN 0 AND 120),
  gender TEXT
);

CREATE TABLE IF NOT EXISTS bookings (
  booking_id INTEGER PRIMARY KEY,
  passenger_id INTEGER NOT NULL REFERENCES passengers(passenger_id),
  train_id INTEGER NOT NULL REFERENCES trains(train_id),
  route_id INTEGER NOT NULL REFERENCES routes(route_id),
  journey_date TEXT NOT NULL,
  booking_date TEXT NOT NULL,
  fare REAL NOT NULL CHECK(fare >= 0),
  status TEXT NOT NULL CHECK(status IN ('Confirmed','Cancelled','Waitlisted')),
  seats INTEGER NOT NULL DEFAULT 1 CHECK(seats > 0)
);

CREATE TABLE IF NOT EXISTS booking_audit (
  audit_id INTEGER PRIMARY KEY AUTOINCREMENT,
  booking_id INTEGER NOT NULL,
  action TEXT NOT NULL,
  action_time TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
  old_status TEXT,
  new_status TEXT
);
