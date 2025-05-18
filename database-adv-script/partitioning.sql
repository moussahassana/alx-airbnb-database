-- Drop existing Booking table if it exists
DROP TABLE IF EXISTS Booking CASCADE;

-- Recreate Booking table (non-partitioned) for initial performance test
CREATE TABLE Booking (
    booking_id UUID PRIMARY KEY,
    property_id UUID NOT NULL,
    user_id UUID NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    status_id UUID NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (property_id) REFERENCES Property(property_id),
    FOREIGN KEY (status_id) REFERENCES BookingStatus(status_id)
);

-- Initial performance test before partitioning
EXPLAIN ANALYZE
SELECT * FROM Booking
WHERE start_date >= '2024-01-01' AND start_date < '2025-01-01';

-- Drop the unpartitioned table to prepare for partitioning
DROP TABLE IF EXISTS Booking CASCADE;

-- Create partitioned Booking table
CREATE TABLE Booking (
    booking_id UUID NOT NULL,
    property_id UUID NOT NULL,
    user_id UUID NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    status_id UUID NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (booking_id, start_date),
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (property_id) REFERENCES Property(property_id),
    FOREIGN KEY (status_id) REFERENCES BookingStatus(status_id)
) PARTITION BY RANGE (start_date);

-- Create partitions by year (example: 2023, 2024, 2025)
CREATE TABLE booking_2023 PARTITION OF Booking
    FOR VALUES FROM ('2023-01-01') TO ('2024-01-01');

CREATE TABLE booking_2024 PARTITION OF Booking
    FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');

CREATE TABLE booking_2025 PARTITION OF Booking
    FOR VALUES FROM ('2025-01-01') TO ('2026-01-01');

-- Add indexes on partitions as needed (example on booking_2023)
CREATE INDEX idx_booking_2023_status ON booking_2023 (status_id);
CREATE INDEX idx_booking_2024_status ON booking_2024 (status_id);
CREATE INDEX idx_booking_2025_status ON booking_2025 (status_id);

-- Performance test after partitioning
EXPLAIN ANALYZE
SELECT * FROM Booking
WHERE start_date >= '2024-01-01' AND start_date < '2025-01-01';
