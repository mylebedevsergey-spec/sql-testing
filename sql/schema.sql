-- Схема для тестового задания по SQL (PostgreSQL).
DROP SCHEMA IF EXISTS shop CASCADE;
CREATE SCHEMA shop;
SET search_path TO shop;

CREATE TABLE categories (
    id serial PRIMARY KEY,
    name varchar(80) NOT NULL UNIQUE
);

CREATE TABLE products (
    id serial PRIMARY KEY,
    name varchar(120) NOT NULL,
    category_id integer NOT NULL REFERENCES categories(id),
    price numeric(12,2) NOT NULL CHECK (price > 0)
);

CREATE TABLE customers (
    id serial PRIMARY KEY,
    full_name varchar(120) NOT NULL,
    email varchar(120) NOT NULL UNIQUE
);

CREATE TABLE orders (
    id serial PRIMARY KEY,
    customer_id integer NOT NULL REFERENCES customers(id),
    order_date date NOT NULL
);

CREATE TABLE order_items (
    order_id integer NOT NULL REFERENCES orders(id) ON DELETE CASCADE,
    product_id integer NOT NULL REFERENCES products(id),
    quantity integer NOT NULL CHECK (quantity > 0),
    price numeric(12,2) NOT NULL CHECK (price > 0),
    PRIMARY KEY (order_id, product_id)
);
