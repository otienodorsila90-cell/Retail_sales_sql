 --Section A — SQL fundamentals — Retrieve all customer records.
 set search_path to duka_smart_electronics;

 select * from orders limit 5;
 select * from customers limit 5;
  --Q1  Retrieve all customer records.
 select * from customers;

--Q2Display customer names, cities, and segments.
 select  customer_name,city,customer_segment
 from customers;
--Q3 Find customers living in Nairobi.
 select customer_name,city 
 from customers
 where city = 'Nairobi';
--Q4Find customers registered after January 1, 2025.
 select customer_name,registration_date
 from customers
 where registration_date > '2025-01-01';
--Q5 Display all unique customer cities.
 select distinct(city) from customers;
--Q6 Retrieve the 10 most recent orders.
 select order_id,product_name,order_date from orders
 order by order_date desc
 limit 10;
 
--Q7 Find orders with unit prices above KSh 10,000.
 select order_id,product_name,unit_price 
 from orders
 where unit_price > 10000;

--Q8 Find customers whose names start with A.
select customer_name
from customers c ;
--Q9 Retrieve orders with quantities between 2 and 5.
select * from orders
where quantity between 2 and 5;

--Q10 Find orders paid through M-Pesa.
select order_id,product_name,payment_method
from orders
where payment_method='M-Pesa';

--Section B — Aggregation and grouping —
--Q11 Count all customers.
select count(customer_id) from customers;
--Q12 Count all orders.
select count(order_id) from orders;
--Q13 Calculate completed-order revenue.
select ROUND(SUM(quantity * unit_price * (1 - discount / 100)), 2) AS completed_revenue
 from orders
 where order_status ='Completed';
--Q14 Calculate the average completed-order value.
select ROUND(avg(quantity * unit_price * (1 - discount / 100)), 2) as avg_completed_revenue
from orders
WHERE order_status = 'Completed';
--Q15 Find the highest and lowest product prices.
select max(unit_price) as highest_product_price,min(unit_price) as lowest_product_price from orders;
--Q16 Calculate revenue by product category.
select product_category, ROUND(SUM(quantity * unit_price * (1 - discount / 100)), 2) as total_revenue
from orders
group by product_category 
order by total_revenue;
--Q17 Count customers by city.
select city,count(*)
from customers c 
group by c.city order by count(*);
--Q18 calculate quantity sold by product
select * from orders;
select sum(quantity)
from orders
where order_status ='Completed';
--Q19 Find categories generating more than KSh 100,000 in revenue.
select product_category,ROUND(sum(quantity * unit_price * (1 - discount / 100)), 2) as total_revenue
from orders
group by product_category
having ROUND(sum(quantity * unit_price * (1 - discount / 100)), 2)> 100000;
--Q20 Calculate the percentage of cancelled orders.

select COUNT(*) FILTER (WHERE order_status = 'Cancelled') AS cancelled_orders, COUNT(*) AS total_orders,
ROUND(COUNT(*) FILTER (WHERE order_status = 'Cancelled') * 100.0 / NULLIF(COUNT(*), 0), 2) AS cancellation_percentage
FROM orders;

--Section C — Joins and customer analytics — 
--Q21 Display orders with customer names and cities.
select c.customer_name,c.city,o.order_id,o.product_name
from customers c
join orders o on c.customer_id=o.customer_id;
select * from orders;
--Q22 Calculate total spending by customer.
select * from customers;
select * from orders;
select c.customer_id,c.customer_name,(o.unit_price*o.quantity)as total_spending
from customers c
join orders o on c.customer_id=o.customer_id ;

--Q23 Identify customers who have never ordered.
select c.customer_id,c.customer_name,o.order_id
from customers c
full join orders o on c.customer_id=o.customer_id 
where order_id is null;

--Q24 Find the 10 highest-spending customers.
select c.customer_name,c.customer_id,(o.quantity*o.unit_price)as total_spent
from customers c
join orders o on c.customer_id=o.customer_id 
group by c.customer_name,c.customer_id,total_spent
order by total_spent desc
limit 10;


--Q25 Calculate revenue by customer city.
select c.city,sum(o.quantity*o.unit_price) as revenue
from customers c
join orders o on c.customer_id=o.customer_id
group by c.city;
--Q26 Identify customers with more than five orders.
select c.customer_id,c.customer_name,count(o.order_id) as total_orders
from customers c
join orders o on c.customer_id = o. customer_id 
group by c.customer_id,c.customer_name
having count(o.order_id) > 5
order by total_orders,c.customer_name;

--Q27 Calculate average customer spending by segment.
select c.customer_segment,round(avg(o.quantity*o.unit_price),2)as average_spent
from customers c 
join orders o on c.customer_id=o.customer_id 
group by c.customer_segment;


