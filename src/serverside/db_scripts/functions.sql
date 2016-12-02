--[POST] Add new restaurant details
--select store_restaurant('Cozy Cup', 10, 0, 'San Miguel, Iligan City')
create or replace function store_restaurant(par_restoName varchar, par_minOrder float, par_deliveryFee float, par_location varchar)
	returns text as
	$$
		DECLARE
			local_response text;
		BEGIN

			if  par_restoName = '' or
				par_minOrder is NULL or
				par_deliveryFee is NULL or
				par_location = '' 
			
			THEN

				local_response = 'ERROR';
			ELSE	

			insert into Restaurant(resto_name, min_order, delivery_fee, location)
			values (par_restoName, par_minOrder, par_deliveryFee, par_location);
			
			local_response = 'OK';
			
			END IF;

			return local_response;
		END;
	$$
		language 'plpgsql';


create or replace function store_user(par_fname TEXT, par_mname TEXT, par_lname TEXT, par_address TEXT, par_email TEXT,
									 par_mobileNum TEXT, par_password TEXT, par_roleID INT, par_points INT)
	returns text as
	$$
		DECLARE
			loc_res TEXT;
		BEGIN
			if par_fname = '' or par_mname = '' or par_lname = '' or par_address = '' or par_email = '' or par_mobileNum = NULL or par_password = ''
							or par_roleID = NULL or par_points = NULL THEN
				loc_res = 'Error';
			ELSE
				INSERT INTO Userinfo(fname, mname, lname, address, email, mobile_number, user_password, role_id, earned_points) VALUES (par_fname, par_mname,
								par_lname, par_address, par_email, par_mobileNum, par_password, par_roleID, par_points);

				loc_res = 'OK';
			END IF;

			RETURN loc_res;
		END;
	$$
		language 'plpgsql';

--select store_user('ahlaine', 'gem', 'pabs', 'iligan', 'gem@gmail.com', '0123', 'asas', 1, '0');