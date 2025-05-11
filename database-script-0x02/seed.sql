-- Insert into Role
INSERT INTO Role (role_id, role_name) VALUES
  (uuid_generate_v4(), 'guest'),
  (uuid_generate_v4(), 'host'),
  (uuid_generate_v4(), 'admin');

-- Insert into BookingStatus
INSERT INTO BookingStatus (status_id, status_name) VALUES
  (uuid_generate_v4(), 'pending'),
  (uuid_generate_v4(), 'confirmed'),
  (uuid_generate_v4(), 'canceled');

-- Insert into PaymentMethod
INSERT INTO PaymentMethod (method_id, method_name) VALUES
  (uuid_generate_v4(), 'credit_card'),
  (uuid_generate_v4(), 'paypal'),
  (uuid_generate_v4(), 'stripe');

-- Insert into users
INSERT INTO users (
  user_id, first_name, last_name, email, password_hash, phone_number, role_id, created_at
)
VALUES
  (uuid_generate_v4(), 'Alice', 'Ngono', 'alice@example.com', 'hashed_pw_1', '+237612345678',
    (SELECT role_id FROM Role WHERE role_name = 'host'), CURRENT_TIMESTAMP),
  (uuid_generate_v4(), 'Bruno', 'Kouam', 'bruno@example.com', 'hashed_pw_2', '+237690123456',
    (SELECT role_id FROM Role WHERE role_name = 'guest'), CURRENT_TIMESTAMP),
  (uuid_generate_v4(), 'Chloe', 'Talla', 'chloe@example.com', 'hashed_pw_3', NULL,
    (SELECT role_id FROM Role WHERE role_name = 'admin'), CURRENT_TIMESTAMP),
  (uuid_generate_v4(), 'David', 'Fotso', 'david@example.com', 'hashed_pw_4', '+237699876543',
    (SELECT role_id FROM Role WHERE role_name = 'host'), CURRENT_TIMESTAMP),
  (uuid_generate_v4(), 'Emma', 'Mbappe', 'emma@example.com', 'hashed_pw_5', '+237680111222',
    (SELECT role_id FROM Role WHERE role_name = 'guest'), CURRENT_TIMESTAMP);

-- Insert into Property
INSERT INTO Property (
  property_id, host_id, name, description, location, price_per_night, created_at, updated_at
)
VALUES
  (uuid_generate_v4(),
    (SELECT user_id FROM users WHERE email = 'alice@example.com'),
    'Villa Bonamoussadi',
    'A cozy 3-bedroom villa with AC and parking',
    'Douala, Bonamoussadi',
    45000.00, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (uuid_generate_v4(),
    (SELECT user_id FROM users WHERE email = 'david@example.com'),
    'Studio Bastos',
    'Compact studio apartment ideal for business trips',
    'Yaoundé, Bastos',
    30000.00, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Insert into Booking
INSERT INTO Booking (
  booking_id, property_id, user_id, start_date, end_date, total_price, status_id, created_at
)
VALUES
  (
    uuid_generate_v4(),
    (SELECT property_id FROM Property WHERE name = 'Villa Bonamoussadi'),
    (SELECT user_id FROM users WHERE email = 'bruno@example.com'),
    '2025-06-01', '2025-06-03', 90000.00,
    (SELECT status_id FROM BookingStatus WHERE status_name = 'confirmed'),
    CURRENT_TIMESTAMP
  ),
  (
    uuid_generate_v4(),
    (SELECT property_id FROM Property WHERE name = 'Studio Bastos'),
    (SELECT user_id FROM users WHERE email = 'emma@example.com'),
    '2025-06-05', '2025-06-08', 90000.00,
    (SELECT status_id FROM BookingStatus WHERE status_name = 'pending'),
    CURRENT_TIMESTAMP
  );

-- Insert into Payment
INSERT INTO Payment (
  payment_id, booking_id, amount, payment_date, method_id
)
VALUES
  (
    uuid_generate_v4(),
    (SELECT booking_id FROM Booking WHERE start_date = '2025-06-01'),
    90000.00,
    CURRENT_TIMESTAMP,
    (SELECT method_id FROM PaymentMethod WHERE method_name = 'credit_card')
  );

-- Insert into Review
INSERT INTO Review (
  review_id, property_id, user_id, rating, comment, created_at
)
VALUES
  (
    uuid_generate_v4(),
    (SELECT property_id FROM Property WHERE name = 'Villa Bonamoussadi'),
    (SELECT user_id FROM users WHERE email = 'bruno@example.com'),
    5, 'Amazing stay. Very clean and quiet.', CURRENT_TIMESTAMP
  );

-- Insert into Message
INSERT INTO Message (
  message_id, sender_id, recipient_id, message_body, send_at
)
VALUES
  (
    uuid_generate_v4(),
    (SELECT user_id FROM users WHERE email = 'emma@example.com'),
    (SELECT user_id FROM users WHERE email = 'alice@example.com'),
    'Hi, is Villa Bonamoussadi available for next weekend?', CURRENT_TIMESTAMP
  );
