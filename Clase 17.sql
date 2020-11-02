#Ej 1: Create two or three queries using address table in sakila db.
SELECT a.postal_code FROM address a 
WHERE a.postal_code IN (SELECT a.postal_code FROM address a
  INNER JOIN city c USING(city_id)
  INNER JOIN country co USING(country_id)
  WHERE co.country LIKE('%Philippines%'));
#Time: 4ms

SELECT a.postal_code FROM address a
WHERE a.postal_code NOT IN (SELECT a.postal_code FROM address a 
  INNER JOIN city c USING(city_id)
  INNER JOIN country co USING(country_id)
  WHERE co.country LIKE('%Brazil%'));
#Time: 4ms

SELECT a.postal_code FROM address a;  
#Time: 4ms
CREATE INDEX postal_code ON address(postal_code);

#Se redujo el tiempo de ejecucion en 1ms en todos los casos. Se traduce a un 25% de mejora en tiempo, lo cual demuestra que los indices optimizan las queries considerablemente.

SELECT a.first_name FROM film f 
INNER JOIN film_actor fa USING(film_id)
INNER JOIN actor a USING(actor_id)
WHERE a.first_name LIKE('A%');
#Time: 6ms

SELECT a.last_name FROM film f
INNER JOIN film_actor fa USING(film_id)
INNER JOIN actor a USING(actor_id)
WHERE a.last_name LIKE('A%');
#Time: 2ms

#La query de lastname es mas rapida que la de firstname porque la primera tiene un INDEX y la ultima NO.

ALTER TABLE film_text 
ADD FULLTEXT(description);

SELECT ft.description FROM film_text ft
WHERE MATCH(description) AGAINST('Dentist');
#Time: 2ms

SELECT f.description FROM film f
WHERE f.description LIKE ('%Dentist%');
#Time: 5ms

#Match against es considerablemente mas rapido que buscar por like