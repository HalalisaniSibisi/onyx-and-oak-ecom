# E-Commerce Practice Database

A standalone practice project modeling a single-vendor B2C e-commerce backend in SQL Server. Built as a Saturday coding exercise to practice relational database design: supertype/subtype modeling, many-to-many resolution via a junction table, and composite keys.

## Project Type

Single-vendor B2C retail (one store, own inventory, direct-to-customer). No marketplace, subscription, or multi-seller complexity — kept intentionally simple to focus on core relational design patterns.

## Structure

```
ecommerce-practice-db/
├── README.md
├── sql/
│   ├── schema.sql       -- CREATE TABLE statements
│   ├── seed_data.sql    -- sample data (15 users, 12 customers, 3 admins, 10 products, 15 orders)
│   └── queries.sql      -- reporting queries (total spend per customer, top-selling products)
└── docs/
    ├── erd.md               -- entity relationship diagram (text form)
    └── design-decisions.md  -- reasoning behind key design choices
```

## Entities

| Table | Purpose |
|---|---|
| Users | Shared authentication identity (email, password hash) |
| Admin | Staff subtype — 1:1 with Users |
| Customers | Shopper subtype — 1:1 with Users |
| Orders | One order per checkout, belongs to one Customer |
| Inventory | Product catalog |
| OrderDetails | Line items — resolves the Orders↔Inventory many-to-many |

## Key Design Decisions (short version)

- **Users/Admin/Customers split**: role is implied by which subtype table has a matching row, not stored as a redundant flag — avoids the data being able to contradict itself.
- **OrderDetails composite key** `(OrderID, InventoryID)`: makes duplicate line items for the same product on the same order structurally impossible.
- **PriceAtTimeOfOrder**: stored independently of Inventory.CurrentPrice so historical orders don't silently change value if catalog prices update later.

Full reasoning in `docs/design-decisions.md`.

## How to Run

1. Run `sql/schema.sql` against a SQL Server database (tables must be created in this order due to FK dependencies: Users → Admin/Customers → Orders → Inventory → OrderDetails).
2. Run `sql/seed_data.sql` to populate sample data.
3. Run queries from `sql/queries.sql` to explore.
