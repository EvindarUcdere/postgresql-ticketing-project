--trigger testi  
INSERT INTO events (name, venues_id, start_time, end_time) 
VALUES 
('Geçmiş Konser', (SELECT id FROM venues WHERE name = 'Zorlu PSM'), '2024-01-01 20:00:00', '2024-01-01 23:00:00');


INSERT INTO booking (price, event_id, customer_id, seats_id)
VALUES (100.00, (SELECT id FROM events WHERE name = 'Geçmiş Konser'), 1, 1);




INSERT INTO booking (price, event_id, customer_id, seats_id)
VALUES
(
    150.00, 
    (SELECT id FROM events WHERE name = 'Tarkan Konseri'),
    (SELECT id FROM customers WHERE email = 'ali.veli@example.com'),
    (SELECT s.id FROM seats s JOIN venues v ON s.venues_id = v.id
     WHERE v.name = 'Zorlu PSM' AND s.seat_row = 'B' AND s.seat_number = 1)
);
