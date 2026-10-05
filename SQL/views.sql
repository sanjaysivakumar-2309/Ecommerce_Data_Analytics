USE Amazon;

USE Amazon;

--  Monthly Revenue
CREATE VIEW vw_monthly_revenue AS
SELECT
    YEAR(o.order_date) AS order_year,
    MONTH(o.order_date) AS order_month,
    SUM(oi.quantity * oi.unit_price) AS revenue
FROM orders AS o
JOIN order_items AS oi
    ON o.order_id = oi.order_id
GROUP BY
    YEAR(o.order_date),
    MONTH(o.order_date);
    
-- Category Performance
CREATE VIEW vw_category_performance AS
SELECT
    c.category_id,
    c.category_name,
    SUM(oi.quantity * oi.unit_price) AS revenue,
    SUM(
        (oi.unit_price - p.cost) * oi.quantity
    ) AS profit
FROM categories AS c
JOIN products AS p
    ON c.category_id = p.category_id
JOIN order_items AS oi
    ON p.product_id = oi.product_id
GROUP BY
    c.category_id,
    c.category_name;
    
-- Customer Spending
CREATE VIEW vw_customer_spending AS
SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    COUNT(o.order_id) AS order_count,
    SUM(oi.quantity * oi.unit_price) AS total_spending
FROM customers AS c
JOIN orders AS o
    ON c.customer_id = o.customer_id
JOIN order_items AS oi
    ON o.order_id = oi.order_id
GROUP BY
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name);

-- Product Performance
CREATE VIEW vw_product_performance AS
SELECT
    p.product_id,
    p.product_name,
    SUM(oi.quantity * oi.unit_price) AS revenue,
    SUM(
        (oi.unit_price - p.cost) * oi.quantity
    ) AS profit,
    SUM(oi.quantity) AS units_sold
FROM products AS p
JOIN order_items AS oi
    ON p.product_id = oi.product_id
GROUP BY
    p.product_id,
    p.product_name;

-- Seller Performance
CREATE VIEW vw_seller_performance AS
SELECT
    s.seller_id,
    s.seller_name,
    SUM(oi.quantity * oi.unit_price) AS revenue,
    SUM(
        (oi.unit_price - p.cost) * oi.quantity
    ) AS profit,
    SUM(oi.quantity) AS units_sold
FROM sellers AS s
JOIN products AS p
    ON s.seller_id = p.seller_id
JOIN order_items AS oi
    ON p.product_id = oi.product_id
GROUP BY
    s.seller_id,
    s.seller_name;

