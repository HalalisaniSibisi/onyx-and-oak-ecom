# Entity Relationship Diagram

```
Users
├── PK  UserID
│      Email
│      HashedPassword
│
├──(1:1)──> Customers
│           PK/FK  UserID  (references Users.UserID)
│                  FirstName
│                  LastName
│                  ShippingAddress
│                  ContactNumber
│
└──(1:1)──> Admin
            PK/FK  UserID  (references Users.UserID)
                   PermissionLevel


Customers ──(1:many)──> Orders
Orders
├── PK  OrderID
├── FK  UserID  (references Customers.UserID)
│      OrderDate


Orders ──(1:many)──> OrderDetails
Inventory ──(1:many)──> OrderDetails

OrderDetails
├── PK/FK  OrderID     (references Orders.OrderID)
├── PK/FK  ProductID   (references Inventory.ProductID)
│          Quantity
│          PriceAtTimeOfOrder

Inventory
├── PK  ProductID
│      Description
│      CurrentPrice
```

## Relationship Summary

| Relationship | Type | Notes |
|---|---|---|
| Users ↔ Customers | 1:1 | Customer is a subtype of User |
| Users ↔ Admin | 1:1 | Admin is a subtype of User |
| Customers → Orders | 1:many | One customer places many orders |
| Orders → OrderDetails | 1:many | One order has many line items |
| Inventory → OrderDetails | 1:many | One product appears in many line items |

No direct relationship exists between Orders and Inventory — the many-to-many
between them is resolved entirely through OrderDetails.
