USE mydb;
-- SET GLOBAL log_bin_trust_function_creators = 1;

DROP TRIGGER IF EXISTS backup_update_user_trigger;
DROP TRIGGER IF EXISTS backup_delete_user_trigger;

CREATE TRIGGER backup_update_user_trigger 
BEFORE UPDATE
ON user_info
FOR EACH ROW 

INSERT INTO insert_user_backup(id, id_role, id_personal, id_address, login, password_hash, status, registration_date, authorization_date, 
authorization_result, block_start_date, block_end_date, backup_date)

SELECT id, id_role, id_personal, id_address, login, password_hash, status, registration_date, authorization_date, 
authorization_result, block_start_date, block_end_date, current_timestamp()

FROM user_info
WHERE user_info.id = old.id;


CREATE TRIGGER backup_delete_user_trigger 
BEFORE DELETE
ON user_info
FOR EACH ROW 

INSERT INTO delete_user_backup(id, id_role, id_personal, id_address, login, password_hash, status, registration_date, authorization_date, 
authorization_result, block_start_date, block_end_date, backup_date)

SELECT id, id_role, id_personal, id_address, login, password_hash, status, registration_date, authorization_date, 
authorization_result, block_start_date, block_end_date, current_timestamp()

FROM user_info
WHERE user_info.id = old.id;
