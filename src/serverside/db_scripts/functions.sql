--this trigger will create a contact and address where id == to the newly created user
--but this will not store any other attribute of contact and address. only the id.
create or replace function create_contact() returns trigger as
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