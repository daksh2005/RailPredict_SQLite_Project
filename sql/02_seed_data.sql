INSERT OR IGNORE INTO stations VALUES
(1,'NDLS','New Delhi','Delhi','Delhi'),
(2,'CDG','Chandigarh','Chandigarh','Chandigarh'),
(3,'UMB','Ambala Cantt','Ambala','Haryana'),
(4,'LKO','Lucknow NR','Lucknow','Uttar Pradesh'),
(5,'BCT','Mumbai Central','Mumbai','Maharashtra'),
(6,'JP','Jaipur','Jaipur','Rajasthan');

INSERT OR IGNORE INTO trains VALUES
(1,'12011','Kalka Shatabdi',900,'Shatabdi'),
(2,'12418','Prayagraj Express',1200,'Superfast'),
(3,'12952','Mumbai Rajdhani',1000,'Rajdhani'),
(4,'12988','Ajmer Intercity',700,'Intercity');

INSERT OR IGNORE INTO routes VALUES
(1,1,1,2,266),(2,2,1,4,512),(3,3,1,5,1384),(4,4,1,6,308);

INSERT OR IGNORE INTO passengers VALUES
(1,'Aarav Sharma',21,'Male'),(2,'Ananya Verma',22,'Female'),
(3,'Vihaan Singh',24,'Male'),(4,'Diya Gupta',20,'Female'),
(5,'Kabir Mehta',27,'Male'),(6,'Ishita Kapoor',23,'Female'),
(7,'Arjun Patel',29,'Male'),(8,'Saanvi Rao',25,'Female'),
(9,'Reyansh Kumar',31,'Male'),(10,'Myra Joshi',19,'Female'),
(11,'Aditya Malhotra',28,'Male'),(12,'Kiara Das',26,'Female'),
(13,'Rohan Bansal',33,'Male'),(14,'Aadhya Nair',22,'Female'),
(15,'Dev Khanna',30,'Male'),(16,'Sara Ali',24,'Female'),
(17,'Neil Thomas',35,'Male'),(18,'Pari Chawla',21,'Female'),
(19,'Yash Arora',27,'Male'),(20,'Tara Sen',23,'Female');

INSERT OR IGNORE INTO bookings VALUES
(1,1,1,1,'2026-11-05','2026-10-20',850,'Confirmed',2),
(2,2,1,1,'2026-11-05','2026-10-21',850,'Confirmed',1),
(3,3,1,1,'2026-11-06','2026-10-22',850,'Cancelled',1),
(4,4,2,2,'2026-11-07','2026-10-23',1120,'Confirmed',2),
(5,5,2,2,'2026-11-07','2026-10-24',1120,'Confirmed',1),
(6,6,2,2,'2026-11-08','2026-10-24',1120,'Waitlisted',1),
(7,7,3,3,'2026-11-09','2026-10-25',2450,'Confirmed',2),
(8,8,3,3,'2026-11-09','2026-10-26',2450,'Confirmed',1),
(9,9,3,3,'2026-11-10','2026-10-27',2450,'Cancelled',1),
(10,10,4,4,'2026-11-11','2026-10-27',690,'Confirmed',1),
(11,11,4,4,'2026-11-11','2026-10-28',690,'Confirmed',2),
(12,12,4,4,'2026-11-12','2026-10-28',690,'Confirmed',1),
(13,13,1,1,'2026-11-13','2026-10-29',850,'Confirmed',1),
(14,14,2,2,'2026-11-14','2026-10-29',1120,'Confirmed',2),
(15,15,3,3,'2026-11-15','2026-10-30',2450,'Confirmed',1),
(16,16,4,4,'2026-11-16','2026-10-30',690,'Cancelled',1),
(17,17,1,1,'2026-11-17','2026-10-30',850,'Confirmed',2),
(18,18,2,2,'2026-11-18','2026-10-31',1120,'Confirmed',1),
(19,19,3,3,'2026-11-19','2026-10-31',2450,'Confirmed',1),
(20,20,4,4,'2026-11-20','2026-10-31',690,'Waitlisted',1);
