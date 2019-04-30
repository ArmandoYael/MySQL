-- 1
SELECT first_name, last_name FROM sakila.actor;
SELECT actor_id, UPPER (CONCAT (first_name, " ", last_name)) AS actor_name FROM sakila.actor;

-- 2
SELECT actor_id,first_name,last_name FROM sakila.actor WHERE first_name LIKE 'JOE';
SELECT actor_id,first_name,last_name FROM sakila.actor WHERE last_name LIKE '%GEN%';
SELECT actor_id,last_name,first_name FROM sakila.actor WHERE last_name LIKE '%LI%' ORDER BY last_name,first_name;
SELECT country_id,country FROM sakila.country WHERE country IN ('Afghanistan','Bangladesh','China');

-- 3
SELECT * FROM sakila.actor;
USE sakila;
ALTER TABLE actor ADD description BLOB;
USE sakila;
ALTER TABLE sakila.actor DROP COLUMN description;
SELECT * FROM actor;

-- 4
SELECT sakila.actor, COUNT(*) FROM actor GROUP BY last_name;
SELECT last_name, COUNT(*) FROM sakila.actor group by last_name;
SELECT last_name, COUNT(*) FROM sakila.actor GROUP BY last_name HAVING COUNT(*) >=2;
SELECT actor_id, first_name, last_name FROM sakila.actor WHERE last_name = 'WILLIAMS';
UPDATE sakila.actor SET first_name = 'HARPO' WHERE actor_id = 172;
SELECT actor_id, first_name, last_name FROM sakila.actor WHERE last_name = 'WILLIAMS';
UPDATE sakila.actor SET first_name = 'GROUCHO' WHERE first_name = 'HARPO';
SELECT actor_id, first_name, last_name FROM sakila.actor WHERE last_name = 'WILLIAMS';

-- 5
SHOW CREATE TABLE address;

-- 6 
SELECT staff.first_name, staff.last_name, address.address FROM staff LEFT JOIN address ON staff.address_id = address.address_id;
SELECT staff.first_name, sum(payment.amount) FROM staff INNER JOIN payment ON payment.staff_id = staff.staff_id WHERE payment_date like '%2005-08%' GROUP BY staff.first_name;
SELECT film.title, count(film_actor.actor_id) FROM film_actor INNER JOIN film ON film_actor.film_id = film.film_id GROUP BY film.title;
SELECT film.title, count(inventory.film_id) FROM inventory INNER JOIN film ON inventory.film_id = film.film_id  WHERE film.title like '%HUNCHBACK IMPOSSIBLE%' GROUP BY film.title;
SELECT customer.first_name, customer.last_name, sum(payment.amount) FROM customer LEFT JOIN payment ON customer.customer_id = payment.customer_id GROUP BY customer.customer_id ORDER BY customer.last_name ASC;

-- 7
SELECT film.title, language.name FROM film INNER JOIN language ON language.language_id = film.language_id WHERE title LIKE 'K%' OR title LIKE 'Q%' AND language.language_id = '1';  
SELECT film.film_id, film.title FROM film WHERE film.title LIKE 'ALONE TRIP';
SELECT actor.first_name, actor.last_name FROM actor LEFT JOIN film_actor ON actor.actor_id = film_actor.actor_id WHERE film_actor.film_id = '17';
SELECT customer.address_id, customer.mail, address.city_id, city.country_id FROM customer LEFT JOIN address ON customer.address_id = address.address_id LEFT JOIN city ON address.city_id = city.city_id; 
SELECT customer.address_id, customer.email, address.city_id, city.country_id FROM customer LEFT JOIN address ON customer.address_id = address.address_id LEFT JOIN city ON address.city_id = city.city_id LEFT JOIN country ON city.country_id = country.country_id WHERE country.country_id = '20'; 
SELECT film.title, category.name FROM film LEFT JOIN film_category ON film.film_id = film_category.film_id LEFT JOIN category ON film_category.category_id = category.category_id WHERE category.name LIKE '%Family%';
SELECT title, rental_rate FROM sakila.film ORDER BY film.rental_rate DESC;
SELECT staff.store_id, sum(payment.amount) FROM payment LEFT JOIN staff ON payment.staff_id = staff.staff_id GROUP BY payment.staff_id;
SELECT store.store_id, address.address, city.city, country.country FROM store LEFT JOIN address ON store.address_id = address.address_id LEFT JOIN city ON address.city_id = city.city_id LEFT JOIN country ON city.country_id = country.country_id;
SELECT category.name, sum(payment.amount) FROM payment LEFT JOIN rental ON payment.rental_id = rental.inventory_id LEFT JOIN inventory ON rental.inventory_id = inventory.inventory_id LEFT JOIN film_category ON inventory.film_id = film_category.film_id LEFT JOIN category ON film_category.category_id = category.category_id WHERE category.name IS NOT NULL GROUP BY category.name ORDER BY sum(payment.amount) DESC LIMIT 5;

-- 8
CREATE VIEW executive_view AS SELECT category.name, sum(payment.amount) FROM payment LEFT JOIN rental ON payment.rental_id = rental.inventory_id LEFT JOIN inventory ON rental.inventory_id = inventory.inventory_id LEFT JOIN film_category ON inventory.film_id = film_category.film_id LEFT JOIN category ON film_category.category_id = category.category_id WHERE category.name IS NOT NULL GROUP BY category.name ORDER BY sum(payment.amount) DESC LIMIT 5;
SELECT * FROM executive_view;
DROP VIEW executive_view;

