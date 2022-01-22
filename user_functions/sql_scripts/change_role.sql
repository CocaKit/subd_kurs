USE mydb

DELIMITER //

DROP PROCEDURE IF EXISTS role_user_proc;
CREATE PROCEDURE role_user_proc(login_var varchar(45), role_var SMALLINT)
BEGIN
START TRANSACTION;

UPDATE user_info
SET id_role = role_var
WHERE login = login_var;

SELECT count(id) as count FROM user_info WHERE login = login_var;

COMMIT;
END //