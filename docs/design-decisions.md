# Design Decisions

Notes on the reasoning behind key structural choices in this schema — useful
for explaining the design later, or revisiting the thinking on a future project.

## 1. Users / Admin / Customers subtype split

**Problem:** Admin and Customers both need authentication (login), but each
also has role-specific data that doesn't apply to the other (Admin has
PermissionLevel; Customers have ShippingAddress, ContactNumber, etc.).

**Options considered:**
- One single table with all columns for every role (rejected — lots of
  nullable columns that don't apply depending on role).
- One table with a `role` column, no subtype tables (rejected for this
  project — creates two sources of truth: the role column, and whichever
  subtype table has a matching row. These can drift out of sync unless
  carefully enforced in application logic).
- **Chosen: supertype/subtype split.** Users holds shared login data.
  Customers and Admin each hold only their role-specific columns, linked
  1:1 back to Users by reusing UserID as both PK and FK.

**Why this wins:** role is *implied* by which subtype table has a matching
row — there's no redundant flag that could ever contradict reality. It's
structurally impossible to have an Admin row for someone not meant to be
an admin.

**Trade-off accepted:** looking up "what role does this user have" requires
a join or an EXISTS check rather than a single column read. Acceptable at
this scale (a handful of users, no performance pressure).

## 2. Reusing UserID as PK/FK on Customers and Admin (not a separate CustomerID/AdminID)

Originally used separate auto-incrementing IDs (`CustomerID`, `AdminID`).
Changed to reuse `UserID` directly so it's visually unambiguous, at the
schema level, that these rows are the *same person* as a row in Users —
not just related by name convention.

**Practical consequence:** Customers and Admin are NOT IDENTITY columns.
Insert order matters — a User row must be created first to generate the
ID, then that same ID is used for the Customers or Admin insert.

## 3. OrderDetails composite primary key

**Problem:** One order can contain many products, and one product can
appear across many orders — a many-to-many relationship that a direct
Orders↔Inventory link can't represent.

**Chosen:** OrderDetails as a junction table, with a composite primary key
of `(OrderID, ProductID)` rather than a standalone surrogate ID.

**Why:** the combination of OrderID + ProductID is naturally unique — an
inventory item should only appear once per order (repeat purchases within
one order are represented by increasing `Quantity`, not by duplicate rows).
A composite PK enforces this as a database constraint, not just an
application-level assumption. A surrogate key would have allowed duplicate
(OrderID, ProductID) pairs unless a separate UNIQUE constraint was added
to compensate.

## 4. PriceAtTimeOfOrder stored separately from Inventory.CurrentPrice

If OrderDetails referenced `Inventory.CurrentPrice` directly, updating a
product's price later would silently rewrite the value of historical
orders. Storing `PriceAtTimeOfOrder` on OrderDetails locks in the price at
the moment of purchase, independent of catalog price changes.

## 5. Project scope: single-vendor B2C retail

Deliberately kept simple — no multi-vendor marketplace, no subscriptions,
no digital-goods delivery tracking. The goal of this project was practicing
core relational patterns (subtyping, M:M resolution, composite keys), not
building out a full commerce platform. Those patterns would each need their
own schema extensions if this were scoped up later.
