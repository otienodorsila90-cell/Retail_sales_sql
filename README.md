# INTRODUCTION

This project focuses on analysing retail sales and customer data for Duka smart electronics,a fictional Kenyan retail shop that sells phones,laptops,accessories televisions and home appliances across ten towns in Kenya.The company has been operating since January 2025 and maintains records of its sales transactions in a database.However management needs a better understanding of its sales performance,customer purchasing behaviour and product profitability.I used PostgresSQL to explore the company's retail database,perform data analysis and generate meaningful business insights to support management decision making

# OBJECTIVES

The main objectives of this business was to:
- Analyze overall sales performance and revenue trends
- Identify the company's best performing customers
- Evaluate product performance and profitability
- Examine customer purchasing behaviour and retention
- Identify important business trends and generate actionable insights
# Tools used
- **PostgresSQL** -For database management and SQL analysis
- **pgAdmin** -Database interaction and query execution
- **Dbeaver**
- **Git and Github** -Git was used for version control ,while github was used to store and publicly share the completed project files.
# Database design and structure
A relational database was designed to organize customer informationabout individuals and business purchasing products from Duka smart Electronics
## Customer table
This table stored information about customers and business purchasing products from the retail shop.The table contained the following 
fields : 
- customer_id which uniquely identified each customer
- customer_name Stored the customer names
- gender Recorded the customer gender either male or female
- City Identified the customers location
- Registration_date Recorded the date the customer registered
- Customer_segment Classified customers into retail ,corporate and VIP segments
## Orders table
This table stored information about sales transactions made by customers.
The table contained the following fields
- Order_id ;Uniquely identified each order
- customer_id ;Linked each order to the corresponding customer
- order_date ;Recorded the date the order was made
- product_name;Identified the purchased product
- product_category; Classified products into different categories
- quantity;Recorded the number of products purchased
- unit_price; Stored the selling price of each product
- cost_price; stored the cost price of each product
- discount;Recorded the percentage discount offered
- payment_method;Identified the payment method used
- order_status;Recorded whether an order was completed ,pending or cancelled
- customer_id; which acted as a foreign key referencing the customers table.This relationship enabled customer informationto be linked to their respective sales transactions
## SQL Implementation
The two database tables were created using the **CREATE TABLE** statement in PostgreSQL. Primary keys were used to uniquely identify records, while foreign keys established relationships between the two tables. Additional constraints were implemented to improve data accuracy and maintain consistency, these included **NOT NULL**, **CHECK** and **DEFAULT** constraints.For example, the quantity field was restricted to positive values, discounts were limited to a range of**0–100**, and customer segments were restricted to **Retail, Corporate and VIP**.These constraints helped prevent invalid entries and improved the reliability of the database.
## Data analysis using SQL queries
Queries were developed to anwser 46 important business questions and extract important information
### Section A: Basic SQL Queries 
The first section focused on retrieving and filtering records from the customers and orders tables. SELECT statements were used to retrieve customer information, while WHERE conditions were applied to filter records based on specific requirements.The analysis involved retrieving all customer records, displaying selected customer details, identifying customers from Nairobi and finding customers registered after a specified date.Other queries identified unique customer cities, recent orders, orders with unit prices above KSh 10,000, customers whose names started with the letter A, orders with quantities between 2 and 5, and transactions made through M-Pesa.
The main SQL concepts applied included SELECT, WHERE, DISTINCT, ORDER BY, LIMIT, LIKE and BETWEEN.

### Section B: Aggregation and Grouping 
The second section focused on summarizing and calculating information from the database. Aggregate functions were applied to determine the number of customers, total orders, completed-order revenue, average completed-order value, and highest and lowest product prices.
GROUP BY was used to summarize revenue by product category, count customers by city and calculate the total quantity sold for individual products.The HAVING clause was applied to identify product categories generating more than KSh 100,000 in revenue.Additionally, the percentage of cancelled orders was calculated to establish the proportion of unsuccessful transactions.The main SQL concepts applied included COUNT(), SUM(), AVG(), MIN(), MAX(), GROUP BY, HAVING, ROUND() and FILTER.

