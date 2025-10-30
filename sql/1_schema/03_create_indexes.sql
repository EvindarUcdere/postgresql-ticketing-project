EXPLAIN ANALYZE
SELECT s.* FROM seats s
WHERE s.venues_id = (SELECT venues_id FROM events WHERE id = 1) -- 'Tarkan Konseri' mekanı
AND NOT EXISTS (
    SELECT 1 
    FROM booking b
    WHERE b.event_id = 1 -- 'Tarkan Konseri'
    AND b.seats_id = s.id
);

-- En çok arama yapacağımız yerler:

-- r etkinliğe ait biletleri HIZLI bulmak için
CREATE INDEX idx_booking_event_id ON booking (event_id);

--  Bir koltuğun satılıp satılmadığını HIZLI bulmak için
CREATE INDEX idx_booking_seats_id ON booking (seats_id);

--müşterinin biletlerini HIZLI bulmak için
CREATE INDEX idx_booking_customer_id ON booking (customer_id);

--Bir mekana ait koltukları HIZLI bulmak için
CREATE INDEX idx_seats_venues_id ON seats (venues_id);

-- 5. Bir mekana ait etkinlikleri HIZLI bulmak için
CREATE INDEX idx_events_venues_id ON events (venues_id);


EXPLAIN ANALYZE
SELECT s.* FROM seats s
WHERE s.venues_id = (SELECT venues_id FROM events WHERE id = 1) -- 'Tarkan Konseri' mekanı
AND NOT EXISTS (
    SELECT 1 
    FROM booking b
    WHERE b.event_id = 1 -- 'Tarkan Konseri'
    AND b.seats_id = s.id
);