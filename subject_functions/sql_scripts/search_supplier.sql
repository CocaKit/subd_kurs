USE mydb
 
DELIMITER //

DROP PROCEDURE IF EXISTS search_supplier;
CREATE PROCEDURE search_supplier(supplier_name_var varchar(50), company_name_var varchar(50))
BEGIN
START TRANSACTION;
SELECT supplier_carparts.name AS supplier_name, company.name AS company_name
FROM supplier_carparts 
 INNER JOIN (SELECT * FROM company) AS company
 ON supplier_carparts.id_company = company.id 
WHERE COALESCE	(supplier_carparts.name, '') LIKE CONCAT('%',supplier_name_var,'%')
 AND COALESCE(company.name, '') LIKE CONCAT('%',company_name_var,'%')
ORDER BY company.name;
END //