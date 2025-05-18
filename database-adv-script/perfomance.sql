-- Initial complex query joining Bookings, Users, Property, and Payment details
SELECT
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    u.user_id,
    u.first_name,
    u.last_name,
    p.property_id,
    p.name AS property_name,
    pm.payment_id,
    pm.amount,
    pm.payment_date,
    pm.method_id
FROM Booking b
JOIN users u ON b.user_id = u.user_id
JOIN Property p ON b.property_id = p.property_id
LEFT JOIN Payment pm ON b.booking_id = pm.booking_id;
