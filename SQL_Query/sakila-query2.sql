USE sakila ;
\! echo "Number of documentaries with deleted scenes";
SELECT count(DISTINCT title) AS Total_number
FROM film
INNER JOIN film_category ON film.film_id = film_category.film_id
INNER JOIN category ON category.category_id = film_category.category_id
WHERE name='Documentary'
  AND special_features LIKE '%Deleted Scenes' ;

\! echo "-------------------------------------------------------";
\! echo "Number of sci-fi movies rented by the store managed by Jon Stephens";

SELECT count(DISTINCT film.film_id) AS Total_Film
FROM film_category as fc
INNER JOIN category as c ON fc.category_id = c.category_id
INNER JOIN film ON fc.film_id = film.film_id
INNER JOIN inventory ON film.film_id = inventory.film_id
INNER JOIN rental ON rental.inventory_id = inventory.inventory_id
INNER JOIN staff ON staff.staff_id = rental.staff_id
INNER JOIN store ON staff.store_id = store.store_id
WHERE c.name='Sci-Fi'
  AND first_name = 'Jon'
  AND last_name = 'Stephens' ;

\! echo "-------------------------------------------------------";
\! echo "Total sales from Animation movies";

SELECT SUM(p.amount) AS total_sales
FROM payment AS p
INNER JOIN rental ON p.rental_id = rental.rental_id
INNER JOIN inventory ON rental.inventory_id = inventory.inventory_id
INNER JOIN film ON inventory.film_id = film.film_id
INNER JOIN film_category as fc ON film.film_id = fc.film_id
INNER JOIN category AS c ON film_category.category_id = c.category_id
WHERE c.name = 'Animation';


\! echo "-------------------------------------------------------";
\! echo " top 3 rented category of movies  by “PATRICIA JOHNSON”";


SELECT c.name,
       count(rental_id) AS rented
FROM film
INNER JOIN film_category as fc ON film.film_id =fc.film_id
INNER JOIN category AS c ON fc.category_id = c.category_id
INNER JOIN inventory ON film.film_id = inventory.film_id
INNER JOIN rental ON rental.inventory_id = inventory.inventory_id
INNER JOIN customer AS cs ON rental.customer_id = cs.customer_id
WHERE cs.first_name = 'PATRICIA'
  AND cs.last_name = 'JOHNSON'
GROUP BY c.name
ORDER BY rented DESC
LIMIT 3;



\! echo "-------------------------------------------------------";
\! echo "The number of R rated movies rented by “SUSAN WILSON” ";


SELECT count(rental_id) AS rented
FROM film
INNER JOIN inventory ON film.film_id = inventory.film_id
INNER JOIN rental ON rental.inventory_id = inventory.inventory_id
INNER JOIN customer AS cs ON rental.customer_id = cs.customer_id
WHERE cs.first_name = 'SUSAN'
  AND cs.last_name = 'WILSON'
  AND rating = 'R' ;