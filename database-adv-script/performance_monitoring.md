# Performance Monitoring and Refinement

## Overview

This document outlines the results of performance monitoring on two frequently used queries in the ALX Airbnb Database project. Using EXPLAIN ANALYZE, we evaluated query plans and identified potential performance issues and improvements.

---

## 1. Query: Count Bookings per Property (with Partitioning)

```sql
EXPLAIN ANALYZE
SELECT property_id, COUNT(*) AS total_bookings
FROM Booking
GROUP BY property_id
HAVING COUNT(*) > 5;
```

### Execution Plan Summary

| Operation            | Detail                                                                 |
|----------------------|------------------------------------------------------------------------|
| Plan Type            | HashAggregate                                                          |
| Group Key            | booking.property_id                                                    |
| Filter               | count(*) > 5                                                           |
| Source               | Append on partitions: booking_2023, booking_2024, booking_2025         |
| Rows Returned        | 0                                                                      |
| Planning Time        | 0.442 ms                                                               |
| Execution Time       | 0.113 ms                                                               |

### Observations

- The planner uses an Append node to scan all partitions.
- The result set is currently empty, but performance is efficient on small data.
- With larger datasets, a composite index on (property_id, start_date) could benefit this query.

---

## 2. Query: Average Rating per Property

```sql
EXPLAIN ANALYZE
SELECT property_id, AVG(rating) AS avg_rating
FROM Review
GROUP BY property_id;
```

### Execution Plan Summary

| Operation            | Detail                      |
|----------------------|-----------------------------|
| Plan Type            | HashAggregate               |
| Group Key            | property_id                 |
| Source               | Seq Scan on review table    |
| Rows Returned        | 1                           |
| Planning Time        | 0.124 ms                    |
| Execution Time       | 0.093 ms                    |

### Observations

- The query performs a full table scan (Seq Scan).
- For larger datasets, indexing review(property_id) could improve aggregation performance.

---

## Recommendations

| Query | Current Performance | Recommended Improvement |
|-------|---------------------|--------------------------|
| 1     | Fast with small data; scans all partitions | Add index on Booking(property_id, start_date) |
| 2     | Acceptable on small table | Add index on Review(property_id) |

---

## Next Steps

- Monitor performance again after inserting more data.
- Re-evaluate EXPLAIN ANALYZE plans after applying suggested indexes.
