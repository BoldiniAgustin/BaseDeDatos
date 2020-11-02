
#Ej 1: Write a query that gets all the customers that live in Argentina.
SELECT CONCAT_WS(' ', first_name, last_name) as 'full_name', a.address, c.city FROM customer
	INNER JOIN address a USING (address_id)
	INNER JOIN city c USING (city_id)
	INNER JOIN country co USING (country_id)
	WHERE country = 'Argentina';


#Ej 2: Write a query that shows the film title, language and rating.
SELECT f.title, `language`.name, 
CASE
	WHEN rating = 'PG' THEN '(Parental Guidance Suggested) Some material may not be suitable for children'
	WHEN rating = 'G' THEN '(General Audiences) All ages admitted'
	WHEN rating = 'NC-17' THEN ' (Adults Only) No one 17 and under admitted'
	WHEN rating = 'PG-13' THEN '(Parents Strongly Cautioned) Some material may be inappropriate for children under 13'
	WHEN rating = 'R' THEN '(Restricted) Under 17 requires accompanying parent or adult guardian'
END AS `rating`
FROM film f
INNER JOIN `language` USING (language_id);


#Ej 3: Write a search query that shows all the films (title and release year) an actor was part of.
SELECT f.title, f.release_year, CONCAT_WS(' ', a.first_name, a.last_name) AS `full_name` FROM film f
	INNER JOIN film_actor fa USING (film_id)
	INNER JOIN actor a USING (actor_id)
	WHERE a.actor_id IN (SELECT a.actor_id FROM actor a WHERE CONCAT_WS(' ', a.first_name, a.last_name) REGEXP UPPER('^(penelope guiness)'));


#Ej 4: Find all the rentals done in the months of May and June. Show the film title, customer name and if it was returned or not.
SELECT f.title, CONCAT_WS(' ', c.first_name, c.last_name) AS `full_name`,
  CASE WHEN r.return_date IS NOT NULL THEN 'Yes'
  ELSE 'No' 
END AS `returned` FROM rental r
	INNER JOIN customer c USING (customer_id)
	INNER JOIN inventory i USING (inventory_id)
	INNER JOIN film f USING (film_id)
	WHERE MONTH(r.rental_date) IN (5, 6);
	

#Ej 5: Investigate CAST and CONVERT functions. Explain the differences if any, write examples based on sakila DB. 
#Example: Show the payment date of 
SELECT CAST(p.payment_date AS DATE) AS "Formatted Date", p.payment_date AS "Not Formatted Date" FROM payment p ;

/* Ej 6:
Investigate NVL, ISNULL, IFNULL, COALESCE, etc type of function. Explain what they do, 
which ones are not in MySql and write usage examples. 
NVL() disponible en Oracle. Devuelve true si la expresion es null, sino retorna false.
ISNULL() disponible en SQL Server. Devuelve la expresion si no es null, sino la alternativa.
IFNULL(expression, alternative) devuelve la alternativa si la expresion es null.
Example: 
SELECT title, description, language_id, IFNULL(original_language_id, language_id) AS `original_language_id` FROM film;
COALESCE(...list) returns the first value that isn't null in a list.
Example:
SELECT COALESCE(NULL, 1, 'HI THERE'); will return 1 */