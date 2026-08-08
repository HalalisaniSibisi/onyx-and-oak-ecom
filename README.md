# E-Commerce CRUD Application

A full C# ASP.NET MVC CRUD application modeling a single-vendor B2C e-commerce backend, backed by SQL Server. Started as a database-design exercise (relational modeling: supertype/subtype patterns, many-to-many resolution via a junction table, composite keys) and is being built out into a complete web application on top of that schema.

## Project Type

Single-vendor B2C retail (one store, own inventory, direct-to-customer). No marketplace, subscription, or multi-seller complexity — the schema is kept intentionally simple so the application layer (auth, controllers, views, CRUD flows) stays the focus.

**Stack:** C# / ASP.NET MVC / SQL Server / Dapper for data access.

## Structure

```
ecommerce-practice-db/
├── README.md
├── src/                  -- ASP.NET MVC application (Models, Views, Controllers)
├── sql/
│   ├── schema.sql        -- CREATE TABLE statements
│   ├── seed_data.sql     -- sample data (15 users, 12 customers, 3 admins, 10 products, 15 orders)
│   └── queries.sql       -- reporting queries (total spend per customer, top-selling products)
└── docs/
    ├── erd.md                -- entity relationship diagram (text form)
    ├── design-decisions.md   -- reasoning behind key database design choices
    └── app-notes.md          -- notes on the MVC layer as it's built (auth flow, controller decisions, etc.)
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

### Database
1. Run `sql/schema.sql` against a SQL Server database (tables must be created in this order due to FK dependencies: Users → Admin/Customers → Orders → Inventory → OrderDetails).
2. Run `sql/seed_data.sql` to populate sample data.
3. Run queries from `sql/queries.sql` to explore.

### Application
Setup instructions will be added here once the ASP.NET MVC project is scaffolded (connection string config, migrations if using Entity Framework, etc.).

## Roadmap

- [x] Schema design and seed data
- [x] Reporting queries (customer spend, top sellers)
- [ ] Scaffold ASP.NET MVC project
- [ ] Auth (login against Users table, role-based access via Admin/Customers subtype)
- [ ] Customer-facing CRUD (browse Inventory, place Orders)
- [ ] Admin-facing CRUD (manage Inventory, view all Orders)
