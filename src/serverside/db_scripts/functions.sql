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
