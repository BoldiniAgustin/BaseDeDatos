#Ej 1: UwU
SELECT CONCAT(first_name, ' ',last_name ) AS 'Name ', a2.address, c3.city FROM customer c, country c2, address a2, city c3 
WHERE c2.country = 'Argentina';

#Ej 2: OwO
SELECT f.title, l.name AS 'Language', 
CASE 
	WHEN rating = 'G' THEN 'General Audiences'
	WHEN rating = 'PG' THEN 'Parental Guidance Suggested'
	WHEN rating = 'PG-13' THEN 'Parents Strongly Cautioned'
	WHEN rating = 'R' THEN 'Restricted' END AS 'Rating'
FROM film f 
INNER JOIN `language` l

#Ej 3: ewe
#SINTAXIS