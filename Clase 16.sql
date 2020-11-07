USE sakila;
CREATE TABLE `employees` (
  `employeeNumber` int(11) NOT NULL,
  `lastName` varchar(50) NOT NULL,
  `firstName` varchar(50) NOT NULL,
  `extension` varchar(10) NOT NULL,
  `email` varchar(100) NOT NULL,
  `officeCode` varchar(10) NOT NULL,
  `reportsTo` int(11) DEFAULT NULL,
  `jobTitle` varchar(50) NOT NULL,
  PRIMARY KEY (`employeeNumber`)
);

INSERT INTO `employees`(`employeeNumber`,`lastName`,`firstName`,`extension`,`email`,`officeCode`,`reportsTo`,`jobTitle`) VALUES 

(1002,'Murphy','Diane','x5800','dmurphy@classicmodelcars.com','1',NULL,'President'),

(1056,'Patterson','Mary','x4611','mpatterso@classicmodelcars.com','1',1002,'VP Sales'),

(1076,'Firrelli','Jeff','x9273','jfirrelli@classicmodelcars.com','1',1002,'VP Marketing');

CREATE TABLE employees_audit (
    id INT AUTO_INCREMENT PRIMARY KEY,
    employeeNumber INT NOT NULL,
    lastname VARCHAR(50) NOT NULL,
    changedat DATETIME DEFAULT NULL,
    ACTION VARCHAR(50) DEFAULT NULL
);

#Insert a new employee to , but with an null email. Explain what happens.

INSERT INTO `employees`(`employeeNumber`,`lastName`,`firstName`,`extension`,`email`,`officeCode`,`reportsTo`,`jobTitle`) VALUES 
(512,'Mark','Zuccus','x7245',NULL,'263',NULL,'Administrator')
#La linea email posee un NOT NULL, lo que hace que no se le pueda ingresar un valor nulo.

UPDATE employees SET employeeNumber = employeeNumber - 20
#Cambia el valor de employee number, restandole 20
UPDATE employees SET employeeNumber = employeeNumber + 20
#Cambia el valor de employee number, sumandole 20

ALTER TABLE employees 
    ADD AGE INT ;

#Add an age column to the table employee where and it can only accept values from 16 up to 70 years old.
CREATE TRIGGER insert_employees BEFORE 
INSERT ON employees
FOR EACH ROW 
    BEGIN 
        IF NOT NEW.AGE BETWEEN 17 AND 70 THEN 
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: La edad del empleado debe estar entre los 17 y 70 años de edad';
    END IF;
    END;

ALTER TABLE employees
  ADD age INT

insert  into `employees`(`employeeNumber`,`lastName`,`firstName`,`extension`,`email`,`officeCode`,`reportsTo`,`jobTitle`,`age`) VALUES 
(512,'Mark','Zuccus','x7245','markzucczucc@succ.com','263',NULL,'Administrator',27)


#Ej 4: actor y film tiene una relacion M-M, un actor puede estar en varias peliculas y cada pelicula tiene multiples actores.
# - Se utiliza una tabla intermedia para pdoer relacionarlas, se llama film_actor.
# - Posee una id hacia film y otra hacia actor, haciendo esto se ahorra la rebundancia que se causaria por, por ejemplo, mencionar a un actor en cada pelicula que aparece.
 
#Create a new column called lastUpdate to table employee 
# * and use trigger(s) to keep the date-time updated on inserts and updates operations. Bonus: add a column lastUpdateUser and the respective 
# * trigger(s) to specify who was the last MySQL user that changed the row (assume multiple users, other than root, can connect to MySQL and change this table).*/


ALTER TABLE employees
  ADD last_update DATETIME DEFAULT NULL;
ALTER TABLE employees
  ADD lastUpdateUser varchar(255) DEFAULT NULL;

#DATE 
CREATE TRIGGER insert_last_update BEFORE 
INSERT ON employees
FOR EACH ROW 
    BEGIN 
        SET NEW.last_update = CURRENT_TIMESTAMP(); 
    END;
   
CREATE TRIGGER update_last_update BEFORE 
UPDATE ON employees
FOR EACH ROW 
    BEGIN 
        SET NEW.last_update = CURRENT_TIMESTAMP(); 
    END;
   
#USER
CREATE TRIGGER insert_lastUpdateUser BEFORE 
INSERT ON employees
FOR EACH ROW 
    BEGIN 
        SET NEW.lastUpdateUser = USER();
    END;

CREATE TRIGGER update_lastUpdateUser BEFORE 
UPDATE ON employees
FOR EACH ROW 
    BEGIN 
        SET NEW.lastUpdateUser = USER();
    END;
   
INSERT INTO `employees`(`employeeNumber`,`lastName`,`firstName`,`extension`,`email`,`officeCode`,`reportsTo`,`jobTitle`,`age`) VALUES 
(511,'Markiplier','Zuccus','x7245','markzucczucc@succ.com','263',NULL,'Administrator',27);
UPDATE employees SET firstName = 'Super_Clown' WHERE employeeNumber = 423;

#Find all the triggers in sakila db related to loading film_text table. What do they do? Explain each of them using its source code for the explanation.

CREATE DEFINER=`root`@`localhost` TRIGGER `insert_film` AFTER INSERT ON `film` FOR EACH ROW BEGIN
    INSERT INTO film_text (film_id, title, description)
        VALUES (NEW.film_id, NEW.title, NEW.description);
  END;

#El trigger insert_film inserta en la tabla film_text la id, titulo y descripcion del insert cuando se realiza un insert a la tabla film.
# - Inserta en la tabla film_text los datos que se insertaron a film de forma automatica.
  
CREATE DEFINER=`root`@`localhost` TRIGGER `update_film` AFTER UPDATE ON `film` FOR EACH ROW BEGIN
    IF (OLD.title != NEW.title) OR (OLD.description != NEW.description) OR (OLD.film_id != NEW.film_id)
    THEN
        UPDATE film_text
            SET title=NEW.title,
                description=NEW.description,
                film_id=NEW.film_id
        WHERE film_id=OLD.film_id;
    END IF;
  END;

#El trigger update_film actualiza la tabla film_text con los datos nuevos cuando se realize un update a la tabla film.
# - El titulo de esa pelicula es actualizada en la tabla film_text.

CREATE DEFINER=`root`@`localhost` TRIGGER `delete_film` AFTER DELETE ON `film` FOR EACH ROW BEGIN
    DELETE FROM film_text WHERE film_id = OLD.film_id;
  END;
#El trigger delete_film borra la pelicula en la tabla film_text cuando se borra una pelicula de la tabla film.
