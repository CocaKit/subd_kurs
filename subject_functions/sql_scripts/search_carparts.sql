USE mydb
 
DELIMITER //

DROP PROCEDURE IF EXISTS search_carpart;
CREATE PROCEDURE search_carpart(carpart_name_var varchar(75), cost_var varchar(45), manufacturer_name_var varchar(50), supplier_name_var varchar(50), 
description_var varchar(200))
BEGIN
START TRANSACTION;

SELECT store_carparts.name AS carpart_name, store_carparts.cost AS carpart_cost, manufacturer_carparts.name AS manufacturer_name, 
supplier_carparts.name AS supplier_name, description.name AS description_name
FROM store_carparts 
 INNER JOIN (SELECT * FROM manufacturer_carparts) AS manufacturer_carparts
 ON store_carparts.id_manufacturer_carparts = manufacturer_carparts.id 
 INNER JOIN (SELECT * FROM supplier_carparts) AS supplier_carparts
 ON store_carparts.id_supplier_carparts = supplier_carparts.id 
 INNER JOIN (SELECT * FROM description) AS description
 ON store_carparts.id_description = description.id 
WHERE COALESCE(store_carparts.name, '') LIKE CONCAT('%',carpart_name_var,'%')
 AND COALESCE(store_carparts.cost, '') LIKE CONCAT('%',cost_var,'%')
 AND COALESCE(manufacturer_carparts.name, '') LIKE CONCAT('%',manufacturer_name_var,'%')
 AND COALESCE(supplier_carparts.name, '') LIKE CONCAT('%',supplier_name_var,'%')
 AND COALESCE(description.name, '') LIKE CONCAT('%',description_var,'%')
ORDER BY store_carparts.cost;

COMMIT;
END //