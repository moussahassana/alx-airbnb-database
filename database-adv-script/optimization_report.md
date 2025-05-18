# Optimization Report for Complex Booking Query

## Initial Query

```sql
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
````

## Initial Query EXPLAIN ANALYZE Output

```
Nested Loop Left Join  (cost=11.50..23.53 rows=2 width=1676) (actual time=0.191..0.199 rows=2 loops=1)
  Join Filter: (b.booking_id = pm.booking_id)
  Rows Removed by Join Filter: 1
  ->  Hash Join  (cost=11.50..22.48 rows=2 width=1620) (actual time=0.165..0.170 rows=2 loops=1)
        Hash Cond: (p.property_id = b.property_id)
        ->  Seq Scan on property p  (cost=0.00..10.70 rows=70 width=532) (actual time=0.030..0.032 rows=2 loops=1)
        ->  Hash  (cost=11.48..11.48 rows=2 width=1104) (actual time=0.113..0.115 rows=2 loops=1)
              Buckets: 1024  Batches: 1  Memory Usage: 9kB
              ->  Hash Join  (cost=1.04..11.48 rows=2 width=1104) (actual time=0.097..0.102 rows=2 loops=1)
                    Hash Cond: (u.user_id = b.user_id)
                    ->  Seq Scan on users u  (cost=0.00..10.30 rows=30 width=1048) (actual time=0.016..0.018 rows=5 loops=1)
                    ->  Hash  (cost=1.02..1.02 rows=2 width=72) (actual time=0.036..0.037 rows=2 loops=1)
                          Buckets: 1024  Batches: 1  Memory Usage: 9kB
                          ->  Seq Scan on booking b  (cost=0.00..1.02 rows=2 width=72) (actual time=0.024..0.025 rows=2 loops=1)
  ->  Materialize  (cost=0.00..1.01 rows=1 width=72) (actual time=0.011..0.012 rows=1 loops=2)
        ->  Seq Scan on payment pm  (cost=0.00..1.01 rows=1 width=72) (actual time=0.016..0.016 rows=1 loops=1)
Planning Time: 1.039 ms
Execution Time: 0.310 ms
```

## Optimization Plan

* The query uses sequential scans on `Property`, `users`, and `Booking` tables.
* Indexes already exist on foreign keys (`user_id`, `property_id`).
* Consider filtering data if applicable.
* Select only required columns (done).
* If possible, check for redundant joins or ensure Payment always exists to use INNER JOIN instead of LEFT JOIN.
* Explore adding indexes if filtering on frequent columns is needed in future.
