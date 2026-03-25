CREATE SCHEMA orders_db_ka AUTHORIZATION adamskri;
SET search_path TO orders_db_ka;
SHOW search_path;


DROP TABLE IF EXISTS order_contents CASCADE;
DROP TABLE IF EXISTS orders CASCADE;
DROP TABLE IF EXISTS bag_contents CASCADE;
DROP TABLE IF EXISTS item_stock CASCADE;
DROP TABLE IF EXISTS items CASCADE;
DROP TABLE IF EXISTS item_types CASCADE;
DROP TABLE IF EXISTS users CASCADE;


CREATE TABLE users
(
	id integer GENERATED ALWAYS  AS IDENTITY PRIMARY KEY,
	email varchar(64) UNIQUE NOT NULL,
	salted_hash varchar(128) UNIQUE NOT NULL,
	created_at timestamp with time zone DEFAULT (current_timestamp) NOT NULL,
	updated_at timestamp with time zone DEFAULT (current_timestamp) NOT NULL
);

CREATE TABLE item_types
(
	id integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	item_type_name varchar(64) UNIQUE NOT NULL,
	created_at timestamp with time zone DEFAULT (current_timestamp) NOT NULL,
	updated_at timestamp with time zone DEFAULT (current_timestamp) NOT NULL,
	deleted boolean DEFAULT (FALSE) NOT NULL
);


CREATE TABLE items
(
	id integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	item_name varchar(64) UNIQUE NOT NULL,
	item_type_id integer REFERENCES item_types(id) NOT NULL,
	price integer NOT NULL,
	dependent boolean NOT NULL,
	created_at timestamp with time zone DEFAULT (current_timestamp) NOT NULL,
	updated_at timestamp with time zone DEFAULT (current_timestamp) NOT NULL,
	deleted boolean DEFAULT (FALSE) NOT NULL
	CHECK (price > 0)
);

CREATE TABLE item_stock
(
	id integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	item_id integer REFERENCES items(id) NOT NULL UNIQUE,
	number_in_stock integer NOT NULL,
	created_at timestamp with time zone DEFAULT (current_timestamp) NOT NULL,
	updated_at timestamp with time zone DEFAULT (current_timestamp) NOT NULL,
	deleted boolean DEFAULT (FALSE) NOT NULL
	CHECK (number_in_stock >= 0)
);


CREATE TABLE bag_contents
(
	id integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	user_id integer REFERENCES users(id) NOT NULL,
	item_id integer REFERENCES items(id) NOT NULL,
	quantity integer NOT NULL,
	created_at timestamp with time zone DEFAULT (current_timestamp) NOT NULL,
	updated_at timestamp with time zone DEFAULT (current_timestamp) NOT NULL,
	CHECK (quantity > 0)
	-- Check that dependent items are only added with the appropriate independent items
);

CREATE TABLE orders
(
	id integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	user_id integer REFERENCES users(id),
	cost integer NOT NULL,
	created_at timestamp with time zone DEFAULT (current_timestamp) NOT NULL,
	deleted boolean DEFAULT (FALSE) NOT NULL,
	CHECK (cost > 0)
);

CREATE TABLE order_contents
(
	id integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	order_id integer REFERENCES orders(id) NOT NULL,
	item_id integer REFERENCES items(id) NOT NULL,
	cost integer NOT NULL,
	quantity integer NOT NULL,
	created_at timestamp with time zone DEFAULT (current_timestamp) NOT NULL,
	deleted boolean DEFAULT (FALSE) NOT NULL,
	CHECK (quantity > 0),
	CHECK (cost > 0)
);

