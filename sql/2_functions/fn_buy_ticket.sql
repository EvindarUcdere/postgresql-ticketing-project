CREATE OR REPLACE FUNCTION fn_buy_ticket(p_customer_id INTEGER , p_event_id INTEGER,p_seats_id INTEGER ,p_price_paid NUMERIC(10,2))
RETURNS BIGINT
AS $$

DECLARE 
  v_new_booking_id BIGINT;
BEGIN 
  INSERT INTO booking(event_id ,customer_id ,seats_id,price)
  VALUES (p_event_id, p_customer_id, p_seats_id, p_price_paid)
  RETURNING id INTO v_new_booking_id;
  RETURN v_new_booking_id; 
EXCEPTION 
	WHEN unique_violation THEN 
	  RAISE EXCEPTION 'HATA: bu koltuk bu etkinlik için zaten satılmıştır!';

	WHEN raise_exception THEN 
	  RAISE EXCEPTION 'HATA: %', SQLERRM;

	WHEN others THEN 
	  RAISE EXCEPTION 'Bilinmeyen bir hata oluştu! %' , SQLERRM;
	  
	  
END;
$$ LANGUAGE plpgsql;