--Q28 Identify the most popular category among VIP customers.
select o.product_category,COUNT(*) AS total_orders
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
WHERE c.customer_segment = 'VIP'
GROUP BY o.product_category
ORDER BY total_orders DESC
LIMIT 1;

--Section D — Subqueries and CTEs —
--Q29 Find customers spending above the average total spending per purchasing customer.
select c.customer_id,c.customer_name,sum(o.quantity*o.unit_price) as total_spent
from customers c
join orders o on c.customer_id=o.customer_id
group by c.customer_name,c.customer_id
having sum(o.quantity*o.unit_price)  >(select avg(o.quantity*o.unit_price) from orders o)
order by total_spent;

--Q30 Find products priced above the overall average unit price.
select product_name,unit_price
from orders
where unit_price > (select avg(unit_price) from orders);
--Q31 Use a CTE to identify the three highest-revenue months.
WITH monthly_revenue AS (
SELECT DATE_TRUNC('month', order_date) AS revenue_month, SUM(quantity * unit_price * (1 - discount / 100)) AS total_revenue
FROM orders
where order_status = 'Completed'
GROUP BY DATE_TRUNC('month', order_date))
SELECT revenue_month,total_revenue
FROM monthly_revenue
ORDER BY total_revenue DESC
LIMIT 3;
select * from customers;
select * from orders;
--Q32 Find customers purchasing from at least three categories.
select c.customer_name,o.product_category,count(DISTINCT o.product_category) AS unique_categories_purchased
from customers c 
join orders o on c.customer_id=o.customer_id
group by c.customer_name,o.product_category
having count(DISTINCT o.product_category) >= 3;

--Q33 Use a CTE to calculate category revenue, cost, profit, and profit margin
WITH order_base AS (
    SELECT product_category,(quantity * unit_price * (1.0 - discount / 100.0)) AS revenue, (quantity * cost_price) AS cost
    FROM orders
    WHERE  order_status = 'Completed'),
category_totals AS (
    SELECT 
        product_category,
        SUM(revenue) AS total_revenue,
        SUM(cost) AS total_cost,
        SUM(revenue) - SUM(cost) AS total_profit
    FROM order_base
    GROUP BY product_category)
SELECT 
    product_category,
    total_revenue,
    total_cost,
    total_profit,
    ROUND( (total_profit / NULLIF(total_revenue, 0)) * 100,2) AS profit_margin_pct
FROM 
    category_totals;
--Q34 Find customers whose latest completed order is more than 90 days before the latest order date in the dataset
SELECT
    c.customer_id,
    c.customer_name,
    MAX(o.order_date) AS latest_completed_order
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
WHERE o.order_status = 'Completed'
GROUP BY c.customer_id, c.customer_name
HAVING MAX(o.order_date) < (SELECT MAX(order_date) - INTERVAL '90 days'
FROM orders)
ORDER BY latest_completed_order ASC;
--Section E — Window functions 
--Q35  Rank customers by spending using RANK().
select c.customer_name,(o.unit_price*o.quantity) as customer_spending,rank()over(order by o.unit_price*o.quantity) as customer_rank
from customers c
join orders o on c.customer_id = o.customer_id;
--Q36 Number each customer's orders by recency using ROW_NUMBER().
select * from orders;
select c.customer_name,o.order_id,row_number()over(order by o.order_id)
from customers c
join orders o on c.customer_id=o.customer_id;
--Q37 Rank products within categories using DENSE_RANK().
select * from orders;
select product_category,dense_rank()over(partition by product_category)
from orders;
--Q38 Calculate cumulative monthly revenue.
WITH monthly_revenue AS ( SELECT DATE_TRUNC('month', order_date)::DATE AS sales_month, SUM( quantity * unit_price * (1 - discount / 100.0)
 ) AS monthly_revenue
 FROM orders
 WHERE order_status = 'Completed'
 GROUP BY DATE_TRUNC('month', order_date))
select sales_month, ROUND(monthly_revenue, 2) AS monthly_revenue,ROUND(SUM(monthly_revenue) OVER (ORDER BY sales_month),2) AS cumulative_revenue
FROM monthly_revenue
ORDER BY sales_month;
--Q39 Compare monthly revenue using LAG().
select * from orders;
SELECT
    DATE_TRUNC('month', order_date) AS month,
    SUM(quantity * unit_price) AS monthly_revenue,
    LAG(SUM(quantity * unit_price)) OVER (
        ORDER BY DATE_TRUNC('month', order_date)
    ) AS previous_month_revenue
