SELECT b.*, u.*
FROM Booking b
INNER JOIN users u ON b.user_id = u.user_id;