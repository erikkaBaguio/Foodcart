create table Categories
(
  id            SERIAL8 PRIMARY KEY,
  category_name VARCHAR(100) NOT NULL,
  is_active     BOOLEAN DEFAULT TRUE
);


create table Food_images
(
  id   SERIAL8 PRIMARY KEY,
  url  VARCHAR(50)
);


create table Resto_images
(
  id   SERIAL8 PRIMARY KEY,
  url  VARCHAR(50)
);


create table Resto_branch_contacts
(
  id              SERIAL8 PRIMARY KEY,
  email           VARCHAR(50),
  tel_number      VARCHAR(50),
  mobile_number   VARCHAR(50)
);


create table Resto_branch_address
(
  id              SERIAL8 PRIMARY KEY,
  bldg_number     VARCHAR(15),
  street          VARCHAR(50),
  room_number     VARCHAR(15)
);


create table Transaction_address
(
  id              SERIAL8 PRIMARY KEY,
  bldg_number     VARCHAR(15),
  street          VARCHAR(50),
  room_number     VARCHAR(15)
);


create table User_contacts
(
  id              SERIAL8 PRIMARY KEY,
  email           VARCHAR(50),
  tel_number      VARCHAR(50),
  mobile_number   VARCHAR(50)
);


create table User_address
(
  id              SERIAL8 PRIMARY KEY,
  bldg_number     VARCHAR(15),
  street          VARCHAR(50),
  room_number     VARCHAR(15)
);


create table Roles
(
  id              SERIAL8 PRIMARY KEY,
  rolename        VARCHAR(50)
);


create table Users
(
  id              SERIAL8 PRIMARY KEY,
  fname           VARCHAR(50),
  mname           VARCHAR(50),
  lname           VARCHAR(50),
  user_password   VARCHAR(50),
  earned_points   FLOAT DEFAULT 0,
  contact_id      INT REFERENCES User_contacts(id),
  address_id      INT REFERENCES User_address(id),
  role_id         INT REFERENCES Roles(id),
  is_active       BOOLEAN DEFAULT TRUE
);


create table Restaurants
(
  id              SERIAL8 PRIMARY KEY,
  resto_name      VARCHAR(100) NOT NULL,
  min_order       FLOAT,
  image_id        INT REFERENCES Resto_images(id)
);


create table Restaurant_branch
(
  id             SERIAL8 PRIMARY KEY,
  delivery_fee   FLOAT,
  contact_id     INT REFERENCES Resto_branch_contacts(id),
  resto_id       INT REFERENCES Restaurants(id),
  address_id     INT REFERENCES Resto_branch_address(id),
  is_active      BOOLEAN DEFAULT TRUE
);


create table Foods
(
  id              SERIAL8 PRIMARY KEY,
  food_name       VARCHAR(200) NOT NULL,
  description     TEXT NOT NULL,
  unit_cost       FLOAT,
  resto_branch_id INT REFERENCES Restaurant_branch(id),
  image_id        INT REFERENCES Food_images(id),
  is_available    BOOLEAN DEFAULT TRUE,
  is_active       BOOLEAN DEFAULT TRUE
);


create table Category_Foods
(
  id              SERIAL8 PRIMARY KEY,
  foods_id        INT REFERENCES Foods(id),
  category_id     INT REFERENCES Categories(id)
);


create table Order_foods
(
  id               SERIAL8 PRIMARY KEY,
  quantity         INT,
  food_id          INT REFERENCES Foods(id),
  resto_branch_id  INT REFERENCES Restaurant_branch(id)
);


create table Orders
(
  id               SERIAL8 PRIMARY KEY,
  user_id          INT REFERENCES Users(id),
  order_food_id    INT REFERENCES Order_foods(id),
  is_done          BOOLEAN DEFAULT FALSE
);


create table Transactions
(
  id                  SERIAL8 PRIMARY KEY,
  transaction_number  INT,
  transaction_date    TIMESTAMP DEFAULT now(),
  order_id            INT REFERENCES Orders(id),
  total               FLOAT,
  is_paid             BOOLEAN DEFAULT FALSE,
  address_id          INT REFERENCES Transaction_address(id)
);