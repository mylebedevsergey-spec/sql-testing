-- Схема для проверки запросов из тестового задания.
-- Писалась под PostgreSQL.

CREATE TABLE categories (
    id serial PRIMARY KEY,
    name text NOT NULL
);

CREATE TABLE products (
    id serial PRIMARY KEY,
    name text NOT NULL,
    category_id integer NOT NULL REFERENCES categories(id),
    price numeric(12, 2) NOT NULL CHECK (price > 0)
);

CREATE TABLE customers (
    id serial PRIMARY KEY,
    full_name text NOT NULL,
    email text NOT NULL UNIQUE
);

CREATE TABLE orders (
    id serial PRIMARY KEY,
    customer_id integer NOT NULL REFERENCES customers(id) ON DELETE RESTRICT,
    order_date date NOT NULL
);

CREATE TABLE order_items (
    order_id integer NOT NULL REFERENCES orders(id) ON DELETE CASCADE,
    product_id integer NOT NULL REFERENCES products(id),
    quantity integer NOT NULL CHECK (quantity > 0),
    price numeric(12, 2) NOT NULL CHECK (price > 0),
    PRIMARY KEY (order_id, product_id)
);

CREATE INDEX IF NOT EXISTS orders_customer_idx ON orders (customer_id);
CREATE INDEX IF NOT EXISTS orders_date_idx ON orders (order_date);
CREATE INDEX IF NOT EXISTS order_items_order_idx ON order_items (order_id);
CREATE INDEX IF NOT EXISTS order_items_product_idx ON order_items (product_id);
CREATE INDEX IF NOT EXISTS products_category_idx ON products (category_id);
