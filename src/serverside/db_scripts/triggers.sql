--this trigger will create a contact and addresses where id == to the newly created restaurant branch.
--but this will not store any other attribute of Resto_branch_contacts and Resto_branch_address. only the id.
create or replace function create_restaurant_branch() returns trigger as
	$$
		begin
			if tg_op = 'INSERT' then
				insert into Resto_branch_contacts(id)
					values (new.id);
				insert into Resto_branch_address(id)
					values (new.id);
			end if;
			return new;
		end;
	$$
		LANGUAGE 'plpgsql';

create trigger create_restaurant_branch_ins AFTER insert on Restaurant_branch FOR each ROW
EXECUTE PROCEDURE create_restaurant_branch();


--this trigger will create an Resto_image where id == to the newly created restaurant.
--but this will not store any other attribute of Resto_image, only the id.
create or replace function create_restaurant() returns trigger as
	$$
		begin
			if tg_op = 'INSERT' then
				insert into Resto_images(id)
					values (new.id);
			end if;
			return new;
		end;
	$$
		LANGUAGE 'plpgsql';

create trigger create_restaurant_ins AFTER insert on Restaurants FOR each ROW
EXECUTE PROCEDURE create_restaurant();


--this trigger will create an Food_image where id == to the newly created food.
--but this will not store any other attribute of Food_image, only the id.
create or replace function create_food() returns trigger as
	$$
		begin
			if tg_op = 'INSERT' then
				insert into Food_images(id)
					values (new.id);
			end if;
			return new;
		end;
	$$
		LANGUAGE 'plpgsql';

create trigger create_food_ins AFTER insert on Foods FOR each ROW
EXECUTE PROCEDURE create_food();


------------
--  USER  --
------------

--this trigger will create a contact and address where id == to the newly created user
--but this will not store any other attribute of contact and address. only the id.
create or replace function create_contact_address() returns trigger as
	$$
		begin
			if tg_op = 'INSERT' then
				insert into User_contacts(id)
					values (new.id);
				insert into User_address(id)
					values (new.id);
			end if;
			return new;
		end;
	$$
		LANGUAGE 'plpgsql';


create trigger create_user_trigger AFTER insert on Users FOR each ROW
EXECUTE PROCEDURE create_contact_address();


------------
-- ORDERS --
------------

--this trigger will create an order_foods where id == to the newly created order
--but this will not store any other attribute of order_foods. only the id.
create or replace function create_order_foods() returns trigger as
	$$
		begin
			if tg_op = 'INSERT' then
				insert into Order_foods(id)
					values (new.id);
			end if;
			return new;
		end;
	$$
		LANGUAGE 'plpgsql';


create trigger create_order_foods_ins AFTER insert on Orders FOR each ROW
EXECUTE PROCEDURE create_order_foods();


------------------
-- TRANSACTIONS --
------------------

--this trigger will create a transaction_address where id == to the newly created transaction
--but this will not store any other attribute of transaction_address. only the id.
create or replace function create_transaction() returns trigger as
	$$
		begin
			if tg_op = 'INSERT' then
				insert into Transaction_address(id)
					values (new.id);
			end if;
			return new;
		end;
	$$
		LANGUAGE 'plpgsql';


create trigger create_transaction_ins AFTER insert on Transactions FOR each ROW
EXECUTE PROCEDURE create_transaction();