### Section C: Joins and Customer Analytics 
The third section focused on combining customer and order information to understand purchasing behaviour and customer contributions to business revenue.INNER JOIN was used to display orders alongside customer names and cities. Customer spending was calculated by multiplying the quantity purchased by the unit price and aggregating the results for each customer.LEFT JOIN was applied to identify customers who had never placed an order. Additional queries identified the ten highest-spending customers, calculated revenue by customer city and identified customers who had placed more than five orders.The analysis also examined average customer spending across the Retail, Corporate and VIP segments. Finally, the most popular product category among VIP customers was identified using the number of units purchased as the measure of popularity.The main SQL concepts applied included INNER JOIN, LEFT JOIN, GROUP BY, HAVING, SUM() and AVG().

### Section D: Subqueries and Common Table Expressions 
The fourth section involved more advanced SQL operations using subqueries and Common Table Expressions.Subqueries were used to identify customers whose total spending exceeded the average total spending per purchasing customer. Products with unit prices above the overall average unit price were also identified.Common Table Expressions (CTEs) were applied to organize complex queries into manageable steps. A CTE was used to identify the three months that generated the highest revenue.Other queries identified customers who had purchased products from at least three different categories and calculated revenue, cost, profit and profit margin for each product category.
The analysis also identified customers whose latest completed orders were more than 90 days before the latest order date recorded in the dataset.These techniques simplified complex calculations and supported more detailed analysis of customer and product performance.

### Section E: Window Functions 
The fifth section focused on window functions, which were used to perform calculations across related rows without combining them into a single result.RANK() was used to rank customers according to their total spending, while ROW_NUMBER() was applied to number each customer's orders based on their recency.DENSE_RANK() was used to rank products within their respective categories. Cumulative monthly revenue was calculated using SUM() as a window function.LAG() was applied to compare monthly revenue with the previous month's revenue. The results were also used to calculate month-over-month revenue growth percentages.NTILE(4) was used to divide customers into four spending groups, while window functions were applied to calculate each product category's contribution to total revenue.The main SQL concepts applied included OVER, PARTITION BY, ROW_NUMBER(), RANK(), DENSE_RANK(), SUM(), LAG() and NTILE().

### Section F: Advanced Business Intelligence 
The final section focused on applying advanced PostgreSQL features to develop reusable reporting tools and generate management-level information.A monthly_sales_summary view was created to display monthly orders, revenue, cost and profit. This view provided a reusable summary of the business's monthly financial performance.A PostgreSQL function was also developed to return completed-order revenue for a supplied customer ID. The function was tested using an existing customer ID and a non-existing customer ID. For a customer without matching records, the function was designed to return zero instead of NULL.A customer segmentation analysis was performed to classify customers into High, Medium and Low Value categories. Spending thresholds were selected based on the distribution of customer spending in the dataset to provide a meaningful classification.Finally, a management report was developed to identify the five highest-spending customers, five top-performing products, the most profitable product category and the month with the lowest revenue.These analyses provided a summary of important business performance indicators that could support management decisions.
# Business assumptions
# Business insights and reccomendattions
## Product Category Revenue (Q16)
**Finding**: Mobile Phones generated the highest revenue of KSh 8,982,283.25, representing approximately 29.16% of total revenue. Computing followed with KSh 8,307,353.45 (26.97%), while Accessories recorded the lowest revenue of KSh 1,542,348.90 (5.01%).
**Why it matters**: Mobile Phones and Computing contributed approximately 56.13% of the total revenue. This showed that these two categories were important sources of sales for Duka Smart Electronics. The low revenue from Accessories may indicate lower demand or limited sales opportunities.
**Recommendation**: Management should maintain adequate stock of Mobile Phones and Computing products to meet customer demand. The business should also investigate the low performance of Accessories and consider product promotions, improved marketing, or reviewing the range of accessories offered.
