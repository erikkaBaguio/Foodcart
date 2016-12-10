--[POST] Add new restaurant details
--select store_restaurant('Cozy Cup', 10)
create or replace function store_restaurant(par_restoName varchar, par_minOrder float)
	returns bigint as
	$$
		DECLARE
			local_name	varchar;
			local_response int;
		BEGIN
			if (check_restaurant(par_restoName) = 0)
			then
				insert into Restaurants(resto_name, min_order)
				values (par_restoName, par_minOrder);

				select into local_response currval(pg_get_serial_sequence('Restaurants','id'));

        update Restaurants
          set image_id = local_response
        where id = local_response;

			else
				local_response = check_restaurant(par_restoName);

			end if;

			return local_response;
		END;
	$$
		language 'plpgsql';


--Checks if restuarant exists. If not, add new restaurant.
create or replace function check_restaurant(par_restoName varchar)
	returns bigint as
	$$
		declare
			local_name varchar;
			local_id bigint;

		begin
			select into local_name resto_name
			from Restaurants
			where resto_name = par_restoName;

			if local_name isnull
			then
				local_id = 0;
			else
				select into local_id id
				from Restaurants
				where resto_name = par_restoName;

			end if;

			return local_id;

		end;

	$$
		language 'plpgsql';


--[POST] Adds new restaurant branch
--select store_restaurant_branch(1, 10.5 );
create or replace function store_restaurant_branch(par_restoID bigint, par_deliveryFee float)
	returns bigint as
	$$
		declare
			local_name varchar;
			local_id bigint;
			local_response bigint;

		begin

			insert into Restaurant_branch(del_fee, resto_id)
			  values (par_deliveryFee, par_restoID);

			select into local_response currval(pg_get_serial_sequence('Restaurant_branch','id'));

			return local_response;

		end;
	$$
		language 'plpgsql';


--[PUT] Update contact
--select update_contact(1, 'e.b@gmail.com', '283-29-34', '0912345789');
create or replace function update_contact(par_id int, in par_email varchar, in par_telNum varchar, in par_mobNum varchar)
	returns text as
	$$
		declare
			local_response text;

		begin
			Update Contacts
			set email = par_email,
				tel_number = par_telNum,
				mobile_number = par_mobNum
			where id = par_id;

			local_response = 'OK';

			return local_response;
		end;
	$$
		language 'plpgsql';


--[PUT] Update address
--select update_address(1, '20','Straight St', 10)
create or replace function update_address(par_id int, in par_bldgNum varchar, in par_street varchar, in par_roomNum int)
	 returns text as
	$$

		declare
			local_response text;

		begin
			Update Address
			set bldg_number = par_bldgNum,
				street = par_street,
				room_number = par_roomNum
			where id = par_id;

			local_response = 'OK';

			return local_response;
		end;
	$$
		language 'plpgsql';


--[PUT] Update image
--select update_image(1, 'sample.jpg')
create or replace function update_image(par_id int, in par_url varchar)
	returns text as
	$$
		declare
			local_response text;

		begin
			Update Images
			set url = par_url
			where id = par_id;

			local_response = 'OK';

			return local_response;
		end;
	$$
		language 'plpgsql';