-- Total number of bookings made by each user
SELECT u.user_id, u.first_name, u.last_name, COUNT(b.booking_id) AS total_bookings
FROM users u
JOIN Booking b ON u.user_id = b.user_id
GROUP BY u.user_id, u.first_name, u.last_name
ORDER BY total_bookings DESC;
