USE mydb

DELIMITER //

DROP PROCEDURE IF EXISTS del_user_proc;
CREATE PROCEDURE del_user_proc(login_var varchar(45))
BEGIN
START TRANSACTION;

UPDATE user_info
SET status = 0
WHERE login = login_var;

SELECT count(id) as count FROM user_info WHERE login = login_var;

COMMIT;
END //
