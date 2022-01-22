USE mydb
 
DELIMITER //

DROP PROCEDURE IF EXISTS search_manufacturer;
CREATE PROCEDURE search_manufacturer(manufacturer_name_var varchar(50), company_name_var varchar(50))
BEGIN
START TRANSACTION;
SELECT manufacturer_carparts.name AS manufacturer_name, company.name AS company_name
FROM manufacturer_carparts 
 INNER JOIN (SELECT * FROM company) AS company
 ON manufacturer_carparts.id_company = company.id 
WHERE COALESCE	(manufacturer_carparts.name, '') LIKE CONCAT('%',manufacturer_name_var,'%')
 AND COALESCE(company.name, '') LIKE CONCAT('%',company_name_var,'%')
ORDER BY company.name;
END //