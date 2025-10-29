--yeni bir bilet alınmak istediginde etkinlik tarihini geçip geçmedigin kontrol ediyourz  

CREATE OR REPLACE FUNCTION fn_check_booking_rules()
RETURNS TRIGGER
AS $$
DECLARE 
  v_start_time TIMESTAMPTZ;
BEGIN 
	SELECT start_time INTO v_start_time from events  where id = new.event_id; 
	if  v_start_time <now() THEN 
	   RAISE EXCEPTION 'bu etkinligin tarihi geçmiştir maalesef!!';
    end if ;
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER trg_check_booking_rules
BEFORE INSERT ON  booking 
FOR EACH ROW 
EXECUTE  FUNCTION fn_check_booking_rules();
	
	






