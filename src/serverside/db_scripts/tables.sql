create table Categories
(
  id            SERIAL8 PRIMARY KEY,
  category_name VARCHAR(100) NOT NULL,
  is_active       BOOLEAN DEFAULT TRUE
);


create table Images
(
  id        SERIAL8 PRIMARY KEY,
  url             VARCHAR(50)
);


create table Contacts
(
  id              SERIAL8 PRIMARY KEY,
  email           VARCHAR(50),
  tel_number      VARCHAR(50),
  mobile_number   VARCHAR(50)
);


create table Address
(
  id              SERIAL8 PRIMARY KEY,
  bldg_number     VARCHAR(15),
  street          VARCHAR(50),
  room_number     INT
);


create type Role AS ENUM ('customer', 'system admin', 'manager');
create table Users
(
  id                 SERIAL8 PRIMARY KEY,
  fname              VARCHAR(50),
  mname              VARCHAR(50),
  lname              VARCHAR(50),
  user_password      VARCHAR(50),
  earned_points      FLOAT,
  contact_id         INT REFERENCES Contacts(id),
  address_id         INT REFERENCES Address(id),
  rolename           Role,
  is_active          BOOLEAN DEFAULT TRUE
);


create table Restaurants
(
  id            SERIAL8 PRIMARY KEY,
  resto_name    VARCHAR(100) NOT NULL,
  min_order   FLOAT,
  image_id    INT REFERENCES Images(id)
);


create table Restaurant_branch
(
  id        SERIAL8 PRIMARY KEY,
  delivery_fee     FLOAT,
  contact_id    INT REFERENCES Contacts(id),
  resto_id    INT REFERENCES Restaurants(id),
  address_id    INT REFERENCES Address(id),
  is_active   BOOLEAN DEFAULT TRUE
);


create table Foods
(
  id        SERIAL8 PRIMARY KEY,
  food_name   VARCHAR(200) NOT NULL,
  description   TEXT NOT NULL,
  unit_cost   FLOAT,
  resto_branch_id INT REFERENCES Restaurant_branch(id),
  image_id    INT REFERENCES Images(id),
  is_available BOOLEAN DEFAULT TRUE,
  is_active   BOOLEAN DEFAULT TRUE
);


create table Category_Foods
(
  id        SERIAL8 PRIMARY KEY,
  foods_id    INT REFERENCES Foods(id),
  category_id   INT REFERENCES Categories(id)
);


create table Order_foods
(
  id                    SERIAL8 PRIMARY KEY,
  quantity              INT,
  food_id               INT REFERENCES Foods(id),
  resto_branch_id       INT REFERENCES Restaurant_branch(id)
);


create table Orders
(
  id          SERIAL8 PRIMARY KEY,
  user_id       INT REFERENCES Users(id),
  order_food_id   INT REFERENCES Order_foods(id)
);


create table Transaction
(
  id                    SERIAL8 PRIMARY KEY,
  transaction_number    INT,
  transaction_date      DATE,
  order_id              INT REFERENCES Orders(id),
  total                 FLOAT,
  is_paid               BOOLEAN DEFAULT FALSE,
  address_id            INT REFERENCES Address(id)
);