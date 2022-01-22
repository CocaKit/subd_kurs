USE mydb

DELIMITER //

DROP PROCEDURE IF EXISTS add_carpart;
CREATE PROCEDURE add_carpart(carpart_name_var varchar(75), carpart_cost_var varchar(45), description_var varchar(200), manufacturer_name_var varchar(50), 
supplier_name_var varchar(50))
BEGIN
START TRANSACTION;

SET @id_description = (SELECT id FROM description WHERE description.name = description_var);
INSERT INTO description(name) 
 SELECT description_var
 WHERE @id_description IS NULL;
SELECT IF(@id_description IS NULL, LAST_INSERT_ID(), @id_description)
INTO @id_description;

SET @id_manufacturer = (SELECT id FROM manufacturer_carparts WHERE manufacturer_carparts.name = manufacturer_name_var);
SET @manufacturer_dont_exists = IF (@id_manufacturer IS NULL, 1, 0);

SET @id_supplier = (SELECT id FROM supplier_carparts WHERE supplier_carparts.name = supplier_name_var);
SET @supplier_dont_exists = IF (@id_supplier IS NULL, 1, 0);

SET @rollback_script = IF (@manufacturer_dont_exists OR @supplier_dont_exists, 'ROLLBACK', 'COMMIT');
PREPARE rollback_statement FROM @rollback_script;

IF NOT @manufacturer_dont_exists AND NOT @supplier_dont_exists
THEN
INSERT INTO store_carparts
(id_manufacturer_carparts, id_supplier_carparts, id_description, name, cost)
SELECT @id_manufacturer, @id_supplier, @id_description, carpart_name_var, carpart_cost_var;
END IF;

SELECT @manufacturer_dont_exists, @supplier_dont_exists;
EXECUTE rollback_statement;

END//