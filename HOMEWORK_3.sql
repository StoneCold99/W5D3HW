SELECT *
FROM staff;

SELECT * 
FROM rental;


SELECT first_name, last_name, staff.staff_id, COUNT(staff.staff_id)
FROM staff
FULL JOIN rental
ON staff.staff_id = rental.staff_id
WHERE staff.staff_id IS NOT NULL
GROUP BY staff.staff_id; 


SELECT *
FROM actor;

SELECT *
FROM film;

-- QUERY for film_id's from film_actor tables and which actors appear with those film_id's
SELECT actor.actor_id, first_name, last_name, film_id
FROM actor
INNER JOIN film_actor
ON  actor.actor_id = film_actor.actor_id;

-- Query to see which actors are in what films
SELECT first_name, last_name, title, description, actor.actor_id, film.film_id
FROM actor
INNER JOIN film_actor
ON actor.actor_id = film_actor.actor_id
INNER JOIN film
ON film_actor.film_id = film.film_id;

-- LEFT JOIN on the actor table and film_actor table
SELECT actor.actor_id, first_name, last_name, film_id
FROM actor
LEFT JOIN film_actor
ON actor.actor_id = film_actor.actor_id;

-- FIND ALL customers that live in the country of Angola
SELECT first_name, last_name, country.country_id, country.country 
FROM customer
INNER JOIN address
ON customer.address_id = address.address_id
INNER JOIN city
ON address.city_id = city.city_id
INNER JOIN country
ON city.country_id = country.country_id
WHERE country = 'Angola';

-- subQueries is a Query within a Query
SELECT customer_id, SUM(amount)
FROM payment
GROUP BY customer_id
HAVING SUM(amount) < 175
ORDER BY SUM(amount) DESC;

-- QUERY TO FINED WHO SPENT A CERTIAN AMOUNT OF $$
SELECT store_id, first_name, last_name
FROM customer
WHERE customer_id IN(
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	HAVING SUM(amount) > 175
	ORDER BY SUM(amount) DESC
);

-- QUERY FOR A CERTIAN AMOUNT OF PEOPLE LIVING IN A CERTIAN COUNTRY
SELECT first_name, last_name, address.address
FROM customer
INNER JOIN address
ON customer.address_id = address.address_id
INNER JOIN city
ON address.city_id = city.city_id
INNER JOIN country
ON city.country_id = country.country_id AND country.country = 'United States'
INNER JOIN payment
ON customer.customer_id = payment.customer_id
GROUP BY customer.customer_id, first_name, last_name, address
HAVING SUM(amount) > 175;

-- WHERE amount > AVG(amount);
SELECT ROUND(AVG(amount), 2)
FROM payment;

SELECT payment_id, amount
FROM payment
WHERE amount > 4.20;

-- Subquery to find amounts paid greater than the average amount paid
SELECT payment_id, amount
FROM payment
WHERE amount > (
	SELECT AVG(amount) FROM payment
);

--subQuery to find customers who live in dallas
SELECT first_name, last_name, address_id
FROM customer
WHERE address_id IN(
	SELECT address_id
	FROM address
	WHERE city_id IN(
		SELECT city_id
		FROM city
		WHERE city = 'Dallas'
	
	)
);
-------- HOMEWORK IS HERE -----------------

--1
SELECT first_name, last_name, city.city_id, city.city, address.district
FROM customer
INNER JOIN address
ON customer.address_id = address.address_id
INNER JOIN city
ON address.city_id = city.city_id
WHERE district = 'Texas';
--2
SELECT amount, customer.customer_id, customer.first_name, customer.last_name
FROM payment
INNER JOIN customer
ON payment.customer_id = customer.customer_id
WHERE amount > 6.99;
--3
SELECT first_name, last_name, customer_id
FROM customer
WHERE customer_id IN (
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	HAVING SUM(amount) > 175
);
--4
SELECT first_name, last_name, address.address_id, country.country
FROM customer
INNER JOIN address
ON customer.address_id = address.address_id
INNER JOIN city
ON address.city_id = city.city_id
INNER JOIN country
ON city.country_id = country.country_id
WHERE country = 'Nepal';
--5
SELECT COUNT(staff.staff_id), first_name, last_name
FROM staff
INNER JOIN payment
ON staff.staff_id = payment.staff_id
GROUP BY staff.staff_id
ORDER BY COUNT(staff.staff_id) DESC
LIMIT 1;
--6
SELECT COUNT(rating), rating
FROM film
GROUP BY (rating)
--7
SELECT customer_id, first_name, last_name
FROM customer
WHERE customer_id IN (
	SELECT customer_id
	FROM payment 
	WHERE payment.amount > 6.99
	GROUP BY customer_id
	HAVING COUNT(payment.amount) = 1
);

SELECT customer.customer_id
FROM customer
INNER JOIN payment
ON customer.customer_id = payment.customer_id
WHERE payment.amount > 6.99
GROUP BY customer.customer_id
HAVING COUNT(payment.amount) = 1 AND COUNT(DISTINCT payment.amount) = 1;
--8
SELECT COUNT(rental.rental_id) as Free_Rentals
FROM rental
INNER JOIN payment
ON rental.rental_id = payment.rental_id
WHERE amount = 0.00;