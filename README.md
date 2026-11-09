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
fields : - customer_id which uniquely identified each customer
- customer_name Stored the customer names
- gender Recorded the customer gender either male or female
- City Identified the customers location
- Registration_date Recorded the date the customer registered
- Customer_segment Classified customers into retail ,corporate and VIP segments
