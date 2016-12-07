create table Contact
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


create table Image
(
  id        SERIAL8 PRIMARY KEY,
  url             VARCHAR(50)
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
  contact_id         INT REFERENCES Contact(id),
  address_id         INT REFERENCES Address(id),
  rolename           Role,
  is_active          BOOLEAN DEFAULT TRUE
);


create table Order_foods
(
  id                    SERIAL8 PRIMARY KEY,
  quantity              INT,
  food_id               INT REFERENCES Food(id),
  resto_branch_id       INT REFERENCES Restaurant_branch(id)
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