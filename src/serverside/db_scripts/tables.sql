create table Foods
(	
	id				SERIAL8 PRIMARY KEY,
	food_name		VARCHAR(200) NOT NULL,
	description		TEXT NOT NULL,
	unit_cost		FLOAT,
	resto_branch_id	INT REFERENCES Restaurant_branch(id),
	image_id		INT REFERENCES Images(id),
	is_active		BOOLEAN DEFAULT TRUE
);


create table Categories
(
	id           	SERIAL8 PRIMARY KEY,
	category_name	VARCHAR(100) NOT NULL,
	is_active       BOOLEAN DEFAULT TRUE
);

create table Restaurants
(
	id           	SERIAL8 PRIMARY KEY,
	resto_name 		VARCHAR(100) NOT NULL,
	min_order		FLOAT,
	image_id		INT REFERENCES Images(id),
);


create table Orders
(
	id 					SERIAL8 PRIMARY KEY,
	user_id				INT REFERENCES Users(id),
	order_food_id		INT REFERENCES Order_foods(id),
);


create table Restaurant_branch
(
	id				SERIAL8 PRIMARY KEY,
	del_fee			FLOAT,
	contact_id		INT REFERENCES Contacts(id),
	resto_id		INT REFERENCES Restaurants(id),
	address_id		INT REFERENCES Address(id),
	is_active		BOOLEAN DEFAULT TRUE
);