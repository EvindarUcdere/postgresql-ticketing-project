CREATE FUNCTION fn_log_customer_changes()
RETURNS TRIGGER 
AS $$
BEGIN 

	IF NEW.name IS DISTINCT FROM OLD.name THEN 
	  INSERT INTO customer_audit_log(customer_id ,column_name,old_value,new_value)
	  VALUES (new.id , 'name', OLD.name , NEW.name);
	END IF;

	IF NEW.email IS DISTINCT FROM OLD.email THEN 
	  INSERT INTO customer_audit_log(customer_id ,column_name,old_value,new_value)
	  VALUES (new.id , 'email', OLD.email, NEW.email);
	END IF;  
	RETURN NEW ;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER trg_log_customer_changes
AFTER UPDATE ON  customers 
FOR EACH ROW 
EXECUTE FUNCTION fn_log_customer_changes();

