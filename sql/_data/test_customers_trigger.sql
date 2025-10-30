--test 
UPDATE customers 
SET email = 'ali.veli.yeni@example.com' 
WHERE name = 'Ali Veli';

select * from customer_audit_log;