--[POST] Add new restaurant details
--select store_restaurant('Cozy Cup', 10, 0, 'San Miguel, Iligan City')
create or replace function store_restaurant(par_restoName varchar, par_minOrder float, par_deliveryFee float, par_location varchar)
	returns text as
	$$
		DECLARE
			local_name	varchar;
			local_response text;
		BEGIN

			select into local_name resto_name
			from Restaurant
			where resto_name = par_restoName;
			
			if local_name isnull
			then
				insert into Restaurant(resto_name, min_order, delivery_fee, location)
				values (par_restoName, par_minOrder, par_deliveryFee, par_location);
			
				local_response = 'OK';
			else	
				local_response = 'EXISTED';
			
			end if;
			
			return local_response;
		END;
	$$
		language 'plpgsql';


--[POST] Add new user
--select store_user('ahlaine', 'gem', 'pabs', 'iligan', 'gem@gmail.com', '0123', 'asas', 1, '0');
create or replace function store_user(par_fname VARCHAR, par_mname VARCHAR, par_lname VARCHAR, par_address VARCHAR, par_email VARCHAR,
									 par_mobileNum VARCHAR, par_password VARCHAR, par_roleID INT, par_points VARCHAR)
	returns text as
	$$
		DECLARE
		  loc_name TEXT;
			loc_res TEXT;
		BEGIN
			select into loc_name email from Userinfo where email = par_email;

			if loc_name isnull then
        insert into Userinfo(fname, mname, lname, address, email, mobile_number, user_password, role_id, earned_points)
        values(par_fname, par_mname, par_lname, par_address, par_email, par_mobileNum, par_password, par_roleID, par_points);

			  loc_res = 'OK';
			else
			  loc_res = 'EXISTED';

			END IF;

			RETURN loc_res;
		END;
	$$
		language 'plpgsql';


--[GET] Retrieve all users
-- select * from get_all_user();
create or replace function get_all_user(OUT BIGINT, OUT VARCHAR, OUT VARCHAR, OUT VARCHAR, OUT VARCHAR, OUT VARCHAR, OUT VARCHAR, OUT VARCHAR, OUT INT, OUT VARCHAR)
	RETURNS SETOF RECORD as
	$$
		SELECT id, fname, mname, lname, address, email, mobile_number, user_password, role_id, earned_points FROM Userinfo;
	$$
		language 'sql';


--[GET] Retrieve specific user
--select * from show_user(12);
create or replace function show_user(in par_id BIGINT, OUT VARCHAR, OUT VARCHAR, OUT VARCHAR, OUT VARCHAR, OUT VARCHAR, OUT VARCHAR, OUT VARCHAR, OUT INT, OUT VARCHAR)
	returns setof record as
	$$
		SELECT fname, mname, lname, address, email, mobile_number, user_password, role_id, earned_points FROM Userinfo WHERE id = par_id;
	$$
	language 'sql';


--[PUT] Update User
create or replace function update_user(in par_id BIGINT, par_fname VARCHAR, par_mname VARCHAR, par_lname VARCHAR, par_address VARCHAR, par_email VARCHAR,
									 par_mobileNum VARCHAR, par_password VARCHAR, par_roleID INT, par_points VARCHAR)
	returns text as
	$$
		declare
			loc_res text;

		begin
			update Userinfo
			set fname = par_fname,
				mname = par_mname,
				lname = par_lname,
				address = par_address,
				email = par_email,
				mobile_number = par_mobileNum,
				user_password = par_password,
				role_id = par_roleID,
				earned_points = par_points
			where id = par_id;

			loc_res = 'OK';
			return loc_res;
		end;
	$$
		language 'plpgsql';


--Search User
create or replace function search_user(in par_search text, out varchar, out varchar, out varchar, out varchar, out varchar, out varchar, out int, out varchar)
  returns setof record as
  $$
    select fname, mname, lname, address, email, mobile_number, role_id, earned_points from Userinfo where fname like '%' || par_search || '%'
        or mname like '%' || par_search || '%'
        or lname like '%' || par_search || '%'
        or email like '%' || par_search || '%';
  $$
    language 'sql';


--Deactivate User
create or replace function deactivate_user(in par_id bigint) returns text as
  $$
    declare
      loc_res text;
    begin
      update Userinfo set is_active = False where id = par_id;

      loc_res = 'SUCCESS';
      return loc_res;
    end;
  $$
    language 'plpgsql';


--[GET] Retrieve specific restaurant
--select show_all_restaurant();
create or replace function show_all_restaurant(out bigint, out varchar, out float, out float, out varchar, out boolean)
	returns setof record as
	$$
		select *
		from Restaurant
	$$
	language 'sql';


--[GET] Retrieve specific restaurant
--select show_restaurant(1);
create or replace function show_restaurant(in par_restoID bigint, out bigint, out varchar, out float, out float, out varchar, out boolean)
	returns setof record as
	$$
		select *
		from Restaurant
		where Restaurant.id = par_restoID
	$$
	language 'sql';


--[POST] Add new order
--select store_order(3, 1, 1);
create or replace function store_order(par_roleID INT, par_paymentID FLOAT, par_orderfoodsID INT)
	returns text as
	$$
		DECLARE
			loc_res TEXT;
		BEGIN
        insert into Orders(role_id, payment_id, order_foods_id)
        values(par_roleID, par_paymentID, par_orderfoodsID);

			  loc_res = 'OK';

			RETURN loc_res;
		END;
	$$
		language 'plpgsql';


--[POST] Login
create or replace function loginauth(in par_email varchar, in par_password varchar) returns text as
$$
  DECLARE
    loc_email text;
    loc_password text;
    loc_res text;
  BEGIN
    select into loc_email email from Userinfo where email = par_email;
    select into loc_password user_password from Userinfo where user_password = par_password;

    if loc_email isnull or loc_password isnull or loc_email = '' or loc_password = '' then
      loc_res = 'Invalid Email or Password';
    else
      loc_res = 'Successfully Logged In';
    end if;
    return loc_res;

  END;
$$
  LANGUAGE 'plpgsql';
