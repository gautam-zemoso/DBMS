USE sakila ;

\! echo "PG-13 rated comedy movies";


SELECT title
FROM film
INNER JOIN film_category as fc ON fc.film_id = film.film_id
INNER JOIN category as c ON fc.category_id = c.category_id
WHERE rating = "PG-13"
  AND c.name  = 'comedy' ;

\! echo "-------------------------------------------------------";

\! echo "Top 3 rented horror movies";


SELECT film.film_id,
       title,
       count(r.rental_id) AS rented
FROM film_category as fc
INNER JOIN film ON fc.film_id = film.film_id
INNER JOIN inventory as i ON film.film_id = i.film_id
INNER JOIN rental as r ON r.inventory_id = i.inventory_id
INNER JOIN category as c ON fc.category_id = c.category_id
WHERE c.name = 'horror'
GROUP BY film.film_id
ORDER BY rented DESC
LIMIT 3;

\! echo "-------------------------------------------------------";

\! echo "List of customers from India who have rented sports movies";


SELECT DISTINCT cl.name AS customer_name
FROM film_category as fc
INNER JOIN film ON fc.film_id = film.film_id
INNER JOIN category as c ON fc.category_id = c.category_id
INNER JOIN inventory ON film.film_id = inventory.film_id
INNER JOIN rental ON rental.inventory_id = inventory.inventory_id
INNER JOIN customer_list as cl ON cl.ID = rental.customer_id
WHERE c.name = 'sports'
  AND country = 'india'
ORDER BY customer_name ;

\! echo "-------------------------------------------------------";

\! echo "List of customers from Canada who have rented “NICK WAHLBERG” movies";

\! echo "Method 1"
SELECT DISTINCT cl.name AS customer_name
FROM film_list
INNER JOIN inventory ON film_list.FID = inventory.film_id
INNER JOIN rental ON rental.inventory_id = inventory.inventory_id
INNER JOIN customer_list as cl ON cl.ID = rental.customer_id
WHERE country = 'canada'
  AND actors LIKE '%NICK WAHLBERG%'
ORDER BY customer_name ;

\! echo "Method 2"
SELECT DISTINCT cl.name AS customer_name
FROM actor
INNER JOIN film_actor as fa ON actor.actor_id = fa.actor_id
INNER JOIN inventory ON fa.film_id = inventory.film_id
INNER JOIN rental ON rental.inventory_id = inventory.inventory_id
INNER JOIN customer_list as cl ON cl.ID = rental.customer_id
WHERE first_name = 'NICK'
  AND last_name = 'WAHLBERG'
  AND country = 'canada'
ORDER BY customer_name ;

\! echo "-------------------------------------------------------";

\! echo "Number of movies in which “SEAN WILLIAMS” acted"
SELECT count(film_id) AS Total_Movies
FROM actor
INNER JOIN film_actor ON actor.actor_id = film_actor.actor_id
WHERE first_name = 'SEAN'
  AND last_name = 'WILLIAMS' ;

