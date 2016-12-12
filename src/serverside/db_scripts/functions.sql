--select store_user('Ma.', 'Erikka', 'Baguio', 'asdasd', 1);
create or replace function store_user(in par_fname varchar, in par_mname varchar, in par_lname varchar, in par_password varchar,
                    in par_rolename int)
  returns bigint as
  $$
    declare
      local_name text;
      local_response bigint;
    begin

      select into local_name fname || lname from Users where fname = par_fname and lname = par_lname;
      IF local_name isnull then
        insert into Users (fname, mname, lname, user_password, role_id)
        values (par_fname, par_mname, par_lname, par_password, par_rolename);

      SELECT INTO local_response currval(pg_get_serial_sequence('Users','id'));

      update Users
      set contact_id = local_response,
          address_id = local_response
      where id = local_response;

      return local_response;

      ELSE
        --local_response returns 0 if user exists
        local_response = 0;

      END IF;
      RETURN local_response;

    end;
  $$
    language 'plpgsql';


--[PUT] Update User Contact
--select update_user_contact(2, 'kristel@gmail.com', '225-1116', '0912345789');
create or replace function update_user_contact(par_id int, in par_email varchar, in par_telNum varchar, in par_mobNum varchar)
	returns text as
	$$
		declare
			local_response text;

		begin
			Update User_contacts
			set email = par_email,
				tel_number = par_telNum,
				mobile_number = par_mobNum
			where id = par_id;

			local_response = 'OK';

			return local_response;
		end;
	$$
		language 'plpgsql';


--[PUT] Update User Address
--select update_user_address(2, '5','Streetmark', '4A')
create or replace function update_user_address(par_id int, in par_bldgNum varchar, in par_street varchar, in par_roomNum varchar)
	 returns text as
	$$

		declare
			local_response text;

		begin
			Update User_address
			set bldg_number = par_bldgNum,
				street = par_street,
				room_number = par_roomNum
			where id = par_id;

			local_response = 'OK';

			return local_response;
		end;
	$$
		language 'plpgsql';

