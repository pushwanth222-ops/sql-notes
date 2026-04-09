USE sakila;

-- 1. What is SQL?
SELECT 'Hello SQL' AS greeting;

-- 2. DBMS vs RDBMS
SELECT f.title, l.name AS language FROM film f JOIN language l ON f.language_id = l.language_id LIMIT 3;

-- 3. Tables, Rows, and Columns
DESCRIBE actor;

-- 4. Schemas and Databases
SHOW DATABASES;

-- 5. SQL Syntax Rules
SELECT first_name, last_name FROM actor LIMIT 3;

-- 6. SQL Keywords and Identifiers
SELECT first_name FROM actor WHERE first_name = 'PENELOPE';

-- 7. SQL Data Types
DESCRIBE film;

-- 8. Creating a Database
CREATE DATABASE IF NOT EXISTS practice_db;

-- 9. Using / Selecting a Database
USE sakila;

-- 10. Creating a Table
USE practice_db;
CREATE TABLE IF NOT EXISTS students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(100)
);
USE sakila;

-- 11. Inserting Starter Data
USE practice_db;
INSERT INTO students (name, email) VALUES ('John', 'john@mail.com'), ('Jane', 'jane@mail.com');
USE sakila;

-- 12. Comments in SQL
-- this is a comment
SELECT first_name FROM actor LIMIT 3;

-- 13. Operators in SQL
SELECT title, rental_rate, rental_rate * 1.10 AS new_rate FROM film WHERE rental_rate > 2.99 LIMIT 3;

-- 14. NULL Values
SELECT title FROM film WHERE original_language_id IS NULL LIMIT 3;

-- 15. Aliases
SELECT first_name AS name, last_name AS surname FROM actor LIMIT 3;

-- 16. SELECT Statement
SELECT title, release_year, rating FROM film LIMIT 3;

-- 17. SELECT DISTINCT
SELECT DISTINCT rating FROM film;

-- 18. WHERE Clause
SELECT title, rating FROM film WHERE rating = 'PG' LIMIT 3;

-- 19. ORDER BY
SELECT title, rental_rate FROM film ORDER BY rental_rate DESC LIMIT 3;

-- 20. LIMIT
SELECT title FROM film LIMIT 3 OFFSET 2;

-- 21. Pattern Matching with LIKE
SELECT first_name FROM actor WHERE first_name LIKE 'A%' LIMIT 5;

-- 22. Wildcards
SELECT first_name FROM actor WHERE first_name LIKE '_A%' LIMIT 5;

-- 23. IN Operator
SELECT title, rating FROM film WHERE rating IN ('PG', 'G') LIMIT 3;

-- 24. BETWEEN Operator
SELECT title, length FROM film WHERE length BETWEEN 90 AND 100 LIMIT 3;

-- 25. IS NULL / IS NOT NULL
SELECT first_name, email FROM customer WHERE email IS NOT NULL LIMIT 3;

-- 26. Aggregate Functions (COUNT, SUM, AVG, MIN, MAX)
SELECT COUNT(*) AS total, AVG(rental_rate) AS avg_rate, MAX(length) AS longest FROM film;

-- 27. GROUP BY
SELECT rating, COUNT(*) AS total FROM film GROUP BY rating;

-- 28. HAVING
SELECT rating, COUNT(*) AS total FROM film GROUP BY rating HAVING total > 200;

-- 29. CASE Expression
SELECT title, CASE WHEN length < 60 THEN 'Short' WHEN length <= 120 THEN 'Medium' ELSE 'Long' END AS category FROM film LIMIT 3;

-- 30. Subqueries
SELECT title, rental_rate FROM film WHERE rental_rate > (SELECT AVG(rental_rate) FROM film) LIMIT 3;

-- 31. Correlated Subqueries
SELECT a.first_name, a.last_name FROM actor a WHERE (SELECT COUNT(*) FROM film_actor fa WHERE fa.actor_id = a.actor_id) > 35 LIMIT 3;

-- 32. EXISTS / NOT EXISTS
SELECT c.first_name FROM customer c WHERE EXISTS (SELECT 1 FROM rental r WHERE r.customer_id = c.customer_id) LIMIT 3;

-- 33. ANY / ALL
SELECT title, rental_rate FROM film WHERE rental_rate > ALL (SELECT rental_rate FROM film WHERE rating = 'G') LIMIT 3;

-- 34. Derived Tables
SELECT sub.rating, sub.avg_len FROM (SELECT rating, AVG(length) AS avg_len FROM film GROUP BY rating) AS sub;

