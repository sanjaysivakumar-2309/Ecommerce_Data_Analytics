USE Amazon;

-- ============================================
-- E-COMMERCE DATA ANALYSIS
-- Basic Business Analysis
-- ============================================

-- 1. Total Revenue
SELECT
    SUM(quantity * unit_price) AS total_revenue
FROM order_items;


-- 2. Total Orders
SELECT
    COUNT(order_id) AS total_orders
FROM orders;


-- 3. Average Order Value (AOV)
SELECT
    AVG(order_total) AS average_order_value
FROM (
    SELECT
        order_id,
        SUM(quantity * unit_price) AS order_total
    FROM order_items
    GROUP BY order_id
) AS order_totals;


-- 4. Unique Customers
SELECT
    COUNT(DISTINCT customer_id) AS unique_customers
FROM orders;


-- 5. Total Units Sold
SELECT
    SUM(quantity) AS total_units_sold
FROM order_items;


-- 6. Revenue by Order Status
SELECT
    o.order_status,
    SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM orders AS o
JOIN order_items AS oi
    ON o.order_id = oi.order_id
GROUP BY o.order_status
ORDER BY total_revenue DESC;


-- 7. Orders by Order Status
SELECT
    order_status,
    COUNT(order_id) AS order_count
FROM orders
GROUP BY order_status
ORDER BY order_count DESC;


-- 8. Revenue by Category
SELECT
    c.category_name,
    SUM(oi.quantity * oi.unit_price) AS revenue
FROM order_items AS oi
JOIN products AS p
    ON oi.product_id = p.product_id
JOIN categories AS c
    ON p.category_id = c.category_id
GROUP BY c.category_name
ORDER BY revenue DESC;

-- ============================================
-- PRODUCT & CUSTOMER ANALYSIS
-- ============================================

-- 9. Top 10 Products by Revenue
SELECT
    p.product_id,
    p.product_name,
    SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM products AS p
JOIN order_items AS oi
    ON p.product_id = oi.product_id
GROUP BY
    p.product_id,
    p.product_name
ORDER BY total_revenue DESC
LIMIT 10;


-- 10. Revenue by State
SELECT
    o.shipping_state,
    SUM(oi.quantity * oi.unit_price) AS revenue
FROM orders AS o
JOIN order_items AS oi
    ON o.order_id = oi.order_id
GROUP BY o.shipping_state
ORDER BY revenue DESC;


-- 11. Top 10 Customers by Spending
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    SUM(oi.quantity * oi.unit_price) AS total_spending
FROM customers AS c
JOIN orders AS o
    ON c.customer_id = o.customer_id
JOIN order_items AS oi
    ON o.order_id = oi.order_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name
ORDER BY total_spending DESC
LIMIT 10;


-- 12. Repeat Customers
SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    COUNT(o.order_id) AS order_count
FROM customers AS c
JOIN orders AS o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name)
HAVING COUNT(o.order_id) > 1
ORDER BY order_count DESC;

-- 13. Top 10 Products by Profit
SELECT
    p.product_id,
    p.product_name,
    SUM(
        (oi.unit_price - p.cost) * oi.quantity
    ) AS total_profit
FROM products AS p
JOIN order_items AS oi
    ON p.product_id = oi.product_id
GROUP BY
    p.product_id,
    p.product_name
ORDER BY total_profit DESC
LIMIT 10;

-- 14. Profit by Category
SELECT
    c.category_id,
    c.category_name,
    SUM(
        (oi.unit_price - p.cost) * oi.quantity
    ) AS total_profit
FROM categories AS c
JOIN products AS p
    ON c.category_id = p.category_id
JOIN order_items AS oi
    ON p.product_id = oi.product_id
GROUP BY
    c.category_id,
    c.category_name
ORDER BY total_profit DESC;


-- 15. Profit by Product
SELECT
    p.product_id,
    p.product_name,
    SUM(
        (oi.unit_price - p.cost) * oi.quantity
    ) AS total_profit
FROM products AS p
JOIN order_items AS oi
    ON p.product_id = oi.product_id
GROUP BY
    p.product_id,
    p.product_name
ORDER BY total_profit DESC;

-- 19. Average Order Value by Customer Segment
SELECT
    c.customer_segment,
    AVG(ot.order_total) AS average_order_value
FROM customers AS c
JOIN orders AS o
    ON c.customer_id = o.customer_id
JOIN (
    SELECT
        order_id,
        SUM(quantity * unit_price) AS order_total
    FROM order_items
    GROUP BY order_id
) AS ot
    ON o.order_id = ot.order_id
GROUP BY c.customer_segment
ORDER BY average_order_value DESC;


-- 20. Revenue by Customer Segment
SELECT
    c.customer_segment,
    SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM customers AS c
JOIN orders AS o
    ON c.customer_id = o.customer_id
JOIN order_items AS oi
    ON o.order_id = oi.order_id
GROUP BY c.customer_segment
ORDER BY total_revenue DESC;


-- 21. Orders by Customer Segment
SELECT
    c.customer_segment,
    COUNT(o.order_id) AS order_count
FROM customers AS c
JOIN orders AS o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_segment
ORDER BY order_count DESC;

-- 22. Monthly Revenue
SELECT
    YEAR(o.order_date) AS order_year,
    MONTH(o.order_date) AS order_month,
    SUM(oi.quantity * oi.unit_price) AS revenue
FROM orders AS o
JOIN order_items AS oi
    ON o.order_id = oi.order_id
GROUP BY
    YEAR(o.order_date),
    MONTH(o.order_date)
ORDER BY
    order_year,
    order_month;
    
-- 23. Month-over-Month Revenue Growth
WITH monthly_revenue AS (
    SELECT
        YEAR(o.order_date) AS order_year,
        MONTH(o.order_date) AS order_month,
        SUM(oi.quantity * oi.unit_price) AS revenue
    FROM orders AS o
    JOIN order_items AS oi
        ON o.order_id = oi.order_id
    GROUP BY
        YEAR(o.order_date),
        MONTH(o.order_date)
),

revenue_with_previous AS (
    SELECT
        order_year,
        order_month,
        revenue,
        LAG(revenue) OVER (
            ORDER BY order_year, order_month
        ) AS previous_month_revenue
    FROM monthly_revenue
)

SELECT
    order_year,
    order_month,
    revenue,
    previous_month_revenue,
    ROUND(
        (
            (revenue - previous_month_revenue)
            / NULLIF(previous_month_revenue, 0)
        ) * 100,
        2
    ) AS mom_growth_percentage
FROM revenue_with_previous
ORDER BY
    order_year,
    order_month;

-- 24. Top 3 Products by Revenue in Each Category
WITH product_revenue AS (
    SELECT
        c.category_id,
        c.category_name,
        p.product_id,
        p.product_name,
        SUM(oi.quantity * oi.unit_price) AS revenue
    FROM categories AS c
    JOIN products AS p
        ON c.category_id = p.category_id
    JOIN order_items AS oi
        ON p.product_id = oi.product_id
    GROUP BY
        c.category_id,
        c.category_name,
        p.product_id,
        p.product_name
),
ranked_products AS (
    SELECT
        category_name,
        product_id,
        product_name,
        revenue,
        RANK() OVER (
            PARTITION BY category_name
            ORDER BY revenue DESC
        ) AS product_rank
    FROM product_revenue
)
SELECT
    category_name,
    product_id,
    product_name,
    revenue,
    product_rank
FROM ranked_products
WHERE product_rank <= 3
ORDER BY
    category_name,
    product_rank;