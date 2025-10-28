--bu fonksiyon biz etkinlikteli boş kultukları gösterecek 
CREATE FUNCTION fn_get_available_seats(p_event_id INTEGER)
RETURNS SETOF seats
LANGUAGE plpgsql
AS $$
BEGIN 
    RETURN QUERY
	with empty_seats AS (
     SELECT seats_id from booking as b 
	 join seats on b.seats_id= seats.id 
	 join venues on venues.id=seats.venues_id
	 join events on events.venues_id = venues.id
	 where events.id = p_event_id
	)
	SELECT * from seats 
	left join empty_seats on seats.id = empty_seats.seats_id
	where empty_seats.seats_id  IS NULL ;
	
END;
$$;




CREATE FUNCTION fn_calculate_event_revenue(p_event_id INTEGER )
RETURNS NUMERIC(10, 2)
LANGUAGE plpgsql
AS $$
DECLARE 
 v_total_price NUMERIC(10, 2) DEFAULT 0;

BEGIN

	SELECT COALESCE(SUM(price), 0) INTO v_total_price
	FROM booking 
	where event_id = p_event_id;

	RETURN v_total_price;

END;
$$;


--test
SELECT fn_calculate_event_revenue((SELECT id FROM events WHERE name = 'Tarkan Konseri'));


INSERT INTO events (name, venues_id, start_time, end_time) 
VALUES ('Sıfır Satış Testi', (SELECT id FROM venues WHERE name = 'Zorlu PSM'), '2025-11-01 20:00:00', '2025-11-01 23:00:00');

SELECT fn_calculate_event_revenue((SELECT id FROM events WHERE name = 'Sıfır Satış Testi'));