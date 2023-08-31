-- how many rentals did each staff member sell? 
SELECT first_name,last_name,staff.staff_id, COUNT(staff.staff_id)
FROM staff
FULL JOIN rental
ON staff.staff_id = rental.staff_id
GROUP BY staff.staff_id;

-- inner join to find which actors are in whivh films by ID
SELECT actor.actor_id, first_name,last_name,film_id
FROM film_actor 
INNER JOIN actor 
ON actor.actor_id = film_actor.actor_id;

-- adding another join to get the titles of wach film each actor stars in 
SELECT actor.actor_id, first_name,last_name,film.film_id, title, description
FROM film_actor
INNER JOIN actor
ON actor.actor_id = film_actor.actor_id
INNER JOIN film
ON film_actor.film_id = film.film_id;

-- ALL of the customers in Angola

SELECT first_name, last_name, customer_id, address.address_id, country.country
FROM customer
LEFT JOIN address
ON customer.address_id = address.address_id
LEFT JOIN city
ON address.city_id = city.city_id
LEFT JOIN country
ON city.country_id = country.country_id
Where country = 'Angola';


-- SUBQUERY A QUERY WITHIN A QUERY WHERE. A PRIMARY KEY EXISTS AS A FOREIGN IN ANOTHER TABLE
-- FIND A CUSTOMER_ID THAT HAS PAID AN AMT GRATER THAN 175
SELECT customer_id, SUM(amount)
FROM payment 
GROUP BY customer_id
HAVING SUM(amount) >175
ORDER BY SUM(amount) DESC;


-- sub query example

SELECT store_id, first_name, last_name
FROM customer 
WHERE customer_id IN( -- this is the query inside the query
	SELECT customer_id
	FROM payment 
	GROUP BY customer_id
	HAVING SUM(amount) > 175
	ORDER BY SUM(amount) DESC
	);

-- join VERSION
SELECT first_name, last_name, SUM(amount)
FROM customer
INNER JOIN payment
ON customer.customer_id = payment.customer_id
GROUP BY first_name, last_name
HAVING SUM(amount) > 175 
ORDER BY SUM(amount) DESC
;

-- subquery 
-- FIND ALL FILMS IN ENGLISH
- Subquery
-- find all films with that are in english
SELECT * 
FROM film
WHERE language_id IN (
	SELECT language_id
	FROM language
	WHERE name = 'English'  -- USE <> FOR NOT EQUAL
);

SELECT * 
FROM address;

--------HOMEWORK ----------
-- #1 
SELECT customer_id, district 
FROM customer
INNER JOIN address
ON customer.address_id = address.address_id
WHERE district = 'Texas';


-- #2 FROM CUSTOMER TO PAYMENT
SELECT customer.customer_id, first_name, last_name, amount
FROM customer 
INNER JOIN payment 
ON customer.customer_id = payment.customer_id
GROUP BY customer.customer_id, first_name, last_name, amount
HAVING (amount) > 6.99;

-- # 3
SELECT first_name, last_name, customer_id
FROM customer
WHERE customer_id IN(
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	HAVING SUM(amount) >175
	ORDER BY SUM(amount) DESC);
	
	


-- #4 
SELECT first_name, last_name, customer_id, address.address_id, country.country
FROM customer
LEFT JOIN address
ON customer.address_id = address.address_id
LEFT JOIN city
ON address.city_id = city.city_id
LEFT JOIN country
ON city.country_id = country.country_id
Where country = 'Nepal';

-- # 5
SELECT first_name, last_name, staff.staff_id, COUNT(staff.staff_id) 
FROM staff
INNER JOIN rental
ON staff.staff_id = rental.staff_id
GROUP BY staff.staff_id
LIMIT 1;

-- #6 
SELECT COUNT(rating), rating 
FROM film
GROUP BY rating;

-- #7 
SELECT customer_id, first_name, last_name
FROM customer
WHERE customer_id IN(
	SELECT payment.customer_id
	FROM payment
	WHERE payment.amount > 6.99
	GROUP BY payment.customer_id
	HAVING COUNT(payment.payment_id) = 1);

-- #8 
SELECT COUNT(amount)
FROM payment
WHERE amount = 0;

SELECT COUNT(amount) FROM payment WHERE amount =0;


