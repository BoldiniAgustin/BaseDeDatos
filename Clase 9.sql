#Ej 1: Get the amount of cities per country in the database. Sort them by country, country_id.
SELECT co.country, COUNT(*) AS 'Numero de Ciudades' FROM city ci
INNER JOIN country co ON (ci.country_id = co.country_id)
GROUP BY co.country_id 
ORDER BY co.country_id, co.country;

#Ej 2: Get the amount of cities per country in the database. Show only the countries with more than 10 cities, order from the highest amount of cities to the lowest
SELECT co.country, COUNT(*) AS 'Numero de Ciudades' FROM city ci
INNER JOIN country co ON (ci.country_id = co.country_id)
GROUP BY co.country_id
HAVING COUNT(*) > 10
ORDER BY COUNT(*) DESC;

#Ej 3: Generate a report with customer (first, last) name, address, total films rented and the total money spent renting films.
SELECT c.first_name, c.last_name, a.address, COUNT(*) AS 'Peliculas alquiladas' ,SUM(p.amount) AS 'Dinero gastado' FROM rental
INNER JOIN customer c USING (customer_id)
INNER JOIN address a USING (address_id)
INNER JOIN payment p USING (rental_id)
GROUP BY c.customer_id
ORDER BY SUM(p.amount) DESC;

#Ej 4: Which film categories have the larger film duration (comparing average)?
SELECT c.name, AVG(`length`) AS 'Duracion promedio' FROM film f
INNER JOIN film_category fc ON (f.film_id = fc.film_id )
INNER JOIN category c ON (c.category_id = fc.category_id)
GROUP BY fc.category_id 
HAVING AVG(`length`) > (SELECT AVG(`length`) FROM film)
ORDER BY AVG(`length`) DESC;

#Ej 5: Show sales per film rating
SELECT f.rating, SUM(p.amount) AS sales FROM payment p
    INNER JOIN rental r ON p.rental_id = r.rental_id
    INNER JOIN inventory i ON r.inventory_id = i.inventory_id
    INNER JOIN film f ON i.film_id = f.film_id
    GROUP BY f.rating;





