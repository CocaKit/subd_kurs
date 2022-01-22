USE mydb

DELIMITER //

DROP PROCEDURE IF EXISTS add_vehicle;
CREATE PROCEDURE add_vehicle(manifacturer_var varchar(25), model_var varchar(25), serial_number_var char(10))
BEGIN
START TRANSACTION;

SET @id_manifacturer_vehicle = (SELECT id FROM manifacturer_vehicle WHERE manifacturer_vehicle.name = manifacturer_var);
INSERT INTO manifacturer_vehicle(name) 
 SELECT manifacturer_var
 WHERE (@id_manifacturer_vehicle IS NULL);
SELECT IF(@id_manifacturer_vehicle IS NULL, LAST_INSERT_ID(), @id_manifacturer_vehicle)
INTO @id_manifacturer_vehicle;

INSERT INTO vehicle(id_manufacturer_vehicle, model, serial_number)
VALUES (@id_manifacturer_vehicle, model_var, serial_number_var);
COMMIT;
END //
