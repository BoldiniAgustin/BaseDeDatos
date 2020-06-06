#Ej 1: List all the actors that share the last name. Show them in order
SELECT *
FROM actor a 
WHERE EXISTS (SELECT *
				FROM actor a2 
				WHERE a.last_name = a2.last_name 
				AND a.actor_id <> a2.actor_id)
ORDER BY last_name;

#Ej 2: Find actors that don't work in any film
INSERT INTO actor (first_name, last_name )
VALUES ("Patoldini", "RedPony");

SELECT *
FROM  actor a
WHERE NOT EXISTS (SELECT *
				FROM film_actor fa
				WHERE a.actor_id = fa.actor_id);

#Ej 3: Find customers that rented only one film
SELECT *
FROM customer c 
WHERE (SELECT COUNT(*)
		FROM rental r
		WHERE c.customer_id = r.customer_id) = 1;

#Ej 4: Find customers that rented more than one film
SELECT *
FROM customer c2 
WHERE (SELECT COUNT(*)
		FROM rental r2 
		WHERE c2.customer_id = r2.customer_id) > 1;

#Ej 5: List the actors that acted in 'BETRAYED REAR' or in 'CATCH AMISTAD'
SELECT * FROM actor a 
WHERE a.actor_id IN (SELECT actor_id FROM film_actor fa 
						WHERE fa.film_id IN (SELECT film_id FROM film f
												WHERE f.title IN ('BETRAYED REAR', 'CATCH AMISTAD')));
											
#Ej 6: List the actors that acted in 'BETRAYED REAR' but not in 'CATCH AMISTAD'
SELECT * FROM actor a 
WHERE a.actor_id IN (SELECT actor_id FROM film_actor fa 
						WHERE fa.film_id IN (SELECT film_id FROM film f
												WHERE f.title = 'BETRAYED REAR'))
AND a.actor_id IN (SELECT actor_id FROM film_actor fa 
						WHERE fa.film_id NOT IN (SELECT film_id FROM film f
												WHERE f.title = 'CATCH AMISTAD'));									

#Ej 7 List the actors that acted in both 'BETRAYED REAR' and 'CATCH AMISTAD'
SELECT * FROM actor a2 
WHERE a2.actor_id IN (SELECT actor_id FROM film_actor fa 
						WHERE fa.film_id IN (SELECT film_id FROM film f2 
												WHERE f2.title = 'BETRAYED REAR'))
AND a2.actor_id IN (SELECT actor_id FROM film_actor fa 
						WHERE fa.film_id IN (SELECT film_id FROM film f2 
												WHERE f2.title = 'CATCH AMISTAD'));

#Ej 8: List all the actors that didn't work in 'BETRAYED REAR' or 'CATCH AMISTAD'
SELECT * FROM actor a
WHERE a.actor_id NOT IN (SELECT actor_id FROM film_actor fa 
						WHERE fa.film_id IN (SELECT film_id FROM film f2 
												WHERE f2.title = 'BETRAYED YEAR'))
AND a.actor_id NOT IN (SELECT actor_id FROM film_actor fa 
						WHERE fa.film_id IN (SELECT film_id FROM film f2
												WHERE f2.title = 'CATCH AMISTAD'));