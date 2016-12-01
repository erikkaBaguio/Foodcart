CREATE TABLE Food
(	id				SERIAL8 PRIMARY KEY,
	food_name		TEXT NOT NULL,
	description		TEXT NOT NULL,
	unit_cost		FLOAT,
	is_active		BOOLEAN DEFAULT TRUE
);