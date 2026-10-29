-- Пять запросов из тестового задания.
SET search_path TO shop;

-- 1. Клиенты с заказами в текущем месяце, по убыванию суммы.
SELECT c.id, c.full_name, SUM(oi.quantity * oi.price) AS total
  FROM customers c
  JOIN orders o ON o.customer_id = c.id
  JOIN order_items oi ON oi.order_id = o.id
 WHERE date_trunc('month', o.order_date) = date_trunc('month', CURRENT_DATE)
 GROUP BY c.id, c.full_name
 ORDER BY total DESC;

-- 2. Товары дороже средней цены своей категории, по возрастанию цены.
WITH avg_price AS (
    SELECT category_id, AVG(price) AS avg_price
      FROM products
     GROUP BY category_id
)
SELECT p.id, p.name, p.price, cat.name AS category, ROUND(a.avg_price, 2) AS category_avg
  FROM products p
  JOIN avg_price a ON a.category_id = p.category_id
  JOIN categories cat ON cat.id = p.category_id
 WHERE p.price > a.avg_price
 ORDER BY p.price ASC;

-- 3. Заказы с товарами из категории «Электроника», по дате заказа.
SELECT DISTINCT o.id, o.order_date, c.full_name
  FROM orders o
  JOIN customers c ON c.id = o.customer_id
  JOIN order_items oi ON oi.order_id = o.id
  JOIN products p ON p.id = oi.product_id
  JOIN categories cat ON cat.id = p.category_id
 WHERE cat.name = 'Электроника'
 ORDER BY o.order_date ASC;

-- 4. Клиенты без заказов в прошлом году, по алфавиту.
SELECT c.id, c.full_name
  FROM customers c
 WHERE NOT EXISTS (
       SELECT 1 FROM orders o
        WHERE o.customer_id = c.id
          AND date_trunc('year', o.order_date) = date_trunc('year', CURRENT_DATE - INTERVAL '1 year')
 )
 ORDER BY c.full_name ASC;

-- 5. Товары, которые ни разу не заказывали, по названию.
SELECT p.id, p.name
  FROM products p
 WHERE NOT EXISTS (SELECT 1 FROM order_items oi WHERE oi.product_id = p.id)
 ORDER BY p.name ASC;
