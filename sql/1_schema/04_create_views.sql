CREATE VIEW v_event_summary AS

WITH
    
    booking_summary AS (
        SELECT
            event_id,
            COUNT(*) AS tickets_sold,
            SUM(price) AS total_revenue
        FROM
            booking
        GROUP BY
            event_id
    ),
    
  
    venue_capacity AS (
        SELECT
            venues_id,
            COUNT(*) AS total_seats_in_venue
        FROM
            seats
        GROUP BY
            venues_id
    )


SELECT
    e.id AS event_id,
    e.name AS event_name,
    v.name AS venue_name,
    e.start_time,
    
  
    COALESCE(bs.tickets_sold, 0) AS tickets_sold,
    COALESCE(bs.total_revenue, 0.00) AS total_revenue,
    
   
    COALESCE(vc.total_seats_in_venue, 0) AS total_seats_in_venue,
    
    
    (COALESCE(vc.total_seats_in_venue, 0) - COALESCE(bs.tickets_sold, 0)) AS available_seats
    
FROM
    
    events AS e

JOIN
    venues AS v ON e.venues_id = v.id

LEFT JOIN
    venue_capacity AS vc ON e.venues_id = vc.venues_id

LEFT JOIN
    booking_summary AS bs ON e.id = bs.event_id;