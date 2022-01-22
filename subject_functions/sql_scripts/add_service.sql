USE mydb

DELIMITER //

DROP PROCEDURE IF EXISTS add_service;
CREATE PROCEDURE add_service(name_var varchar(75))
BEGIN
START TRANSACTION;

INSERT INTO store_service
(name)
VALUES (name_var);

COMMIT;
END //