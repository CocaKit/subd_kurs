USE mydb

DELIMITER //

DROP PROCEDURE IF EXISTS add_manufacturer_carparts;
CREATE PROCEDURE add_manufacturer_carparts(manufacturer_name_var varchar(50), company_name_var varchar(80))
BEGIN
START TRANSACTION;

SET @id_company = (SELECT id FROM company WHERE company.name = company_name_var);
SET @company_dont_exists = IF (@id_company IS NULL, 1, 0);
SET @rollback_script = IF (@company_dont_exists, 'ROLLBACK', 'COMMIT');
PREPARE rollback_statement FROM @rollback_script;

IF NOT @company_dont_exists
THEN
INSERT INTO manufacturer_carparts
(id_company, name)
SELECT @id_company, manufacturer_name_var;
END IF;

SELECT @company_dont_exists;
EXECUTE rollback_statement;

END//