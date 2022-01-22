USE mydb

DELIMITER //

DROP PROCEDURE IF EXISTS add_supplier_carparts;
CREATE PROCEDURE add_supplier_carparts(supplier_name_var varchar(50), company_name_var varchar(80))
BEGIN
START TRANSACTION;

SET @id_company = (SELECT id FROM company WHERE company.name = company_name_var);
SET @company_dont_exists = IF (@id_company IS NULL, 1, 0);
SET @rollback_script = IF (@company_dont_exists, 'ROLLBACK', 'COMMIT');
PREPARE rollback_statement FROM @rollback_script;

IF NOT @company_dont_exists
THEN
INSERT INTO supplier_carparts
(id_company, name)
SELECT @id_company, supplier_name_var;
END IF;

SELECT @company_dont_exists;
EXECUTE rollback_statement;

END//