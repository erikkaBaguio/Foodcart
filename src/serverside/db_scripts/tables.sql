create table Contact
(
  contact_id      SERIAL8 PRIMARY KEY,
  email           VARCHAR(50),
  tel_number      VARCHAR(50),
  mobile_number   VARCHAR(50)
);


create table Address
(
  address_id      SERIAL8 PRIMARY KEY,
  bldg_number     VARCHAR(15),
  street          VARCHAR(50),
  room_number     INT
);


create table Image
(
  image_id        SERIAL8 PRIMARY KEY,
  url             VARCHAR(50)
);


create type Role AS ENUM ('customer', 'system admin', 'manager');
create table Users
(
  user_id            SERIAL8 PRIMARY KEY,
  fname              VARCHAR(50),
  mname              VARCHAR(50),
  lname              VARCHAR(50),
  user_password      VARCHAR(50),
  earned_points      FLOAT,
  contact_id         INT REFERENCES Contact(contact_id),
  address_id         INT REFERENCES Address(address_id),
  rolename           Role,
  is_active          BOOLEAN DEFAULT TRUE
);