-----------------------------------------------------------------------
INSERT INTO users(email, salted_hash) VALUES ('selentd@uwplatt.edu', '$2y$12$VdjUpfHxiqsfzGIDCSfU2Oy6qj2MTrRuS65Pn2GosMnX9obCe6vt');
INSERT INTO users(email, salted_hash) VALUES ('shiy@uwplatt.edu', '$2b$10$btSCJGa0WTnDlRQFS5y0VuNFYQQ8JkIpfOt0HKXIgZY.rm/mGtrCq');
INSERT INTO users(email, salted_hash) VALUES ('yues@uwplatt.edu', '$2b$10$6AkX/wNWtIp4G8OpQg2QfuYID50rOl6y05fAFN8RUVHsZhju4Xv1a');
INSERT INTO users(email, salted_hash) VALUES ('montgomeryh@uwplatt.edu', '$2a$10$mOu21NbeuBWIqlxF1Keen.Gzgd1x3o.WpHWxsuMv6qe3m7Gw.BiS6');
INSERT INTO users(email, salted_hash) VALUES ('mohandesim@uwplatt.edu', '$2a$10$BDAxWwu4qaIuzPD3d2wh.ucWwuglOQMsIMSo54KXf/ByJB5aqUs6q');
INSERT INTO users(email, salted_hash) VALUES ('lindahlg@uwplatt.edu', '$2a$10$qMgMAVH2m8YIq0tz1lN1te/58tGwGUaNPkUSqxXhAyf7CsS93mSBq');
INSERT INTO users(email, salted_hash) VALUES ('landgraf@uwplatt.edu', '$2a$10$N4q/IYBB4Vw7iufQvPvdtuVFqYw7dbt3wy1VwBvEn7MUXCMPtbBq6');
INSERT INTO users(email, salted_hash) VALUES ('gavind@uwplatt.edu', '$2a$10$XDppFo6/0XFe9vMtsWDh0ub2toGgT/sB1rREXledybmh5EwLtulLG');
INSERT INTO users(email, salted_hash) VALUES ('dasa@uwplatt.edu', '$2a$10$WVLkL55vvUxvl6128a5yYOIE94y9IxXSRvz.UrqpjNVaAu6nx20vi');
INSERT INTO users(email, salted_hash) VALUES ('bormanf@uwplatt.edu', '$2a$10$mNQMdhnBjBEe/VOS41Ax5OeBdcI7AprRCgKqYjDRxtwxxM.7WLyee');
INSERT INTO users(email, salted_hash) VALUES ('ashoka@uwplatt.edu', '$2a$10$nkn9Fa7oAUcUi4Oj.DjLcekEiaywqqIR5XvVjqAZ8mmhW07GPDWg.');
INSERT INTO users(email, salted_hash) VALUES ('ashrafuzzamm@uwplatt.edu', '$2a$10$nkn9Fa7oAUcUi4Oj.DjLchjEiaywqqIR5XvVjqAZ8mmhW07GPDWg.');

INSERT INTO item_types(item_type_name) VALUES('Shirts');
INSERT INTO item_types(item_type_name) VALUES('Trousars');
INSERT INTO item_types(item_type_name) VALUES('Shoes');
INSERT INTO item_types(item_type_name) VALUES('Perfumes');
INSERT INTO item_types(item_type_name) VALUES('Bells');
INSERT INTO item_types(item_type_name) VALUES('Whistles');

