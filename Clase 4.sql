#Ej 1
SELECT title, special_features
FROM film f 
WHERE f.rating = 'PG-13';
#Ej 2
SELECT length FROM film;
#Ej 3
SELECT title, rental_rate, replacement_cost
FROM film f1 
WHERE f1.replacement_cost BETWEEN 20 AND 24;
#Ej 4
SELECT title, category.name, rating
FROM film f2, category
WHERE f2.special_features = 'Behind The Scenes';
#Ej 5
SELECT first_name, last_name, title
FROM actor a, film
WHERE title = 'ZOOLANDER FICTION';
#Ej 6
SELECT a.address, ci.city, co.country
FROM store, address a, city ci, country co
WHERE store_id = 1;
#Ej 7
#No entendi la consigna
#Ej 8
SELECT title, first_name, last_name 
FROM film, store, staff
WHERE store.store_id = 2;
