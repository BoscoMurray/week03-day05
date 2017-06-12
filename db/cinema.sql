DROP TABLE IF EXISTS tickets;
DROP TABLE IF EXISTS screenings;
DROP TABLE IF EXISTS films;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255),
  monero INT4
  );

CREATE TABLE films (
  id SERIAL4 PRIMARY KEY,
  title VARCHAR(255),
  price INT4
  );

CREATE TABLE screenings (
  id SERIAL4 PRIMARY KEY,
  film_id INT4 REFERENCES films(id),
  price INT4,
  time VARCHAR(255),
  seats INT4
  );

CREATE TABLE tickets (
  id SERIAL4 PRIMARY KEY,
  screening_id INT4 REFERENCES screenings(id),
  customer_id INT4 REFERENCES customers(id),
  price INT4
  );
