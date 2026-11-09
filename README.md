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

| Measure | Formula |
|---|---|
| **Revenue** | `quantity * unit_price * (1 - discount / 100)` |
| **Cost** | `quantity * cost_price` |
| **Profit** | `revenue - cost` |
| **Profit margin %** | `profit / revenue * 100` — use `NULLIF(revenue, 0)` so you never divide by zero |
# Business insights and reccomendattions
##  Product Category Revenue (Q16)
**Finding**: Mobile Phones generated the highest revenue of KSh 8,982,283.25, representing approximately 29.16% of total revenue. Computing followed with KSh 8,307,353.45 (26.97%), while Accessories recorded the lowest revenue of KSh 1,542,348.90 (5.01%).
**Why it matters**: Mobile Phones and Computing contributed approximately 56.13% of the total revenue. This showed that these two categories were important sources of sales for Duka Smart Electronics. The low revenue from Accessories may indicate lower demand or limited sales opportunities.
**Recommendation**: Management should maintain adequate stock of Mobile Phones and Computing products to meet customer demand. The business should also investigate the low performance of Accessories and consider product promotions, improved marketing, or reviewing the range of accessories offered.

## Revenue Performance by Customer City (Q25)

**Finding:** Nairobi generated the highest revenue of KSh 12,930,183, followed by Mombasa with KSh 4,204,734 and Nakuru with KSh 3,254,490. Machakos recorded the lowest revenue of KSh 1,119,148.

**Why it matters:** Nairobi contributed the largest share of sales, showing that it was an important market for Duka Smart Electronics. The difference between Nairobi and other cities may indicate differences in customer demand and market opportunities.

**Recommendation:** Management should maintain adequate stock and strengthen sales operations in Nairobi. The business should also investigate the low revenue in Machakos and consider targeted marketing campaigns, customer promotions, and improved product availability to increase sales.

## Product Category Profitability and Margin Analysis(Q33)
**Finding**
Mobile Phones generated the highest total profit of KSh 728,760.65 (with revenue of KSh 6,942,060.65 and a profit margin of 10.50%), closely followed by Computing with a profit of KSh 700,021.70 (revenue of KSh 6,596,221.70 and a margin of 10.61%).Accessories recorded the lowest absolute profit at KSh 456,746.10 (revenue of KSh 1,077,496.10), but boasted the highest profitability by far with a stellar profit margin of 42.39%.Electronics yielded a total profit of KSh 547,359.20 at a 9.92% margin, while Home Appliances generated KSh 458,034.05 at an 11.38% margin.   

**Why it matters** While high-volume categories like Mobile Phones and Computing drive the bulk of absolute cash flow and revenue, their slim margins leave little room for operational inefficiencies or unexpected costs.Conversely, Accessories acts as a high-margin niche. Even though its total revenue contribution is lower, its exceptional 42.39% profit margin proves it is an efficient, high-yield segment for the business.   

**Recommendation** Protect Volume in Core Categories: Maintain competitive pricing and steady inventory levels for Mobile Phones and Computing to safeguard overall gross profit generation.   
Scale High-Margin Accessories: Capitalize on the high profit margin of Accessories by introducing product bundles (e.g., bundling phone cases or chargers with mobile phone purchases) and cross-selling campaigns to boost total sales volume in this category.   

##  Customer Retention and Inactive Customers (Q34)

**Finding:** The analysis identified 47 customers whose latest completed order was more than 90 days before the latest order date in the dataset. Some customers had not made a completed purchase since January 2025, while others had their last completed orders in 2025 and early 2026.

**Why it matters:** These customers may have stopped purchasing from Duka Smart Electronics, which could result in reduced sales and loss of customer loyalty. Losing existing customers may also increase the cost of acquiring new ones.

**Recommendation:** Management should contact these customers through phone calls, SMS, or email to understand why they stopped purchasing. The business should introduce targeted discounts, loyalty rewards, and personalized offers to encourage them to make new purchases.

## Month over month revenue
**Finding** Peak Revenue and Massive Spikes:The highest revenue value recorded is 2,180,704 in 2025-12, with a Month-over-Month (MoM) growth of 58% coming from a previous month's revenue of 1,380,152.   Other significant high-revenue months include 2026-06 (2,136,929 with 73.25% growth) and 2026-08 (2,350,619 with 48.31% growth).
Severe Contractions and Sharp Drops:2026-01 experienced a drastic downturn, dropping to 343,982 from 2,180,704 in December, translating to a steep MoM decline of -84.23%. Other notable negative growth months include 2025-02 (-19.79%), 2025-04 (-12.65%), 2025-09 (-5.98%), 2026-05 (-29.41%), 2026-07 (-25.83%), and 2026-09 (-6.86%).  
High Volatility: The dataset displays erratic growth percentages, alternating rapidly between triple-digit gains (e.g., +141.37% in 2026-02) and massive losses (e.g., -84.23% in 2026-01).

