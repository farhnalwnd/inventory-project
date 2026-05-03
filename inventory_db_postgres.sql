-- PostgreSQL Database Schema for Inventory Management System
-- Database name: inventory_db

-- Table: login
CREATE TABLE IF NOT EXISTS login (
    username VARCHAR(100) PRIMARY KEY,
    email VARCHAR(150),
    password VARCHAR(100) NOT NULL
);

-- Table: addproduct (Inventory Items)
CREATE TABLE IF NOT EXISTS addproduct (
    item_id VARCHAR(50) PRIMARY KEY,
    item_name VARCHAR(150) NOT NULL,
    quantity INTEGER NOT NULL,
    price NUMERIC(15, 2) NOT NULL,
    mfd VARCHAR(50),
    expd VARCHAR(50),
    batch_no VARCHAR(50)
);

-- Table: cart (Temporary cart for purchasing)
CREATE TABLE IF NOT EXISTS cart (
    id SERIAL PRIMARY KEY,
    item_id VARCHAR(50),
    item_name VARCHAR(150),
    quantity INTEGER,
    price NUMERIC(15, 2),
    totprice NUMERIC(15, 2)
);

-- Table: billmain (Sales / Bill records)
CREATE TABLE IF NOT EXISTS billmain (
    id SERIAL PRIMARY KEY,
    bill_no VARCHAR(50),
    item_id VARCHAR(50),
    item_name VARCHAR(150),
    quantity INTEGER,
    price NUMERIC(15, 2),
    totprice NUMERIC(15, 2),
    date VARCHAR(50)
);

-- Insert a default admin user so you can login immediately
INSERT INTO login (username, email, password) 
VALUES ('admin', 'admin@example.com', 'admin')
ON CONFLICT (username) DO NOTHING;
