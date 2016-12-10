--this trigger will create a contact and address where id == to the newly created user
--but this will not store any other attribute of contact and address. only the id.
create or replace function create_contact_address() returns trigger as
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

create trigger create_contacts_trigger AFTER insert on Users FOR each ROW
EXECUTE PROCEDURE create_contact();


--select store_role('Ma.', 'Erikka', 'Baguio', 'asdasd', 1);
create or replace function store_user(in par_fname varchar, in par_mname varchar, in par_lname varchar, in par_password varchar,
									  in par_rolename int)
  returns bigint as
  $$
    declare
      local_response bigint;
    begin

      insert into Users (fname, mname, lname, user_password, role_id)
      values (par_fname, par_mname, par_lname, par_password, par_rolename);

      SELECT INTO local_response currval(pg_get_serial_sequence('Users','id'));

      update Users
      set contact_id = local_response,
          address_id = local_response
      where id = local_response;

      return local_response;

    end;
  $$
    language 'plpgsql';