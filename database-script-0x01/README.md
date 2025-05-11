# 📐 Airbnb Database Schema – DDL Scripts

This directory contains the SQL Data Definition Language (DDL) scripts that define the schema for a normalized, production-grade Airbnb-like database.

---

## 📌 Overview

The schema was designed as part of the **ALX Airbnb Database Module** and follows best practices in database modeling, normalization (up to 3NF), and indexing for performance.

---

## 📁 Files

- `schema.sql`: Main SQL script to create all tables, constraints, and indexes.
- `README.md`: Documentation of schema structure and usage.

---

## 🧱 Database Design Highlights

### ✅ Key Features

- All entities use **UUIDs** as primary keys (`uuid_generate_v4()` in PostgreSQL).
- **Lookup tables** (`Role`, `BookingStatus`, `PaymentMethod`) used to eliminate ENUMs and ensure full normalization (3NF).
- **Constraints** include:
  - `NOT NULL`
  - `UNIQUE`
  - `CHECK` (e.g., rating between 1–5)
  - Foreign key references with cascading relationships
- **Indexing**:
  - `email` in `Users`
  - `property_id`, `booking_id` for performance-critical joins

---

## 🧩 Tables and Relationships

| Table           | Description                              |
|----------------|------------------------------------------|
| `Role`          | Lookup table for user roles (guest, host, admin) |
| `Users`          | Stores user data, linked to `Role`       |
| `Property`      | Listings created by hosts                |
| `Booking`       | Reservations by users for properties     |
| `BookingStatus` | Lookup for booking status values         |
| `Payment`       | Payments associated with bookings        |
| `PaymentMethod` | Lookup for accepted payment types        |
| `Review`        | Reviews left by users on properties      |
| `Message`       | Direct messages between users            |

---

## 🛠️ How to Run

Ensure PostgreSQL is installed and the `uuid-ossp` extension is enabled:

```sql
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
