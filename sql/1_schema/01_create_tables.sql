CREATE TABLE venues(
  id SERIAL PRIMARY KEY ,
  name  varchar(150) not null,
  address varchar(150),
  capacity INTEGER CHECK (capacity>0)
);

CREATE TABLE events (
  id SERIAL PRIMARY KEY ,
  name varchar(150 )NOT NULL,
  venues_id INTEGER REFERENCES venues(id),
  start_time TIMESTAMPTZ,
  end_time TIMESTAMPTZ CHECK (end_time>start_time)
);

CREATE TABLE customers (
   id SERIAL PRIMARY KEY ,
   name varchar(150) NOT NULL,
   email varchar(255) UNIQUE NOT NULL 
   
);

CREATE TABLE seats(
  id SERIAL PRIMARY KEY ,
  seat_row char(1) ,
  seat_number INTEGER ,
  type varchar(50) CHECK ( type in('VIP' , 'Normal')),
  venues_id INTEGER  REFERENCES venues(id),
  UNIQUE(venues_id, seat_row, seat_number)
);

CREATE TABLE booking (
  id BIGSERIAL PRIMARY KEY ,
  booking_time TIMESTAMPTZ DEFAULT  now() ,
  price NUMERIC(10,2),
  event_id INTEGER REFERENCES events(id),
  customer_id INTEGER REFERENCES customers(id),
  seats_id INTEGER REFERENCES seats(id),
  UNIQUE(event_id, seats_id)
  
);