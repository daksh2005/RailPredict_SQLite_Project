DROP TRIGGER IF EXISTS trg_booking_audit_insert;
CREATE TRIGGER trg_booking_audit_insert
AFTER INSERT ON bookings
BEGIN
  INSERT INTO booking_audit(booking_id, action, new_status)
  VALUES (NEW.booking_id, 'INSERT', NEW.status);
END;

DROP TRIGGER IF EXISTS trg_booking_audit_update;
CREATE TRIGGER trg_booking_audit_update
AFTER UPDATE OF status ON bookings
WHEN OLD.status <> NEW.status
BEGIN
  INSERT INTO booking_audit(booking_id, action, old_status, new_status)
  VALUES (NEW.booking_id, 'STATUS_UPDATE', OLD.status, NEW.status);
END;

DROP TRIGGER IF EXISTS trg_booking_capacity;
CREATE TRIGGER trg_booking_capacity
BEFORE INSERT ON bookings
WHEN NEW.status = 'Confirmed'
 AND (
   SELECT COALESCE(SUM(seats),0) FROM bookings
   WHERE train_id = NEW.train_id
     AND journey_date = NEW.journey_date
     AND status = 'Confirmed'
 ) + NEW.seats > (
   SELECT total_capacity FROM trains WHERE train_id = NEW.train_id
 )
BEGIN
  SELECT RAISE(ABORT, 'Booking exceeds train capacity');
END;
