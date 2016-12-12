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