INSERT INTO items(item_name, item_type_id, price, dependent) VALUES('Dress Shirt', 1, 2550, FALSE);
INSERT INTO items(item_name, item_type_id, price, dependent) VALUES('Hawaiian Shirt', 1, 2600, FALSE);
INSERT INTO items(item_name, item_type_id, price, dependent) VALUES('UWP Orange-Blue Shirt', 1, 2900, FALSE);
INSERT INTO items(item_name, item_type_id, price, dependent) VALUES('Crewneck Shirt', 1, 2550, FALSE);
INSERT INTO items(item_name, item_type_id, price, dependent) VALUES('CSSE Blue Casual', 1, 2900, FALSE);
INSERT INTO items(item_name, item_type_id, price, dependent) VALUES('Blue Jeans', 2, 1550, FALSE);
INSERT INTO items(item_name, item_type_id, price, dependent) VALUES('Rainbow Pajamas', 2, 1050, FALSE);
INSERT INTO items(item_name, item_type_id, price, dependent) VALUES('Navy-Blue Dockers', 2, 1500, FALSE);
INSERT INTO items(item_name, item_type_id, price, dependent) VALUES('Bunny Flats', 3, 750, FALSE);
INSERT INTO items(item_name, item_type_id, price, dependent) VALUES('Pikachu Slippers', 3, 800, FALSE);
INSERT INTO items(item_name, item_type_id, price, dependent) VALUES('Spot High-Tops', 3, 750, FALSE);
INSERT INTO items(item_name, item_type_id, price, dependent) VALUES('Samsara', 4, 400, TRUE);
INSERT INTO items(item_name, item_type_id, price, dependent) VALUES('Poison Ivy', 4, 350, TRUE);
INSERT INTO items(item_name, item_type_id, price, dependent) VALUES('Sixth Scent', 4, 350, TRUE);
INSERT INTO items(item_name, item_type_id, price, dependent) VALUES('New world Chimes', 5, 700, TRUE);
INSERT INTO items(item_name, item_type_id, price, dependent) VALUES('Magically Sounding', 5, 500, TRUE);
INSERT INTO items(item_name, item_type_id, price, dependent) VALUES('Clock Cuckoo', 5, 500, TRUE);
INSERT INTO items(item_name, item_type_id, price, dependent) VALUES('Whistling Train', 6, 100, TRUE);
INSERT INTO items(item_name, item_type_id, price, dependent) VALUES('Referee Whistle', 6, 50, TRUE);
INSERT INTO items(item_name, item_type_id, price, dependent) VALUES('Mardi Gras Whistle', 6, 120, TRUE);

INSERT INTO item_stock(item_id, number_in_stock) VALUES(1, 1000);
INSERT INTO item_stock(item_id, number_in_stock) VALUES(2, 500);
INSERT INTO item_stock(item_id, number_in_stock) VALUES(3, 2000);
INSERT INTO item_stock(item_id, number_in_stock) VALUES(4, 99);
INSERT INTO item_stock(item_id, number_in_stock) VALUES(5, 0);
INSERT INTO item_stock(item_id, number_in_stock) VALUES(6, 400);
INSERT INTO item_stock(item_id, number_in_stock) VALUES(7, 22);
INSERT INTO item_stock(item_id, number_in_stock) VALUES(8, 982);
INSERT INTO item_stock(item_id, number_in_stock) VALUES(9, 3000);
INSERT INTO item_stock(item_id, number_in_stock) VALUES(10, 2139);
INSERT INTO item_stock(item_id, number_in_stock) VALUES(11, 850);
INSERT INTO item_stock(item_id, number_in_stock) VALUES(12, 100);
INSERT INTO item_stock(item_id, number_in_stock) VALUES(13, 100);
INSERT INTO item_stock(item_id, number_in_stock) VALUES(14, 0);
INSERT INTO item_stock(item_id, number_in_stock) VALUES(15, 0);
INSERT INTO item_stock(item_id, number_in_stock) VALUES(16, 213);
INSERT INTO item_stock(item_id, number_in_stock) VALUES(17, 850);
INSERT INTO item_stock(item_id, number_in_stock) VALUES(18, 100);
INSERT INTO item_stock(item_id, number_in_stock) VALUES(19, 100);
INSERT INTO item_stock(item_id, number_in_stock) VALUES(20, 0);


INSERT INTO bag_contents(user_id, item_id, quantity) VALUES(1, 2, 1);
INSERT INTO bag_contents(user_id, item_id, quantity) VALUES(1, 11, 2);
INSERT INTO bag_contents(user_id, item_id, quantity) VALUES(1, 13, 1);
INSERT INTO bag_contents(user_id, item_id, quantity) VALUES(2, 5, 1);
INSERT INTO bag_contents(user_id, item_id, quantity) VALUES(4, 12, 1);
INSERT INTO bag_contents(user_id, item_id, quantity) VALUES(4, 13, 1);
INSERT INTO bag_contents(user_id, item_id, quantity) VALUES(4, 14, 1);
INSERT INTO bag_contents(user_id, item_id, quantity) VALUES(5, 5, 1);

