--this trigger will create a contact and addresses where id == to the newly created restaurant branch.
--but this will not store any other attribute of contacts and addresses. only the id.
create or replace function create_restaurant_branch() returns trigger as
	$$
		begin
			if tg_op = 'INSERT' then
				insert into Contacts(id)
					values (new.id);
				insert into Address(id)
					values (new.id);
			end if;
			return new;
		end;
	$$
		LANGUAGE 'plpgsql';

create trigger create_restaurant_branch_ins AFTER insert on Restaurant_branch FOR each ROW
EXECUTE PROCEDURE create_restaurant_branch();


--this trigger will create an image where id == to the newly created restaurant.
--but this will not store any other attribute of image, only the id.
create or replace function create_restaurant() returns trigger as
	$$
		begin
			if tg_op = 'INSERT' then
				insert into Images(id)
					values (new.id);
			end if;
			return new;
		end;
	$$
		LANGUAGE 'plpgsql';

create trigger create_restaurant_ins AFTER insert on Restaurants FOR each ROW
EXECUTE PROCEDURE create_restaurant();