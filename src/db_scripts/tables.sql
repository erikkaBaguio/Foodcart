create table Food
(	id				SERIAL8 PRIMARY KEY,
	food_name		VARCHAR(200) NOT NULL,
	description		TEXT NOT NULL,
	unit_cost		FLOAT,
	is_active		BOOLEAN DEFAULT TRUE
);


create table Category
(
	id           	SERIAL8 PRIMARY KEY,
	category_name	VARCHAR(100) NOT NULL,
	is_active       BOOLEAN DEFAULT TRUE
);

create table Restaurant
(
	id           	SERIAL8 PRIMARY KEY,
	resto_name 		VARCHAR(100) NOT NULL,
	min_order		FLOAT,
	delivery_fee	FLOAT,
  	is_active       BOOLEAN DEFAULT TRUE
);


create table Orders
(
	id 					SERIAL8 PRIMARY KEY,
	role_id				INT REFERENCES Roles(id),
	payment_id			INT,
	order_foods_id		INT REFERENCES Order_foods(id),
	subtotal			FLOAT
);