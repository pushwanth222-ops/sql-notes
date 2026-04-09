USE sakila;

-- 1. Display all customer details who have made more than 5 payments.
-- Method: Subquery
SELECT * 
FROM customer 
WHERE customer_id IN (
    SELECT customer_id 
    FROM payment 
    GROUP BY customer_id 
    HAVING COUNT(*) > 5
);

-- 2. Find the names of actors who have acted in more than 10 films.
-- Method: Subquery
SELECT first_name, last_name 
FROM actor 
WHERE actor_id IN (
    SELECT actor_id 
    FROM film_actor 
    GROUP BY actor_id 
    HAVING COUNT(film_id) > 10
);

-- 3. Find the names of customers who never made a payment.
-- Method: Subquery
SELECT first_name, last_name 
FROM customer 
WHERE customer_id NOT IN (
    SELECT DISTINCT customer_id 
    FROM payment
);

-- 4. List all films whose rental rate is higher than the average rental rate of all films.
-- Method: Subquery
SELECT title, rental_rate 
FROM film 
WHERE rental_rate > (
    SELECT AVG(rental_rate) 
    FROM film
);

-- 5. List the titles of films that were never rented.
-- Method: Subquery
SELECT title 
FROM film 
WHERE film_id NOT IN (
    SELECT DISTINCT i.film_id 
    FROM inventory i 
    JOIN rental r ON i.inventory_id = r.inventory_id
);

-- 6. Display the customers who rented films in the same month as customer with ID 5.
-- Method: CTE
WITH customer5_months AS (
    SELECT DISTINCT MONTH(rental_date) AS rental_month, YEAR(rental_date) AS rental_year
    FROM rental
    WHERE customer_id = 5
)
SELECT DISTINCT c.first_name, c.last_name
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN customer5_months m ON MONTH(r.rental_date) = m.rental_month 
                       AND YEAR(r.rental_date) = m.rental_year
WHERE c.customer_id != 5;

-- 7. Find all staff members who handled a payment greater than the average payment amount.
-- Method: CTE
WITH avg_payment AS (
    SELECT AVG(amount) AS avg_amt FROM payment
)
SELECT DISTINCT s.staff_id, s.first_name, s.last_name
FROM staff s
JOIN payment p ON s.staff_id = p.staff_id
JOIN avg_payment a ON p.amount > a.avg_amt;

-- 8. Show the title and rental duration of films whose rental duration is greater than the average.
-- Method: CTE
WITH avg_duration AS (
    SELECT AVG(rental_duration) AS avg_dur FROM film
)
SELECT f.title, f.rental_duration
FROM film f
JOIN avg_duration a ON f.rental_duration > a.avg_dur;

-- 9. Find all customers who have the same address as customer with ID 1.
-- Method: View
CREATE OR REPLACE VIEW customer1_address AS
SELECT address_id 
FROM customer 
WHERE customer_id = 1;

SELECT c.first_name, c.last_name, c.address_id
FROM customer c
JOIN customer1_address v ON c.address_id = v.address_id
WHERE c.customer_id != 1;

-- 10. List all payments that are greater than the average of all payments.
-- Method: Temporary Table
CREATE TEMPORARY TABLE temp_avg_payment AS
SELECT AVG(amount) AS avg_amt FROM payment;

SELECT p.payment_id, p.customer_id, p.amount, p.payment_date
FROM payment p
JOIN temp_avg_payment t ON p.amount > t.avg_amt;
