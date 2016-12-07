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