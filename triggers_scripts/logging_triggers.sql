USE mydb; 

-- SET GLOBAL log_bin_trust_function_creators = 1;

DROP TRIGGER IF EXISTS insert_user_trigger; 
DROP TRIGGER IF EXISTS update_user_trigger; 
DROP TRIGGER IF EXISTS delete_user_trigger; 

DELIMITER $$ 
CREATE TRIGGER insert_user_trigger AFTER INSERT 
ON user_info FOR EACH ROW 
BEGIN 
 INSERT INTO insert_log(login, password, date, info) 
 SELECT login, password_hash, CURRENT_TIMESTAMP(), 'new user' 
 FROM user_info
 WHERE id = NEW.id; 
END$$ 

CREATE TRIGGER update_user_trigger BEFORE UPDATE 
ON user_info FOR EACH ROW 
BEGIN 
IF (NEW.status <> OLD.STATUS) AND (NEW.status = 3) THEN 
 IF NEW.block_end_date = '2038-01-19 03:14:07' THEN 
 INSERT INTO update_log(login, password, date, info) 
 SELECT login, password_hash, CURRENT_TIMESTAMP(), 'block user' 
 FROM user_info 
 WHERE id = NEW.id;
 ELSE 
 INSERT INTO update_log(login, password, date, info) 
 SELECT login, password_hash, CURRENT_TIMESTAMP(), 'temporary block user' 
 FROM user_info 
 WHERE id = NEW.id; 
 END IF; 
END IF; 
IF (NEW.status <> OLD.STATUS) AND (NEW.status = 1) AND (OLD.block_end_date <=> NULL) THEN 
 INSERT INTO update_log(login, password, date, info) 
 SELECT login, password_hash, CURRENT_TIMESTAMP(), 'unblock user' 
 FROM user_info 
 WHERE id = NEW.id; 
 END IF; 
IF (NEW.status <> OLD.STATUS) AND (NEW.status = 0) THEN 
 INSERT INTO update_log(login, password, date, info) 
 SELECT login, password_hash, CURRENT_TIMESTAMP(), 'delete user' 
 FROM user_info 
 WHERE id = NEW.id; 
END IF; 
IF OLD.authorization_date <> NEW.authorization_date THEN 
 INSERT INTO update_log(login, password, date, info) 
 SELECT login, password_hash, CURRENT_TIMESTAMP(), 'user authentication' 
 FROM user_info 
 WHERE id = NEW.id; 
END IF; 
IF OLD.id_role <> NEW.id_role THEN 
 INSERT INTO update_log(login, password, date, info) 
 SELECT login, password_hash, CURRENT_TIMESTAMP(), 'change role' 
 FROM user_info 
 WHERE id = NEW.id; 
END IF; 
END$$ 

CREATE TRIGGER delete_user_trigger BEFORE DELETE 
ON user_info FOR EACH ROW 
BEGIN 
 INSERT INTO delete_log(login, password, date, info) 
 SELECT login, password_hash, CURRENT_TIMESTAMP(), 'delete user'
 FROM user_info 
 WHERE id = OLD.id; 
END$$ 
DELIMITER ;
