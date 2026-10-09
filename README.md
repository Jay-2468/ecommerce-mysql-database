# E-Commerce Database Management & Analytics System

A relational database project built with MySQL using the Brazilian E-Commerce Public Dataset by Olist.

The project focuses on database design, SQL development, data integrity, reusable database objects, transactions and query performance optimization.

## Objectives

* Design a normalized relational database for an e-commerce system.
* Implement relationships using primary and foreign keys.
* Practice SQL from basic queries to advanced analytical queries.
* Create reusable views and stored procedures.
* Implement transaction-based operations.
* Analyze query execution using `EXPLAIN`.
* Apply indexes to improve frequently executed queries.
* Perform data quality checks on real-world e-commerce data.

## Technology

* MySQL 8.x
* SQL
* MySQL Workbench
* Git & GitHub

## Dataset

This project uses the Brazilian E-Commerce Public Dataset by Olist.

The dataset contains approximately 100K orders and multiple related datasets covering customers, orders, products, sellers, payments and reviews.

The original dataset is not stored in this repository. Follow the data preparation instructions to obtain and load the CSV files locally.

## Database Architecture

The database contains the following major entities:

* Customers
* Orders
* Order Items
* Products
* Categories
* Sellers
* Payments
* Reviews

### Entity Relationship Diagram

![E-Commerce ER Diagram](docs/ecommerce_erd.png)

## Database Design

The database uses a normalized relational structure to reduce data redundancy and maintain data integrity.

Primary and foreign key relationships are used to connect customers, orders, products, sellers, payments and reviews.

The `order_items` table represents the relationship between orders and products and uses a composite primary key consisting of `order_id` and `order_item_id`.

## SQL Features Demonstrated

### Basic SQL

* SELECT
* WHERE
* ORDER BY
* LIMIT
* DISTINCT

### Data Aggregation

* COUNT
* SUM
* AVG
* MIN
* MAX
* GROUP BY
* HAVING

### Advanced Queries

* INNER JOIN
* LEFT JOIN
* Subqueries
* Common Table Expressions (CTEs)
* CASE expressions
* Window functions
* Ranking
* LEAD / LAG

### Database Objects

* Views
* Stored Procedures
* Constraints
* Indexes

### Transaction Management

* START TRANSACTION
* COMMIT
* ROLLBACK

### Performance

* EXPLAIN
* Index analysis
* Query execution plan analysis
* Query optimization

## Example Business Questions

The project answers questions such as:

1. What are the top-selling product categories?
2. Which customers generate the highest revenue?
3. What is the average order value?
4. Which sellers generate the most revenue?
5. What are the monthly sales trends?
6. Which categories have the highest average order value?
7. Which customers have placed multiple orders?
8. What percentage of orders are delivered?
9. Which products have the highest sales volume?
10. How does freight cost vary across product categories?

## Performance Analysis

Selected queries were analyzed using MySQL `EXPLAIN`.

Indexes were introduced for frequently filtered and joined columns where appropriate.

The purpose of the analysis was to understand how MySQL executes queries and how indexing can reduce unnecessary data scanning.

## Project Structure

```text
ecommerce-mysql-database/
│
├── database/
├── data/
├── queries/
├── views/
├── procedures/
├── transactions/
├── performance/
├── docs/
└── README.md
```

## Key Learning Outcomes

Through this project, I practiced:

* Relational database design
* Normalization
* SQL query development
* Data integrity
* Database relationships
* Stored procedures
* Views
* Transactions
* Indexing
* Query execution plans
* Query optimization
* Working with a real-world dataset

## Future Improvements

* Add automated data-loading scripts.
* Implement additional data quality checks.
* Introduce scheduled ETL workflows.
* Migrate analytical workloads to a cloud data warehouse.
* Explore Apache Airflow and Spark for larger-scale data processing.

## Author

**Jay Falak**

https://www.linkedin.com/in/jay-falak-b511a0212/ | https://github.com/Jay-2468
