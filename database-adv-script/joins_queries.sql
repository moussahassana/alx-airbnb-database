-- 1. INNER JOIN to retrieve all bookings and the respective users who made those bookings
SELECT b.*, u.*
FROM Booking b
INNER JOIN users u ON b.user_id = u.user_id;

-- 2. LEFT JOIN to retrieve all properties and their reviews, including properties that have no reviews
SELECT p.property_id, p.name, p.description, p.location, p.price_per_night,
       r.review_id, r.user_id AS reviewer_id, r.rating, r.comment, r.created_at AS review_date
FROM Property p
LEFT JOIN Review r ON p.property_id = r.property_id;


-- 3. FULL OUTER JOIN to retrieve all users and all bookings, including users without bookings and bookings without users
SELECT u.*, b.*
FROM users u
FULL OUTER JOIN Booking b ON u.user_id = b.user_id;
