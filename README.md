# Online Store SQL Database

## Project Description

A SQL Server database designed for a fictional online store, including normalized schema design, realistic seed data, and analytical queries to answer key business questions.

## Database Structure

The database consists of 7 tables: Customers, Addresses, Brands, Categories, Products, Orders, and OrderItems, connected through foreign key relationships.

## Files

- `schema.sql` — Database and table creation with constraints and relationships
- `seed_data.sql` — Sample data insertion, including 200 randomly generated orders
- `analysis_queries.sql` — Analytical SQL queries with findings

## Questions Answered

1. What are the top-selling products by quantity sold?
2. What percentage of customers are repeat customers?
3. What is the monthly sales trend?
4. Which category and brand generate the most revenue?
5. Who are the top-spending customers?

## Tools Used

SQL Server, SQL Server Management Studio (SSMS)

## Key Findings

- **Product sales are fairly evenly distributed:** Quantity sold per product ranges from 90 to 156 units, reflecting the random nature of the synthetic order data rather than real demand patterns.
- **Revenue is heavily driven by high-ticket items:** Laptops (TechNova brand) generate $365,910 in revenue — nearly 3x the next category — despite similar unit sales across products, since price per unit varies significantly.
- **100% repeat customer rate:** This is a known artifact of the small customer base (10 customers) relative to order volume (200 orders), not a realistic business metric.
- **No meaningful monthly trend:** Since order dates were randomly generated, monthly order counts and revenue fluctuate without seasonality — on real data, this same query would reveal genuine trends.
- **Top-spending customers range from $36,856 to $88,817:** A roughly 2.4x spread, mainly driven by which high-ticket items each customer happened to purchase.

## Note on Data

This project uses synthetic (randomly generated) data for demonstration purposes. While some findings reflect genuine relationships (e.g., price driving revenue), others (e.g., repeat customer rate, monthly trends) are artifacts of the random data generation and would look different on real transactional data.