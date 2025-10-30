--I  created a log table 
CREATE TABLE customer_audit_log(
  id BIGSERIAL PRIMARY  KEY ,
  customer_id INTEGER REFERENCES customers(id) ON DELETE SET NULL  ,
  column_name varchar(150),
  old_value TEXT ,
  new_value TEXT ,
  changed_bu_user NAME DEFAULT current_user,
  changed_at  TIMESTAMPTZ DEFAULT now()
);




