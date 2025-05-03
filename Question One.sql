Question 1: Full-Featured MySQL Database – Library Management System
🧩 Use Case: Library Management System
🗃️ Tables:
Books – stores book details.

Authors – stores author details.

Members – stores library member details.

Loans – tracks books borrowed by members.

Categories – categorizes books.

BookAuthors – for many-to-many between Books and Authors.

-------------------------------------------------------------------------------------------------

-- Create the database
CREATE DATABASE IF NOT EXISTS LibraryDB;
USE LibraryDB;

-- Authors
CREATE TABLE Authors (
    AuthorID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Bio TEXT
);

-- Categories
CREATE TABLE Categories (
    CategoryID INT AUTO_INCREMENT PRIMARY KEY,
    CategoryName VARCHAR(50) NOT NULL UNIQUE
);

-- Books
CREATE TABLE Books (
    BookID INT AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(255) NOT NULL,
    ISBN VARCHAR(20) NOT NULL UNIQUE,
    CategoryID INT,
    PublishedYear YEAR,
    CopiesAvailable INT DEFAULT 0,
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);

-- BookAuthors (Many-to-Many)
CREATE TABLE BookAuthors (
    BookID INT,
    AuthorID INT,
    PRIMARY KEY (BookID, AuthorID),
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID)
);

-- Members
CREATE TABLE Members (
    MemberID INT AUTO_INCREMENT PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    MembershipDate DATE NOT NULL
);

-- Loans
CREATE TABLE Loans (
    LoanID INT AUTO_INCREMENT PRIMARY KEY,
    BookID INT,
    MemberID INT,
    LoanDate DATE NOT NULL,
    ReturnDate DATE,
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
);

-- Sample Data
INSERT INTO Authors (Name, Bio) VALUES
('J.K. Rowling', 'British author known for Harry Potter series'),
('George Orwell', 'Author of 1984 and Animal Farm');

INSERT INTO Categories (CategoryName) VALUES
('Fantasy'), ('Science Fiction'), ('Non-Fiction');

INSERT INTO Books (Title, ISBN, CategoryID, PublishedYear, CopiesAvailable) VALUES
('Harry Potter and the Sorcerer\'s Stone', '9780439708180', 1, 1997, 5),
('1984', '9780451524935', 2, 1949, 3);

INSERT INTO BookAuthors (BookID, AuthorID) VALUES
(1, 1),
(2, 2);

INSERT INTO Members (FullName, Email, MembershipDate) VALUES
('Alice Smith', 'alice@example.com', CURDATE()),
('Bob Johnson', 'bob@example.com', CURDATE());

INSERT INTO Loans (BookID, MemberID, LoanDate, ReturnDate) VALUES
(1, 1, CURDATE(), NULL),
(2, 2, CURDATE(), NULL);
