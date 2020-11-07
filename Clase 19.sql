#Create a user data_analyst

CREATE USER data_analyst 
IDENTIFIED BY 'password';

SELECT USER FROM mysql.USER;

SHOW GRANTS FOR 'data_analyst';

#Grant permissions only to SELECT, UPDATE and DELETE to all sakila tables to it.

GRANT SELECT,UPDATE,DELETE ON *.* TO 'data_analyst' WITH GRANT OPTION;
#SQL Error [1142] [42000]: CREATE command denied to user 'data_analyst'@'172.17.0.1' for table 'tape'.
#El user data_analyst no tiene privilegios para crear una tabla, entonces se le niega la accion.

UPDATE sakila.film
SET title='Boring Movie', last_update=CURRENT_TIMESTAMP
WHERE film_id=0;

REVOKE  UPDATE ON *.*  FROM data_analyst;

#SQL Error [1142] [42000]: UPDATE command denied to user 'data_analyst'@'172.17.0.1' for table 'film'.
#Ya que se le revocaron los permisos de update a data_analyst, el sistema vuelve a negar la accion.