**Why It Matters** Operational Strain: The sharp drop in 2026-01 (-84.23%) indicates that following peak periods (like December), the system experiences a profound reduction in volume or output. If costs or operations are scaled up to match the 2.18M peak, a sudden drop to 343k creates severe imbalance. 
Unpredictable Trajectory: The alternating pattern of large spikes followed immediately by downturns (such as June 2026 peaking at 2.13M only to drop by -25.83% in July 2026) points to cyclical instability rather than steady, predictable scaling.    

**Recommendations** Investigate the January Drop: Conduct a root-cause analysis on why January 2026 suffered an -84.23% fall from December 2025 to determine if it is driven by seasonal behavior, reporting lags, or data collection gaps.   Stabilize Month-over-Month Performance: Focus on smoothing out the extreme swings by analyzing what drives the high-growth months (like February 2026's +141.37% or June 2026's +73.25%) and replicating those drivers during slow periods.
Adopt Buffer Planning: Align operational capacity and targets to account for historical downturns (such as May, July, and September dips) to prevent over-allocation during volatile cycles.

## Customer category(High value,low value and medium value customers)

**Findings**
customers with a total spending of above 100,000 were categorized as high value, above 50000 were categorized as medium value and below 50000 were categorized as low value
Wide Spending Disparity: Customer total spending ranges from a high of 848,118.75 (Brian Chebet) (Alex Korir, ID 111), demonstrating a massive gap in individual customer value.
Tiered Segmentation Structure: The dataset segments customers into distinct performance brackets High Value, Medium Value, and Low Value based on total calculated spending derived from quantity, unit price, and discounts.
Top-Tier Concentration: The upper echelon of customers (e.g., Brian Chebet, Peter Ndungu, and Lucy Njoroge) drive hundreds of thousands in revenue individually, forming the core revenue-generating group.

**Why It Matters**
Revenue Vulnerability (The Pareto Principle): If a small percentage of High-Value customers account for the lion's share of total spending, the business is heavily exposed to churn risk. Losing a few top-tier customers would create an immediate, severe revenue deficit.
Misallocated Marketing Resources: Treating all 132 fetched customers the same wastes budget. Low-Value customers spending under 3,000 require a low-touch digital approach, whereas High-Value customers demand personalized account management and retention perks.   
Discount Efficiency: The calculation incorporates a discount modifier (1 - o.discount / 100.0). If heavy discounts are being given indiscriminately to low-value buyers, it eats into profitability without securing loyalty.   

**Recommendations**
Implement VIP Retention Programs: Focus dedicated customer success efforts, exclusive perks, and loyalty incentives on your High-Value segment (e.g., customers above the top thresholds) to safeguard your primary revenue streams.
Upgrade Medium-Value Buyers: Design targeted cross-selling and up-selling campaigns for Medium-Value customers to push them into the High-Value tier.
Automate Low-Value Engagement: Keep acquisition and servicing costs minimal for Low-Value customers by relying on automated marketing and self-service portals rather than costly manual interventions.
# Challenges faced

During the project, several areas required careful attention. Database relationships had to be established correctly to ensure that customer information was accurately linked to sales transactions.

Writing complex SQL queries also required an understanding of joins, aggregate functions, subqueries and window functions. In addition, the accuracy of the analysis depended on the correctness and completeness of the available data.

The analysis was limited to the information contained in the two database tables and the period covered by the available transactions.

# Conclusion

The Retail Sales and Customer Intelligence project provided an opportunity to apply PostgreSQL and SQL techniques in analysing retail business data. Through database creation, table relationships and the development of SQL queries, customer information and sales transactions were organized into a structured relational database. Different SQL techniques were applied to examine sales performance, customer purchasing behaviour, product performance and profitability.

The project also demonstrated the importance of data analysis in supporting business decision-making. The insights generated from the analysis could help Duka Smart Electronics improve its sales strategies, understand customer needs, manage inventory and monitor profitability. Overall, the project strengthened practical skills in database management, SQL querying and business intelligence while demonstrating how data could be transformed into useful information for business growth.

