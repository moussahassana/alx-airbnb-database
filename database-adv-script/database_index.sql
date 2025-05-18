-- Before index
EXPLAIN ANALYZE
SELECT * FROM Booking WHERE status_id = '7a29b8b4-9a2e-44a3-b7b3-359404e1b15f';

-- Create index for status_id
CREATE INDEX idx_booking_status ON Booking(status_id);

-- After index
EXPLAIN ANALYZE
SELECT * FROM Booking WHERE status_id = '7a29b8b4-9a2e-44a3-b7b3-359404e1b15f';


-- Index on Booking start_date for partitioning and range queries
CREATE INDEX idx_booking_start_date ON Booking(start_date);

-- Index on Property location for faster filtering
CREATE INDEX idx_property_location ON Property(location);

-- Index on Review rating for range filters
CREATE INDEX idx_review_rating ON Review(rating);

-- Index on Payment method
CREATE INDEX idx_payment_method ON Payment(method_id);


--