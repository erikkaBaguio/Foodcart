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


--[POST] Log In
--select user_login('james@gmail.com', 'asdasd');
create or replace function user_login(in par_email varchar, in par_password varchar) returns text as
  $$
    declare
      local_response text;
    begin
      select into local_response User_contacts.email
      from Users, User_contacts
      where User_contacts.email = par_email
      and Users.user_password = par_password;

      if local_response isnull then
        local_response = 'FAILED';
      else
        local_response = 'OK';
      end if;

      return local_response;
    end;
  $$
  language 'plpgsql';


--[GET] Show user details using email



--[GET] View user by ID
--select * from show_user_id(4);
create or replace function show_user_id(in par_ID bigint, out varchar, out varchar, out varchar, out varchar, out float, out int, out int, out int, out boolean, out varchar, out varchar, out varchar, out varchar, out varchar, out varchar) returns setof record as
  $$
    select Users.fname,
      Users.mname,
      Users.lname,
      Users.user_password,
      Users.earned_points,
      Users.contact_id,
      Users.address_id,
      Users.role_id,
      Users.is_active,
      User_contacts.email,
      User_contacts.tel_number,
      User_contacts.mobile_number,
      User_address.bldg_number,
      User_address.street,
      User_address.room_number
      from Users
    inner join User_contacts on (
      Users.contact_id = User_contacts.id
    )
    inner join User_address on (
      Users.address_id = User_address.id
    )
    where Users.id = par_ID;
  $$
    language 'sql';


--[GET] View all users
--select * from show_user();
create or replace function show_user(out bigint, out varchar, out varchar, out varchar, out varchar, out float, out int, out int, out int, out boolean, out varchar, out varchar, out varchar, out varchar, out varchar, out varchar) returns setof record as
  $$
    select Users.*,
      User_contacts.email,
      User_contacts.tel_number,
      User_contacts.mobile_number,
      User_address.bldg_number,
      User_address.street,
      User_address.room_number
    from Users
    inner join User_contacts on (
      Users.contact_id = User_contacts.id
    )
    inner join User_address on (
      Users.address_id = User_address.id
    );
  $$
    language 'sql';


--[PUT] Update User
--select update_user(3, 'Kristel', 'Ahlaine', 'Gem', 'asdasd');
create or replace function update_user(in par_ID bigint, par_fname varchar, par_mname varchar, par_lname varchar, par_password varchar, par_points float)
returns text as
  $$
    declare
      local_response text;
    begin
      update Users
      set
        fname = par_fname,
        mname = par_mname,
        lname = par_lname,
        user_password = par_password,
        earned_points = par_points
      where id = par_ID;

      local_response = 'OK';
      return local_response;

    end;
  $$
    language 'plpgsql';


--Deactivate User
--select deactivate_user(1);
create or replace function deactivate_user(in par_id bigint) returns text as
  $$
    declare
      loc_res text;
    begin
      update Users set is_active = False where id = par_id;

      loc_res = 'SUCCESS';
      return loc_res;
    end;
  $$
    language 'plpgsql';


--Search User
--select search_user('James');
create or replace function search_user(in par_search text, out varchar, out varchar, out varchar, out float, out int,
                                      out varchar, out varchar, out varchar, out varchar, out varchar, out varchar)
  returns setof record as
  $$
    select Users.fname,
      Users.mname,
      Users.lname,
      Users.earned_points,
      Users.role_id,
      User_contacts.email,
      User_contacts.tel_number,
      User_contacts.mobile_number,
      User_address.bldg_number,
      User_address.street,
      User_address.room_number
    from Users
    inner join User_contacts on (
      Users.contact_id = User_contacts.id
    )
    inner join User_address on (
      Users.address_id = User_address.id
    )
    where fname like '%' || par_search || '%'
        or mname like '%' || par_search || '%'
        or lname like '%' || par_search || '%';
  $$
    language 'sql';


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

