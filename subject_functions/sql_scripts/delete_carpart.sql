USE mydb

DELIMITER //

DROP PROCEDURE IF EXISTS delete_carpart;
CREATE PROCEDURE delete_carpart(name_var varchar(75))
BEGIN
START TRANSACTION;

DELETE FROM store_carparts WHERE store_carparts.name = name_var;

SET @id_carpart = (SELECT id FROM store_carparts WHERE store_carparts.name = name_var);
SET @carpart_dont_exists = IF (@id_carpart IS NULL, 1, 0);

SELECT @carpart_dont_exists;
COMMIT;

END //
