--add data 

--add values 
INSERT INTO venues (name,address , capacity) VALUES
('Zorlu PSM', 'Levazım, Koru Sokağı No:2, 34340 Beşiktaş/İstanbul', 2200),
('Ülker Spor ve Etkinlik Salonu', 'Batı Ataşehir, 34746 Ataşehir/İstanbul', 15000);

-- add customers 
INSERT INTO customers (name, email) VALUES
('Ali Veli', 'ali.veli@example.com'),
('Ayşe Yılmaz', 'ayse.yilmaz@example.com');


--add events 
INSERT INTO events (name, venues_id, start_time, end_time) 
VALUES 
('Tarkan Konseri', (SELECT id FROM venues WHERE name = 'Zorlu PSM'), '2025-12-01 20:00:00', '2025-12-01 23:00:00'),
('Derbi Maçı', (SELECT id FROM venues WHERE name = 'Ülker Spor ve Etkinlik Salonu'), '2025-12-05 21:00:00', '2025-12-05 23:00:00');


--add seats 
INSERT INTO seats (seat_row, seat_number, type, venues_id)
VALUES
-- Zorlu PSM Koltukları (Tarkan Konseri için)
('A', 1, 'VIP', (SELECT id FROM venues WHERE name = 'Zorlu PSM')),
('A', 2, 'VIP', (SELECT id FROM venues WHERE name = 'Zorlu PSM')),
('B', 1, 'Normal', (SELECT id FROM venues WHERE name = 'Zorlu PSM')), -- Bu boş kalacak

-- Ülker Arena Koltukları (Derbi Maçı için)
('A', 1, 'VIP', (SELECT id FROM venues WHERE name = 'Ülker Spor ve Etkinlik Salonu')),
('A', 2, 'VIP', (SELECT id FROM venues WHERE name = 'Ülker Spor ve Etkinlik Salonu'));




--add booking 
INSERT INTO booking (price, event_id, customer_id, seats_id)
VALUES
(
    -- 1. Ali Veli -> Tarkan Konseri -> Zorlu PSM, A-1
    550.75, 
    (SELECT id FROM events WHERE name = 'Tarkan Konseri'),
    (SELECT id FROM customers WHERE email = 'ali.veli@example.com'),
    (SELECT s.id FROM seats s JOIN venues v ON s.venues_id = v.id
     WHERE v.name = 'Zorlu PSM' AND s.seat_row = 'A' AND s.seat_number = 1)
),
(
    -- 2. Ayşe Yılmaz -> Tarkan Konseri -> Zorlu PSM, A-2
    550.75, 
    (SELECT id FROM events WHERE name = 'Tarkan Konseri'),
    (SELECT id FROM customers WHERE email = 'ayse.yilmaz@example.com'),
    (SELECT s.id FROM seats s JOIN venues v ON s.venues_id = v.id
     WHERE v.name = 'Zorlu PSM' AND s.seat_row = 'A' AND s.seat_number = 2)
),
(
    -- 3. Ali Veli -> Derbi Maçı -> Ülker Arena, A-1
    1200.00,
    (SELECT id FROM events WHERE name = 'Derbi Maçı'),
    (SELECT id FROM customers WHERE email = 'ali.veli@example.com'),
    (SELECT s.id FROM seats s JOIN venues v ON s.venues_id = v.id
     WHERE v.name = 'Ülker Spor ve Etkinlik Salonu' AND s.seat_row = 'A' AND s.seat_number = 1)
);





