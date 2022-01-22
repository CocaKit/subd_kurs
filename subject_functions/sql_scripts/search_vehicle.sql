USE mydb
 
DELIMITER //

DROP PROCEDURE IF EXISTS search_vehicle;
CREATE PROCEDURE search_vehicle(manufacturer_name_var varchar(50), model_var varchar(25), serial_number_var varchar(10))
BEGIN
START TRANSACTION;
SELECT vehicle.model AS vehicle_model, manifacturer_vehicle.name AS manifacturer_vehicle, vehicle.serial_number AS vehicle_serial_number
FROM vehicle 
 INNER JOIN (SELECT * FROM manifacturer_vehicle) AS manifacturer_vehicle
 ON vehicle.id_manufacturer_vehicle = manifacturer_vehicle.id 
WHERE COALESCE	(manifacturer_vehicle.name, '') LIKE CONCAT('%',manufacturer_name_var,'%')
 AND COALESCE(vehicle.model, '') LIKE CONCAT('%',model_var,'%')
 AND COALESCE(vehicle.serial_number, '') LIKE CONCAT('%',serial_number_var,'%')
ORDER BY manifacturer_vehicle.name;
END //