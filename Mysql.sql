/*
Library Management System Database Schema
Author: Dianarose Kessy
Description:
This database manages books, authors, publishers, categories,
library members, and loans. It supports multiple authors per book,
tracks borrowing by members, and enforces data integrity with keys and constraints.
*/

/* -------------------- Table: Categories -------------------- */
CREATE TABLE Categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE COMMENT 'Category name (e.g., Fiction, Science)'
);

/* -------------------- Table: Publishers -------------------- */
CREATE TABLE Publishers (
    publisher_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(150) NOT NULL UNIQUE COMMENT 'Publisher company name',
    address VARCHAR(255) COMMENT 'Publisher address (optional)'
);

/* -------------------- Table: Authors -------------------- */
CREATE TABLE Authors (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE COMMENT 'Full name of author',
    birth_date DATE COMMENT 'Date of birth (optional)'
);

/* -------------------- Table: Books -------------------- */
CREATE TABLE Books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200) NOT NULL COMMENT 'Title of the book',
    category_id INT NOT NULL COMMENT 'Foreign key to Categories',
    publisher_id INT NOT NULL COMMENT 'Foreign key to Publishers',
    publish_year YEAR COMMENT 'Year the book was published',
    isbn VARCHAR(20) UNIQUE COMMENT 'ISBN number (optional, unique)',
    copies INT DEFAULT 1 COMMENT 'Number of copies available in library',
    CONSTRAINT fk_books_category FOREIGN KEY (category_id) REFERENCES Categories(category_id) ON DELETE RESTRICT,
    CONSTRAINT fk_books_publisher FOREIGN KEY (publisher_id) REFERENCES Publishers(publisher_id) ON DELETE RESTRICT
);

/* -------------------- Junction Table: BookAuthors -------------------- */
/* Many-to-Many relationship between Books and Authors */
CREATE TABLE BookAuthors (
    book_id INT NOT NULL,
    author_id INT NOT NULL,
    PRIMARY KEY (book_id, author_id),
    CONSTRAINT fk_ba_book FOREIGN KEY (book_id) REFERENCES Books(book_id) ON DELETE CASCADE,
    CONSTRAINT fk_ba_author FOREIGN KEY (author_id) REFERENCES Authors(author_id) ON DELETE CASCADE
);

/* -------------------- Table: Members -------------------- */
CREATE TABLE Members (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    phone VARCHAR(20),
    membership_date DATE NOT NULL DEFAULT CURRENT_DATE,
    address VARCHAR(255)
);

/* -------------------- Table: Loans -------------------- */
/* Tracks which member borrowed which book and when */
CREATE TABLE Loans (
    loan_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT NOT NULL,
    member_id INT NOT NULL,
    loan_date DATE NOT NULL DEFAULT CURRENT_DATE,
    due_date DATE NOT NULL,
    return_date DATE,
    CONSTRAINT fk_loans_book FOREIGN KEY (book_id) REFERENCES Books(book_id) ON DELETE RESTRICT,
    CONSTRAINT fk_loans_member FOREIGN KEY (member_id) REFERENCES Members(member_id) ON DELETE CASCADE,
    CONSTRAINT chk_due_after_loan CHECK (due_date > loan_date),
    CONSTRAINT chk_return_after_loan CHECK (return_date IS NULL OR return_date >= loan_date)
);
