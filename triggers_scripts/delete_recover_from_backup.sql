USE mydb;

SET autocommit = 0;
START TRANSACTION;
LOCK TABLES delete_user_backup READ;
SET @login = 'user3';

LOCK TABLES user_info WRITE;
INSERT INTO user_info(id, id_role, id_personal, id_address, login, password_hash, status, registration_date, authorization_date, 
authorization_result, block_start_date, block_end_date)

SELECT id, id_role, id_personal, id_address, login, password_hash, status, registration_date, authorization_date, 
authorization_result, block_start_date, block_end_date
FROM delete_user_backup 
WHERE delete_user_backup.login = @login;

DELETE FROM delete_user_backup
WHERE delete_user_backup.login = @login;

UNLOCK TABLES;
COMMIT;
