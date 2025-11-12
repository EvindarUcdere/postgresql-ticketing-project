# postgresql-ticketing-

Advanced PostgreSQL Ticketing System
This project is a complete backend implementation for a concurrent event ticketing system (e.g., for concerts, theaters, or sports), built entirely within PostgreSQL.

The primary goal of this repository is not just to build a ticketing system, but to serve as a practical learning ground for mastering advanced PostgreSQL features.

Project Goal
This system is designed to move beyond simple SELECT/INSERT commands and explore the "database as a compute engine" paradigm. It serves as a portfolio piece to demonstrate deep understanding of database integrity, concurrency, and performance.

Key Features & Concepts Demonstrated
Complex Data Modeling: Designing a normalized schema from scratch using PRIMARY KEYs, FOREIGN KEYs, CHECK constraints, and multi-column UNIQUE constraints to enforce data integrity at the lowest level.

PL/pgSQL Stored Procedures & Functions: Moving critical business logic (like finding available seats or calculating revenue) from the application layer into the database itself for performance and consistency.

Database Triggers: Using BEFORE and AFTER triggers to automatically enforce complex business rules (e.g., preventing invalid bookings) and create audit logs (e.g., logging customer email changes).

ACID Transactions: Building atomic functions (like fn_buy_ticket) that guarantee a booking either succeeds or fails as a complete unit, ensuring data never becomes inconsistent.

Concurrency & Isolation: Designing a system that can handle multiple users trying to book the same seat at the same time, using PostgreSQL's transaction isolation and locking mechanisms.

Performance & Optimization: Using EXPLAIN ANALYZE to identify performance bottlenecks (like Seq Scan) and resolving them with proper INDEXing.


├── sql\
│   ├── 1_schema       # Database structure (Tables, Constraints)\
│   ├── 2_functions    # Business logic (Stored Procedures)\
│   ├── 3_triggers     # Automated actions & validation (Triggers)\
│   └── _data          # Sample data for testing\
├──api\
|
└── README.md           # This file\

How to Set Up and Run
Create a Database: Create a new, empty PostgreSQL database (e.g., ticket_system_db).

Run the Schema: Execute the SQL file(s) in the sql/1_schema/ directory. This will build the tables.

Run the Functions: Execute the SQL file(s) in the sql/2_functions/ directory.

Run the Triggers: Execute the SQL file(s) in the sql/3_triggers/ directory.

(Optional) Add Data: Run the SQL file(s) in sql/_data/ to populate the database with sample data for testing.
