#Ej 1: Create a view named list_of_customers, it should contain the following columns (No voy a poner toda la consigna :/ )
Create view list_of_customers As
Select c.customer_id, a.address, a.postal_code, a.phone, y.city, country,
Case
	When c.active = 0 Then 'Inactive'
	When c.active = 1 Then 'Active'
	End As 'Active'
From customer c 
Inner join address a
Inner join city y 
Inner join country;

#Ej 2:
Create view film_details As
Select f.film_id, f.title, f.description, c.name, f.replacement_cost As "cost", f.`length`, f.rating, group_concat(CONCAT_WS(' ', a.first_name, a.last_name ) Separator ', ' ) as 'Actors'
From film f 
Inner join film_category fc Using(film_id)
Inner join category c Using(category_id)
Inner join film_actor fa Using(film_id)
Inner join actor a Using(actor_id)
Group by f.film_id, f.title, c.name;

#Ej 3:
Create view sales_by_film_category As
Select c.name, Count(*) As 'Total rental' From category c 
Inner join film_category Using(category_id)
Inner join film Using(film_id)
Inner join inventory Using(film_id)
Inner join rental Using(inventory_id)
Group by c.name;





