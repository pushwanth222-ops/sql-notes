USE sakila;

-- Stored Procedures
DELIMITER //
CREATE PROCEDURE get_films_by_rating(IN p_rating VARCHAR(10))
BEGIN
    SELECT title, length, rental_rate 
    FROM film 
    WHERE rating = p_rating;
END //
DELIMITER ;

CALL get_films_by_rating('PG');

-- Dynamic SQL
SET @sql_query = 'SELECT first_name, last_name FROM actor LIMIT 5';
PREPARE stmt FROM @sql_query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- Deadlocks
SHOW ENGINE INNODB STATUS;
-- Look for the LATEST DETECTED DEADLOCK section in the output

-- Indexes and Indexing Strategy
CREATE INDEX idx_last_name ON customer (last_name);
SHOW INDEX FROM customer;

-- Clustered vs Non-clustered Indexes
SHOW INDEX FROM film;
-- Look for PRIMARY (clustered) vs other indexes (non-clustered)

-- Execution Plans / EXPLAIN
EXPLAIN SELECT c.first_name, f.title 
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
WHERE c.last_name = 'SMITH';

-- Query Optimization
-- Slow: function on column breaks index usage
SELECT * FROM customer WHERE YEAR(create_date) = 2006;

-- Fast: use range comparison instead
SELECT * FROM customer 
WHERE create_date >= '2006-01-01' AND create_date < '2007-01-01';

-- Views for Security
CREATE OR REPLACE VIEW customer_public AS
SELECT customer_id, first_name, last_name, active 
FROM customer;

SELECT * FROM customer_public LIMIT 5;
-- email and other sensitive columns are not exposed
