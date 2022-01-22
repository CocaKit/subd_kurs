USE mydb

DELIMITER //

DROP PROCEDURE IF EXISTS auth_proc;
CREATE PROCEDURE auth_proc(login_var varchar(45), password_var varchar(45), salt_var char(6))
BEGIN

START TRANSACTION;

SELECT id
INTO @id
FROM user_info
WHERE login = login_var AND password_var = SHA(CONCAT(password_hash, salt_var)) AND status = 1;

UPDATE user_info
SET authorization_result = 1 ,
	authorization_date = current_timestamp(),
    status = 2
WHERE id = @id;

SELECT @id IS NULL;
COMMIT;

END //
