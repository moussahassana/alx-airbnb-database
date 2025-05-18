# Index Performance Report

## Added Indexes
- Booking.status_id

## Query Tested
```sql
EXPLAIN ANALYZE
SELECT * FROM Booking WHERE status_id = '7a29b8b4-9a2e-44a3-b7b3-359404e1b15f';
```

## Before Indexing
```
Seq Scan on booking  (cost=0.00..18.12 rows=3 width=96) (actual time=0.040..0.042 rows=1 loops=1)
  Filter: (status_id = '7a29b8b4-9a2e-44a3-b7b3-359404e1b15f'::uuid)
  Rows Removed by Filter: 1
Planning Time: 0.156 ms
Execution Time: 0.476 ms
```

## After Indexing
```
Seq Scan on booking  (cost=0.00..1.02 rows=1 width=96) (actual time=0.027..0.029 rows=1 loops=1)
  Filter: (status_id = '7a29b8b4-9a2e-44a3-b7b3-359404e1b15f'::uuid)
  Rows Removed by Filter: 1
Planning Time: 1.888 ms
Execution Time: 0.052 ms
```

## Observation
Even though a sequential scan was still used, the overall execution time improved from 0.476 ms to 0.052 ms after indexing. This is likely due to improved planning and caching, and could further improve with more data.
