# Library Management System

## Description
This project is a relational database schema implemented in MySQL for managing a library system. It includes tables for managing books, authors, publishers, categories, members, and loans. The design supports:

- Multiple authors per book (many-to-many relationship)
- Book categorization and publisher tracking
- Member management with contact details
- Loan tracking with due dates and return dates
- Data integrity via primary keys, foreign keys, and constraints

This database can be used as a backend for library management applications or learning purposes.

## How to Set Up and Run

1. Clone this repository:
   ```bash
   git clone https://github.com/yourusername/library-management-system.git
   cd library-management-system
2. Open your MySQL client and create the database:
   ```Sql
   CREATE DATABASE library_db;
   USE library_db;
3. Import the SQL schema file
   ```bash
   source path/to/library_management.sql;
4. The tables will be created with all relationships and constraints.


ERD Diagram
The diagram can be viewed as a png which is attached on this repository with the sql file or 
You can view the diagram online at [https://dbdiagram.io/d/Library-Management-Sytem-682659eb5b2fc4582fd3284d]

Author

Dianarose Kessy
 