INSERT INTO orders(user_id, cost) VALUES(1, 4500);
INSERT INTO orders(user_id, cost) VALUES(1, 13500);
INSERT INTO orders(user_id, cost) VALUES(5, 10000);
INSERT INTO orders(user_id, cost) VALUES(7, 1600);
INSERT INTO orders(user_id, cost) VALUES(8, 500);
INSERT INTO orders(user_id, cost) VALUES(NULL, 3150);
INSERT INTO orders(user_id, cost) VALUES(NULL, 2550);
INSERT INTO orders(user_id, cost) VALUES(9, 5800);
INSERT INTO orders(user_id, cost) VALUES(11, 9500);
INSERT INTO orders(user_id, cost) VALUES(2, 1000);
INSERT INTO orders(user_id, cost) VALUES(NULL, 50);
INSERT INTO orders(user_id, cost) VALUES(NULL, 550);
INSERT INTO orders(user_id, cost) VALUES(12, 1212);


INSERT INTO order_contents(order_id, item_id, cost, quantity) VALUES(1, 1, 2550, 1);
INSERT INTO order_contents(order_id, item_id, cost, quantity) VALUES(1, 10, 1600, 1);
INSERT INTO order_contents(order_id, item_id, cost, quantity) VALUES(1, 13, 350, 1);
INSERT INTO order_contents(order_id, item_id, cost, quantity) VALUES(2, 1, 2550, 1);
INSERT INTO order_contents(order_id, item_id, cost, quantity) VALUES(2, 2, 2600, 1);
INSERT INTO order_contents(order_id, item_id, cost, quantity) VALUES(2, 3, 2900, 1);
INSERT INTO order_contents(order_id, item_id, cost, quantity) VALUES(2, 4, 2550, 1);
INSERT INTO order_contents(order_id, item_id, cost, quantity) VALUES(2, 5, 2900, 1);
INSERT INTO order_contents(order_id, item_id, cost, quantity) VALUES(3, 11, 4000, 10);
INSERT INTO order_contents(order_id, item_id, cost, quantity) VALUES(3, 12, 3500, 10);
INSERT INTO order_contents(order_id, item_id, cost, quantity) VALUES(3, 13, 3500, 10);
INSERT INTO order_contents(order_id, item_id, cost, quantity) VALUES(4, 9, 1600, 2);
INSERT INTO order_contents(order_id, item_id, cost, quantity) VALUES(5, 17, 500, 1);
INSERT INTO order_contents(order_id, item_id, cost, quantity) VALUES(6, 6, 1550, 1);
INSERT INTO order_contents(order_id, item_id, cost, quantity) VALUES(6, 8, 1500, 1);
INSERT INTO order_contents(order_id, item_id, cost, quantity) VALUES(7, 4, 2550, 1);
INSERT INTO order_contents(order_id, item_id, cost, quantity) VALUES(8, 3, 5800, 2);
INSERT INTO order_contents(order_id, item_id, cost, quantity) VALUES(9, 2, 5200, 2);
INSERT INTO order_contents(order_id, item_id, cost, quantity) VALUES(9, 7, 1050, 1);
INSERT INTO order_contents(order_id, item_id, cost, quantity) VALUES(9, 6, 1550, 1);
INSERT INTO order_contents(order_id, item_id, cost, quantity) VALUES(9, 13, 350, 1);
INSERT INTO order_contents(order_id, item_id, cost, quantity) VALUES(9, 14, 350, 1);
INSERT INTO order_contents(order_id, item_id, cost, quantity) VALUES(9, 16, 500, 1);
INSERT INTO order_contents(order_id, item_id, cost, quantity) VALUES(9, 17, 500, 1);
INSERT INTO order_contents(order_id, item_id, cost, quantity) VALUES(10, 1, 2550, 1);





