#Ej 1: Find the films with less duration, show the title and rating.
SELECT title, rating 
FROM film
WHERE `length` <= ALL (SELECT `length` FROM film);

#Ej 2: Write a query that returns the title of the film which duration is the lowest.
#If there are more than one film with the lowest durtation, the query returns an empty resultset.
#UPDATE film SET `length` = 47 WHERE film.film_id = 69;
SELECT title 
FROM film f1
	WHERE `length` < ALL (SELECT `length` FROM film f2 WHERE f1.film_id <> f2.film_id);	

#Ej: 3. Generate a report with list of customers showing the lowest payments done by each of them.
#Show customer information, the address and the lowest amount, provide both solution using ALL and/or ANY and MIN.
SELECT DISTINCT c1.customer_id, c1.first_name, c1.last_name, MIN(p1.amount), a1.address FROM customer c1
INNER JOIN payment p1
INNER JOIN address a1
WHERE (p1.customer_id = c1.customer_id) AND (c1.address_id = a1.address_id )
GROUP BY c1.customer_id 

#Con ALL/ANY
SELECT DISTINCT c1.customer_id, c1.first_name, c1.last_name, p1.amount, a1.address FROM customer c1
INNER JOIN payment p1
INNER JOIN address a1
WHERE (p1.customer_id = c1.customer_id) 
AND (c1.address_id = a1.address_id )
AND p1.amount <= ALL (SELECT amount
						FROM payment p2 
						WHERE p2.customer_id = c1.customer_id )




 