-- 35. SELECT INTO / CREATE TABLE AS
DROP TABLE IF EXISTS pg_films;
CREATE TABLE pg_films AS SELECT title, length FROM film WHERE rating = 'PG' LIMIT 3;

-- 36. Common Table Expressions (CTE)
WITH long_films AS (SELECT title, length FROM film WHERE length > 150)
SELECT * FROM long_films LIMIT 3;

-- 37. Recursive CTE
WITH RECURSIVE nums AS (SELECT 1 AS n UNION ALL SELECT n+1 FROM nums WHERE n < 5)
SELECT n FROM nums;

-- 38. Window Functions Overview
SELECT title, rating, rental_rate, AVG(rental_rate) OVER (PARTITION BY rating) AS avg_by_rating FROM film LIMIT 3;

-- 39. Ranking Functions (ROW_NUMBER, RANK, DENSE_RANK)
SELECT title, rental_rate, ROW_NUMBER() OVER (ORDER BY rental_rate DESC) AS rn FROM film LIMIT 3;

-- 40. Analytic Functions (LAG, LEAD, FIRST_VALUE, LAST_VALUE)
SELECT title, rental_rate, LAG(rental_rate) OVER (ORDER BY film_id) AS prev_rate FROM film LIMIT 3;

-- 41. Window Frames and Running Totals
SELECT title, rental_rate, SUM(rental_rate) OVER (ORDER BY film_id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_total FROM film LIMIT 3;

-- 42. PIVOT / UNPIVOT
SELECT 
    SUM(CASE WHEN rating='PG' THEN 1 ELSE 0 END) AS PG,
    SUM(CASE WHEN rating='R' THEN 1 ELSE 0 END) AS R,
    SUM(CASE WHEN rating='G' THEN 1 ELSE 0 END) AS G
FROM film;

-- 43. Set Operators (UNION, UNION ALL, INTERSECT, EXCEPT)
SELECT first_name FROM actor WHERE first_name LIKE 'A%'
UNION
SELECT first_name FROM actor WHERE first_name LIKE 'B%'
LIMIT 5;

-- 44. INSERT
USE practice_db;
INSERT INTO students (name, email) VALUES ('Alice', 'alice@mail.com');
USE sakila;

-- 45. INSERT INTO SELECT
INSERT INTO pg_films (title, length) SELECT title, length FROM film WHERE rating = 'G' LIMIT 3;

-- 46. UPDATE
UPDATE film SET rental_rate = 3.99 WHERE film_id = 1;

-- 47. DELETE
USE practice_db;
DELETE FROM students WHERE name = 'Alice';
USE sakila;

-- 48. CREATE TABLE
USE practice_db;
CREATE TABLE IF NOT EXISTS orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    product VARCHAR(100),
    amount DECIMAL(10,2)
);
USE sakila;

-- 49. ALTER TABLE
USE practice_db;
ALTER TABLE orders ADD COLUMN order_date DATE;
USE sakila;

-- 50. DROP TABLE
DROP TABLE IF EXISTS pg_films;

-- 51. TRUNCATE TABLE
USE practice_db;
TRUNCATE TABLE students;
USE sakila;

-- 52. RENAME TABLE / COLUMN
USE practice_db;
ALTER TABLE orders RENAME COLUMN amount TO total_amount;
USE sakila;

-- 53. Constraints Overview
SHOW CREATE TABLE film;

-- 54. NOT NULL Constraint
USE practice_db;
CREATE TABLE IF NOT EXISTS test1 (name VARCHAR(50) NOT NULL);
USE sakila;

-- 55. UNIQUE Constraint
USE practice_db;
CREATE TABLE IF NOT EXISTS test2 (email VARCHAR(100) UNIQUE);
USE sakila;

-- 56. PRIMARY KEY
USE practice_db;
CREATE TABLE IF NOT EXISTS test3 (id INT AUTO_INCREMENT PRIMARY KEY, name VARCHAR(50));
USE sakila;

-- 57. FOREIGN KEY
SELECT * FROM film_actor LIMIT 3;

-- 58. CHECK Constraint
USE practice_db;
CREATE TABLE IF NOT EXISTS test4 (age INT CHECK (age >= 0 AND age <= 150));
USE sakila;

-- 59. DEFAULT Constraint
USE practice_db;
CREATE TABLE IF NOT EXISTS test5 (status VARCHAR(20) DEFAULT 'pending');
USE sakila;

-- 60. AUTO_INCREMENT
USE practice_db;
CREATE TABLE IF NOT EXISTS test6 (id INT AUTO_INCREMENT PRIMARY KEY, name VARCHAR(50));
INSERT INTO test6 (name) VALUES ('Tom'), ('Sam');
SELECT * FROM test6;
USE sakila;

