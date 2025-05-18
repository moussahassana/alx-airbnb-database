-- Total number of bookings made by each user
SELECT 
    u.user_id, 
    u.first_name, 
    u.last_name, 
    COUNT(b.booking_id) AS total_bookings
FROM 
    users u
JOIN 
    Booking b ON u.user_id = b.user_id
GROUP BY 
    u.user_id, u.first_name, u.last_name
ORDER BY 
    total_bookings DESC;

-- Rank properties by total bookings using RANK()
SELECT
    property_id,
    COUNT(booking_id) AS total_bookings,
    RANK() OVER (ORDER BY COUNT(booking_id) DESC) AS rank
FROM
    Booking
GROUP BY
    property_id;

-- Rank properties by total bookings using ROW_NUMBER()
SELECT
    property_id,
    COUNT(booking_id) AS total_bookings,
    ROW_NUMBER() OVER (ORDER BY COUNT(booking_id) DESC) AS row_num
FROM
    Booking
GROUP BY
    property_id;
