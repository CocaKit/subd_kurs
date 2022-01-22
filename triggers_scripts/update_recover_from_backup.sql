USE mydb;

SET autocommit = 0;
START TRANSACTION;
LOCK TABLES insert_user_backup READ;
SET @login = 'user3';

LOCK TABLES user_info WRITE;

SELECT id_role, id_personal, id_address, login, password_hash, status, registration_date, authorization_date, 
authorization_result, block_start_date, block_end_date, backup_date
INTO @id_role_backup, @id_personal_backup, @id_address_backup, @login_backup, @password_hash_backup, @status_backup, @registration_date_backup, @authorization_date_backup,
@authorization_result_backup, @block_start_date_backup, @block_end_date_backup, @backup_date_backup
FROM insert_user_backup 
WHERE insert_user_backup.login = @login
ORDER BY insert_user_backup.backup_date
LIMIT 1;

UPDATE user_info 
SET id_role = @id_role_backup, id_personal = @id_personal_backup, id_address = @id_address_backup, login = @login_backup, password_hash = @password_hash_backup,
status = @status_backup, registration_date = @registration_date_backup, authorization_date = @authorization_date_backup, 
authorization_result = @authorization_result_backup, block_start_date = @block_start_date_backup, block_end_date = @block_end_date_backup
WHERE insert_user_backup.login = @login;

DELETE FROM insert_user_backup
WHERE insert_user_backup.login = @login AND insert_user_backup.backup_date = @backup_date_backup;

UNLOCK TABLES;
COMMIT;