-- 61. CREATE INDEX
CREATE INDEX idx_last_name ON actor (last_name);

-- 62. DROP / ALTER / REBUILD INDEX
DROP INDEX idx_last_name ON actor;

-- 63. CREATE VIEW
CREATE OR REPLACE VIEW actor_films AS
SELECT a.first_name, a.last_name, COUNT(*) AS films
FROM actor a JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id, a.first_name, a.last_name;

-- 64. ALTER / DROP VIEW
DROP VIEW IF EXISTS actor_films;

-- 65. CREATE SCHEMA
CREATE SCHEMA IF NOT EXISTS test_schema;

-- 66. Temporary Tables
CREATE TEMPORARY TABLE temp_actors AS SELECT first_name FROM actor WHERE first_name LIKE 'A%';
SELECT * FROM temp_actors LIMIT 3;

-- 67. INNER JOIN
SELECT a.first_name, f.title FROM actor a
INNER JOIN film_actor fa ON a.actor_id = fa.actor_id
INNER JOIN film f ON fa.film_id = f.film_id LIMIT 3;

-- 68. LEFT JOIN
SELECT c.first_name, r.rental_id FROM customer c
LEFT JOIN rental r ON c.customer_id = r.customer_id LIMIT 3;

-- 69. RIGHT JOIN
SELECT r.rental_id, c.first_name FROM rental r
RIGHT JOIN customer c ON r.customer_id = c.customer_id LIMIT 3;

-- 70. FULL OUTER JOIN
SELECT a.first_name, fa.film_id FROM actor a LEFT JOIN film_actor fa ON a.actor_id = fa.actor_id
UNION
SELECT a.first_name, fa.film_id FROM actor a RIGHT JOIN film_actor fa ON a.actor_id = fa.actor_id
LIMIT 3;

-- 71. CROSS JOIN
SELECT a.first_name, c.name AS category FROM actor a CROSS JOIN category c LIMIT 3;

-- 72. SELF JOIN
SELECT a1.first_name, a2.first_name AS same_last FROM actor a1
JOIN actor a2 ON a1.last_name = a2.last_name AND a1.actor_id != a2.actor_id LIMIT 3;

-- 73. Multi-table Joins
SELECT c.first_name, f.title, p.amount FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN payment p ON r.rental_id = p.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id LIMIT 3;

-- 74. Joining Aggregated Data
SELECT f.title, f.rental_rate, sub.avg_rate
FROM film f
JOIN (SELECT rating, AVG(rental_rate) AS avg_rate FROM film GROUP BY rating) sub
ON f.rating = sub.rating LIMIT 3;

-- 75. Join Conditions and Join Order
EXPLAIN SELECT a.first_name, f.title FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film f ON fa.film_id = f.film_id LIMIT 3;

-- 76. Referential Integrity
SHOW CREATE TABLE film_actor;

-- 77. Many-to-Many Relationships
SELECT a.first_name, f.title FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film f ON fa.film_id = f.film_id WHERE a.actor_id = 1 LIMIT 3;

-- 78. String Functions
SELECT CONCAT(first_name, ' ', last_name) AS full_name, LENGTH(first_name) AS len FROM actor LIMIT 3;

-- 79. Numeric Functions
SELECT title, ROUND(rental_rate * 1.15, 2) AS with_tax, CEIL(length/60) AS hours FROM film LIMIT 3;

-- 80. Date and Time Functions
SELECT first_name, create_date, DATEDIFF(NOW(), create_date) AS days_active FROM customer LIMIT 3;

-- 81. CAST / CONVERT
SELECT title, CAST(rental_rate AS CHAR) AS rate_text FROM film LIMIT 3;

-- 82. COALESCE / IFNULL
SELECT address, IFNULL(address2, 'N/A') AS line2 FROM address LIMIT 3;

-- 83. Conditional Logic with CASE / IF
SELECT title, IF(length > 120, 'Long', 'Short') AS duration FROM film LIMIT 3;

-- 84. Regular Expressions in SQL
SELECT first_name FROM actor WHERE first_name REGEXP '^A|^B' LIMIT 5;

-- 85. User Defined Functions (UDFs)
DELIMITER //
CREATE FUNCTION rental_label(rate DECIMAL(4,2))
RETURNS VARCHAR(10) DETERMINISTIC
BEGIN
    IF rate <= 0.99 THEN RETURN 'Budget';
    ELSEIF rate <= 2.99 THEN RETURN 'Standard';
    ELSE RETURN 'Premium';
    END IF;
END //
DELIMITER ;

SELECT title, rental_label(rental_rate) AS label FROM film LIMIT 5;
