-- Inner Join
SELECT first_name,last_name,order_date,amount
FROM customer
INNER JOIN order_
ON customer.customer_id = order_.customer_id;

-- Left Join
SELECT first_name,last_name,order_date,amount
FROM customer
LEFT JOIN order_
ON customer.customer_id = order_.customer_id
WHERE order_date IS NOT NULL;

SELECT first_name,last_name,order_date,amount
FROM customer
LEFT JOIN order_
ON customer.customer_id = order_.customer_id;

-- Right Join
SELECT first_name,last_name,order_date, amount
FROM customer
RIGHT JOIN order_
ON customer.customer_id = order_.customer_id;

-- customer == Table A
-- order_ == Table B

-- Full Join
SELECT first_name,last_name,order_date,amount
FROM customer
FULL JOIN order_
ON customer.customer_id = order_.customer_id;


SELECT first_name, last_name, staff.staff_id, COUNT(staff.staff_id)
FROM staff
FULL OUTER JOIN rental
ON staff.staff_id = rental.staff_id
WHERE staff.staff_id IS NOT NULL 
GROUP BY staff.staff_id

-- Inner Join on the Actor and Film_Actor Table
SELECT actor.actor_id, first_name,last_name,film_id
FROM film_actor
INNER JOIN actor
ON actor.actor_id = film_actor.actor_id

--Adding another Join
SELECT actor.actor_id, first_name,last_name,film.film_id, title
FROM film_actor
INNER JOIN actor
ON actor.actor_id = film_actor.actor_id
INNER JOIN film
ON film_actor.film_id = film.film_id;

-- Left Join on the Actor and Film_Actor Table
SELECT actor.actor_id, first_name,last_name,film_id
FROM film_actor
LEFT JOIN actor
ON actor.actor_id = film_actor.actor_id
WHERE first_name IS NULL AND last_name IS NULL;

-- FULL JOIN to check for Actors that arent in Movies
SELECT actor.actor_id, first_name, last_name, film_id
FROM actor
FULL JOIN film_actor
ON actor.actor_id = film_actor.actor_id
WHERE film_id IS NULL;



-- Join that will produce info about a customer
-- From the country of Angola
-- address to city to country
SELECT customer.first_name,customer.last_name,customer.email,country
FROM customer
FULL JOIN address
ON customer.address_id = address.address_id
FULL JOIN city
ON address.city_id = city.city_id
FULL JOIN country
ON city.country_id = country.country_id
WHERE country = 'Angola';



-- SubQuery Examples

-- Two queries split apart (which will become a subquery later)

-- Find a customer_id that has a amount greater
-- Than 175 in total payments
SELECT customer_id
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > 175
ORDER BY SUM(amount) DESC;

-- Find ALL customer info
SELECT *
FROM customer;

-- Subquery to find the 6 customers that have
-- A total amount of payments greater than 175

SELECT store_id,first_name,last_name
FROM customer
WHERE customer_id IN (
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	HAVING SUM(amount) > 175
	ORDER BY SUM(amount) DESC
)
GROUP BY store_id,first_name,last_name;

SELECT store_id,first_name,last_name,address
FROM customer
INNER JOIN address
ON customer.address_id = address.address_id
INNER JOIN city
ON address.city_id = city.city_id
INNER JOIN country
ON city.country_id = country.country_id
WHERE country = 'Angola' AND customer_id IN (
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	HAVING SUM(amount) > 175
	ORDER BY SUM(amount) DESC
);

-- Basic Subquery
SELECT *
FROM customer
WHERE customer_id IN (
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	HAVING SUM(amount) > 175
	ORDER BY SUM(amount) DESC
);

-- SUBQUERY WITHIN THE SAME TABLE

SELECT AVG(amount) 
FROM payment;

SELECT payment_id, amount
FROM payment
WHERE amount > 4.2006056453822965;

SELECT *
FROM payment
WHERE amount > (SELECT AVG(amount) FROM payment);


-- Basic Subquery 
-- Find all films with a language of 'English'

SELECT first_name, last_name, address_id
FROM customer
WHERE address_id IN (
	SELECT address_id
	FROM address
	WHERE city_id IN (
		SELECT city_id
		FROM city
		WHERE city = 'Dallas'		
)
);

SELECT * 
FROM category;

-- Grab all movies from the action category
SELECT title, film_id
FROM film
WHERE film_id IN (
	SELECT film_id
	FROM film_category
	WHERE category_id IN (
		SELECT category_id
		FROM category
		WHERE name = 'Action'
		
	)
)



SELECT *
FROM PAYMENT