DROP TABLE IF EXISTS users CASCADE;
DROP TABLE IF EXISTS customers CASCADE;
DROP TABLE IF EXISTS restaurants CASCADE;
DROP TABLE IF EXISTS foods CASCADE;
DROP TABLE IF EXISTS orders CASCADE;
DROP TABLE IF EXISTS line_items CASCADE;

CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  email VARCHAR(255) NOT NULL,
  password VARCHAR(255) NOT NULL,
  is_customer BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE customers (
  id SERIAL PRIMARY KEY,
  user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
  name VARCHAR(255) NOT NULL,
  phone VARCHAR(20) NOT NULL,
  points INTEGER DEFAULT 0
);

CREATE TABLE restaurants (
  id SERIAL PRIMARY KEY,
  owner_id INTEGER REFERENCES users(id) ON DELETE CASCADE,

  name VARCHAR(255) NOT NULL,
  image_url TEXT,
  country VARCHAR(50) NOT NULL,
  street VARCHAR(255) NOT NULL,
  city VARCHAR(50) NOT NULL,
  province VARCHAR(50) NOT NULL,
  post_code VARCHAR(50) NOT NULL,
  phone VARCHAR(50) NOT NULL,
  hours VARCHAR(255),
  category VARCHAR(255)
);

CREATE TABLE foods (
  id SERIAL PRIMARY KEY,
  restaurant_id INTEGER REFERENCES restaurants(id) ON DELETE CASCADE,

  name VARCHAR(255) NOT NULL,
  description text,
  price INTEGER NOT NULL,
  estimated_time INTEGER NOT NULL,
  category VARCHAR(255) NOT NULL,
  vegetarian BOOLEAN DEFAULT FALSE,
  allergy BOOLEAN DEFAULT FALSE,
  days_on_sale VARCHAR(50),
  is_popular BOOLEAN DEFAULT FALSE
);

CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  restaurant_id INTEGER REFERENCES restaurants(id) ON DELETE CASCADE,
  customer_id INTEGER REFERENCES customers(id) ON DELETE CASCADE,
  created_at TIMESTAMP NOT NULL,
  accepted_at TIMESTAMP,
  completed_at TIMESTAMP,
  pickedup_at TIMESTAMP,
  total_price INTEGER NOT NULL,
  points_earned INTEGER NOT NULL,
  estimated_time INTEGER
);

CREATE TABLE line_items (
  id SERIAL PRIMARY KEY,
  order_id INTEGER REFERENCES orders(id) ON DELETE CASCADE,
  food_id INTEGER REFERENCES foods(id) ON DELETE CASCADE,

  quantity SMALLINT NOT NULL
);
