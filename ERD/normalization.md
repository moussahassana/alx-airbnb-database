# ✅ Database Normalization – Airbnb Schema

## 📌 Objective

The purpose of this document is to explain how the Airbnb database design adheres to **Third Normal Form (3NF)**. Normalization ensures data consistency, avoids redundancy, and supports scalability in a relational database system.

---

## 🧩 Normalization Levels Explained

### 🔹 First Normal Form (1NF)

**Definition**: A table is in 1NF if:
- Each column contains atomic (indivisible) values.
- There are no repeating groups or arrays.

✅ **Our Implementation**:
- All attributes (e.g., names, descriptions, prices) are atomic.
- No multivalued or repeated fields exist (e.g., no “phone1, phone2”).
- All tables have primary keys.

---

### 🔸 Second Normal Form (2NF)

**Definition**: A table is in 2NF if:
- It is already in 1NF.
- Every non-key attribute is fully functionally dependent on the entire primary key (not just part of it).

✅ **Our Implementation**:
- All tables use single-column primary keys (UUIDs).
- No partial dependencies exist.
- For instance, in the `Booking` table, attributes like `start_date`, `end_date`, `total_price` depend entirely on `booking_id`.

---

### 🔺 Third Normal Form (3NF)

**Definition**: A table is in 3NF if:
- It is already in 2NF.
- No transitive dependency exists (i.e., no non-key attribute depends on another non-key attribute).

✅ **Our Implementation**:
- We removed transitive dependencies using **lookup/reference tables**:
  - `Role` table for user roles (`guest`, `host`, `admin`)
  - (Optionally) future `BookingStatus` or `PaymentMethod` tables for ENUM-like attributes
- Example: Instead of storing `role = 'host'` in the `User` table, we store `role_id` as a foreign key to a `Role` table, which avoids redundancy and supports future extensibility.

---

## 📦 Normalization Decisions Summary

| Original Idea                 | Normalized Solution              | Justification                                |
|------------------------------|----------------------------------|----------------------------------------------|
| `role` as ENUM in `User`     | `role_id` → FK to `Role` table   | 3NF compliance, flexibility, avoids repetition |
| `payment_method` ENUM        | Optional FK to a `PaymentMethod` table | Same logic (can be extended)             |
| `status` ENUM in `Booking`   | Optional FK to `BookingStatus`   | Allows managing status separately             |

---

## 💡 Benefits of Our Normalization

- **Reduces redundancy**: Roles and payment methods are defined once and reused.
- **Improves data integrity**: Foreign keys enforce consistency.
- **Supports scalability**: Lookup tables can be extended without modifying core tables.
- **Ensures clarity**: Clear separation of concerns between entities.

---

## ✅ Conclusion

The Airbnb database design strictly adheres to 3NF by:
- Eliminating repeating groups (1NF)
- Ensuring full functional dependencies (2NF)
- Removing transitive dependencies using lookup tables (3NF)

This structure provides a strong foundation for schema creation and real-world data operations.
