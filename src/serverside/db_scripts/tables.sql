create table Roles
(
	id 				SERIAL8 PRIMARY KEY,
	role_name		VARCHAR(30) NOT NULL
);


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
	location		VARCHAR(200) NOT NULL,
  	is_active       BOOLEAN DEFAULT TRUE
);


create table Order_food
(
	id 					SERIAL8 PRIMARY KEY,
	food_id				INT REFERENCES Food(id),
	quantity			INT
);


create table Orders
(
	id 					SERIAL8 PRIMARY KEY,
	role_id				INT REFERENCES Roles(id),
	payment_id			INT,
	order_foods_id		INT REFERENCES Order_food(id),
	subtotal			FLOAT
);


create table Userinfo
(
	id				      SERIAL8 PRIMARY KEY,
	fname			      VARCHAR(100),
	mname			      VARCHAR(100),
	lname			      VARCHAR(100),
	address			    VARCHAR(100) NOT NULL,
	email			      VARCHAR(100),
	mobile_number	  VARCHAR(100),
	user_password		VARCHAR(100),
	role_id			    INT REFERENCES Roles(id),
	earned_points	  VARCHAR(100),
	is_active       BOOLEAN DEFAULT TRUE
);


create table Transaction
(
	id 						SERIAL8 PRIMARY KEY,
	transaction_number		VARCHAR(20),
	transaction_date		DATE,
	payer_id				INT REFERENCES Userinfo(id),
	payment_id				INT,
	paypal_token			VARCHAR(255) NULL,
	name 					VARCHAR(50),
	contact_number			INT,
	email_address			VARCHAR(50),
	delivery_fee			FLOAT,
	order_id 				INT REFERENCES Orders(id),
	total					FLOAT,
	confirmed				BOOLEAN DEFAULT FALSE,
	is_active				BOOLEAN DEFAULT FALSE
);