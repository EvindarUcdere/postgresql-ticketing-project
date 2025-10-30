--test
SELECT fn_buy_ticket(
    p_customer_id := (SELECT id FROM customers WHERE name = 'Ayşe Yılmaz'), 
    p_event_id := (SELECT id FROM events WHERE name = 'Tarkan Konseri'),
    
    
    p_seats_id := (SELECT s.id FROM seats s JOIN venues v ON s.venues_id = v.id WHERE v.name = 'Zorlu PSM' AND s.seat_row = 'B' AND s.seat_number = 1),
    
    p_price_paid := 250.00::NUMERIC(10, 2)
);

INSERT INTO seats (seat_row, seat_number, type, venues_id) 
VALUES 
('C', 1, 'Normal', (SELECT id FROM venues WHERE name = 'Zorlu PSM'));

SELECT fn_buy_ticket(
    p_customer_id := (SELECT id FROM customers WHERE name = 'Ayşe Yılmaz'), 
    p_event_id := (SELECT id FROM events WHERE name = 'Tarkan Konseri'),
    
    
    p_seats_id := (SELECT s.id FROM seats s JOIN venues v ON s.venues_id = v.id WHERE v.name = 'Zorlu PSM' AND s.seat_row = 'C' AND s.seat_number = 1),
    
    p_price_paid := 250.00::NUMERIC(10, 2)
);