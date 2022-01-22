USE mydb

DELIMITER //

DROP PROCEDURE IF EXISTS block_user_proc;
CREATE PROCEDURE block_user_proc(login_var varchar(45), days_var tinyint)

BEGIN
START TRANSACTION;

SELECT status FROM user_info WHERE login = login_var INTO @status;

SET @rollback_script = IF(@status = 0, 'ROLLBACK', 'COMMIT');
SET @block_end_date = IF(days_var = -1, '2038-01-19 03:14:07', CURRENT_TIMESTAMP() + INTERVAL days_var DAY);
PREPARE rollback_statement FROM @rollback_script;

UPDATE user_info
SET block_end_date = @block_end_date, 
block_start_date = CURRENT_TIMESTAMP(), 
status = 3 
WHERE login = login_var;

SELECT count(id) as count, @status FROM user_info WHERE login = login_var;

EXECUTE rollback_statement;
END //
