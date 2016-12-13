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