FROM orders
WHERE order_status = 'Completed'
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY month;
--Q40 Calculate month-over-month revenue growth (%).
WITH monthly_revenue AS (
    SELECT
        DATE_TRUNC('month', order_date) AS month,
        SUM(quantity * unit_price) AS revenue
    FROM orders
    WHERE order_status = 'Completed'
    GROUP BY DATE_TRUNC('month', order_date)
)
SELECT
    TO_CHAR(month, 'YYYY-MM') AS month,
    revenue,
    LAG(revenue) OVER (ORDER BY month) AS previous_month_revenue,
    ROUND(
        ((revenue - LAG(revenue) OVER (ORDER BY month))
        / NULLIF(LAG(revenue) OVER (ORDER BY month), 0)) * 100,
        2
    ) AS mom_growth_percentage
FROM monthly_revenue
ORDER BY month;

--Q41 Divide customers into four spending groups using NTILE(4).
select * from customers;select * from orders;
select c.customer_name,(o.quantity*o.unit_price) as customer_spending,ntile(4)over(order by o.quantity*o.unit_price) as spending_category
from customers c 
join orders o on c.customer_id=o.customer_id;
--Q42 calculate each category's share of total revenue using windows function
SELECT product_category, SUM(quantity * unit_price * (1 - discount / 100.0)) AS category_revenue,
ROUND(SUM(quantity * unit_price * (1 - discount / 100.0))/ 
NULLIF(SUM(SUM(quantity * unit_price * (1 - discount / 100.0))) OVER (), 0) * 100, 2 ) AS revenue_percentage
FROM orders
WHERE order_status = 'Completed'
GROUP BY product_category
ORDER BY revenue_percentage DESC;
--SECTION F
--Q43 Create a `monthly_sales_summary` view (month, orders, revenue, cost, profit). Then `SELECT` from it.
CREATE OR REPLACE VIEW monthly_sales_summary AS
SELECT
    DATE_TRUNC('month', order_date)::DATE AS month,
    COUNT(*) AS total_orders,
    SUM(quantity * unit_price * (1 - discount / 100.0)) AS revenue,
    SUM(quantity * cost_price) AS cost,
    SUM(
        (quantity * unit_price * (1 - discount / 100.0))
        - (quantity * cost_price)
    ) AS profit
FROM orders
WHERE order_status = 'Completed'
GROUP BY DATE_TRUNC('month', order_date);
select * from monthly_sales_summary;
--Q44 Create a PostgreSQL function that returns completed-order revenue for a supplied customer ID. Show it working for one customer and for an ID that does not exist (it should return 0, not NULL).
CREATE OR REPLACE FUNCTION customer_revenue(p_customer_id INTEGER)
RETURNS NUMERIC
LANGUAGE plpgsql
AS $$
DECLARE
    total_revenue NUMERIC;
BEGIN
    SELECT COALESCE(
        SUM(quantity * unit_price * (1 - discount / 100.0)),
        0
    )
    INTO total_revenue
    FROM orders
    WHERE customer_id = p_customer_id
      AND order_status = 'Completed';

    RETURN total_revenue;
END;
$$;
SELECT customer_revenue(1) AS total_revenue;
--Q45 Segment customers into High, Medium and Low Value. **Explain why you chose your thresholds — for example percentiles, or round KSh amounts based on what the data looks like.
WITH customer_spending AS (
    select c.customer_id, c.customer_name,SUM( o.quantity * o.unit_price * (1 - o.discount / 100.0)) AS total_spending
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    WHERE o.order_status = 'Completed'
    GROUP BY c.customer_id, c.customer_name)
SELECT
    customer_id,
    customer_name,
    total_spending,
    CASE WHEN total_spending >= 100000 THEN 'High Value' WHEN total_spending >= 50000 THEN 'Medium Value' ELSE 'Low Value'
    END AS customer_category
FROM customer_spending
ORDER BY total_spending DESC;
-- Q46 Produce a management report: the top five customers, top five products, the most profitable category, and the lowest-revenue month.
--Top five customers
select c.customer_id,c.customer_name,SUM(o.quantity * o.unit_price * (1 - o.discount / 100.0)) AS total_revenue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_status = 'Completed'
GROUP BY c.customer_id, c.customer_name
ORDER BY total_revenue DESC
LIMIT 5;
-- Top five products
select product_name,SUM(quantity) AS total_quantity_sold, SUM( quantity * unit_price * (1 - discount / 100.0)) AS total_revenue
FROM orders
WHERE order_status = 'Completed'
GROUP BY product_name
ORDER BY total_revenue DESC
LIMIT 5;
--Most profitable category
SELECT product_category,SUM(quantity * unit_price * (1 - discount / 100.0)- quantity * cost_price) AS total_profit
FROM orders
WHERE order_status = 'Completed'
GROUP BY product_category
ORDER BY total_profit DESC
LIMIT 1;
--Lowest revenue month
SELECT
    DATE_TRUNC('month', order_date)::DATE AS sales_month,
    SUM(
        quantity * unit_price * (1 - discount / 100.0)
    ) AS total_revenue
FROM orders
WHERE order_status = 'Completed'
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY total_revenue ASC
LIMIT 1;