#Ej 4: Find all the film titles that are not in the inventory.
SELECT f.title FROM film f
LEFT JOIN inventory i USING (film_id)
WHERE inventory_id IS NULL;

#Ej 5: Find all the films that are in the inventory but were never rented.
SELECT f.title, i.inventory_id FROM film f
INNER JOIN inventory USING (film_id)


