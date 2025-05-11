# 🌱 Airbnb Database – Sample Data Seeder

This directory contains the SQL script used to populate the normalized Airbnb database with realistic sample data for development, testing, and evaluation.

---

## 📁 Files

- `seed.sql`: SQL script to insert data into all major tables, including:
  - Lookup tables: `Role`, `BookingStatus`, `PaymentMethod`
  - Main entities: `users`, `Property`, `Booking`, `Payment`, `Review`, `Message`
- `README.md`: This documentation

---

## 🧪 Sample Data Coverage

| Entity         | Records Inserted |
|----------------|------------------|
| Role           | 3                |
| BookingStatus  | 3                |
| PaymentMethod  | 3                |
| users          | 5                |
| Property       | 2                |
| Booking        | 2                |
| Payment        | 1                |
| Review         | 1                |
| Message        | 1                |

Each record uses real-world-like data to simulate booking scenarios with hosts and guests.

---

## 🛠️ How to Run

> ⚠️ **Pre-requisite**: Ensure your database is created and the schema from `../database-script-0x01/schema.sql` has already been applied.

Then run:

```bash
psql -U your_user -d your_airbnb_db -f seed.sql
