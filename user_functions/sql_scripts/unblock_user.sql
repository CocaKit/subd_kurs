USE mydb

DELIMITER //

DROP PROCEDURE IF EXISTS unblock_user_proc;
CREATE PROCEDURE unblock_user_proc(login_var varchar(45))
BEGIN

START TRANSACTION;

SELECT status FROM user_info WHERE login = login_var INTO @status;

SET @rollback_script = IF(@status = 0, 'ROLLBACK', 'COMMIT');
PREPARE rollback_statement FROM @rollback_script;

UPDATE user_info
SET block_end_date = NULL, 
block_start_date = NULL, 
status = 1 
WHERE login = login_var;

SELECT count(id) as count, @status FROM user_info WHERE login = login_var;

EXECUTE rollback_statement;
END //
