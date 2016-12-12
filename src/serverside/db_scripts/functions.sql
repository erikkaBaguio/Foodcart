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

--Checks if restaurant branch already exist or not
--select check_restaurant_branch('1','st','5',3);
create or replace function check_restaurant_branch(par_bldg varchar, par_street varchar, par_room varchar,  par_restoID bigint)
  returns boolean as
  $$
    declare
      local_id int;
      local_response boolean;

    begin
      select into local_id id
      from Resto_branch_address
      where id in (select id
		               from Restaurant_branch
		               where resto_id = par_restoID)
		               and bldg_number = par_bldg and street = par_street and room_number = par_room;

      if local_id isnull
      then
        local_response = false; --does not exist

      else
        local_response = true; --does exist

      end if;

      return local_response;

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

			insert into Restaurant_branch(delivery_fee, resto_id)
			  values (par_deliveryFee, par_restoID);

			select into local_response currval(pg_get_serial_sequence('Restaurant_branch','id'));

			update Restaurant_branch
		        set contact_id = local_response,
		            address_id = local_response
		    where id = local_response;

			return local_response;

		end;
	$$
		language 'plpgsql';


--[PUT] Update contact
--select update_resto_branch_contact(1, 'e.b@gmail.com', '283-29-34', '0912345789');
create or replace function update_resto_branch_contact(par_id int, in par_email varchar, in par_telNum varchar, in par_mobNum varchar)
	returns text as
	$$
		declare
			local_response text;

		begin
			Update Resto_branch_contacts
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
--select update_resto_branch_address(1, '20','Straight St', '10')
create or replace function update_resto_branch_address(par_id int, in par_bldgNum varchar, in par_street varchar, in par_roomNum varchar)
	 returns text as
	$$

		declare
			local_response text;

		begin
			Update Resto_branch_address
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
--select update_resto_image(1, 'sample.jpg')
create or replace function update_resto_image(par_id int, in par_url varchar)
	returns text as
	$$
		declare
			local_response text;

		begin
			Update Resto_images
			set url = par_url
			where id = par_id;

			local_response = 'OK';

			return local_response;
		end;
	$$
		language 'plpgsql';


--[GET] Retrieve specific restaurant
--select show_restaurant_branch(1);
create or replace function show_restaurant_branch(in par_restoID bigint, out varchar, out float, out float, out varchar, out varchar, out varchar, out varchar, out varchar, out varchar, out varchar, out boolean)
	returns setof record as
	$$
    select resto_name, delivery_fee, min_order, email, tel_number, mobile_number, bldg_number, street, room_number, url, Restaurant_branch.is_active
		from Restaurant_branch
			inner join Restaurants on Restaurant_branch.resto_id = Restaurants.id
			inner join Resto_branch_contacts on Restaurant_branch.contact_id = Resto_branch_contacts.id
			inner join Resto_branch_address on Restaurant_branch.address_id = Resto_branch_address.id
			inner join Resto_images on Restaurant_branch.resto_id = Resto_images.id
		where Restaurant_branch.id = par_restoID;
	$$
	language 'sql';


--[GET] Retrieve all restaurant branch
--select show_all_restaurant_branch();
create or replace function show_all_restaurant_branch(out bigint, out varchar, out float, out float, out varchar, out varchar, out varchar, out varchar, out varchar, out varchar, out varchar, out boolean)
	returns setof record as
	$$
    select Restaurant_branch.id, resto_name, delivery_fee, min_order, email, tel_number, mobile_number, bldg_number, street, room_number, url, Restaurant_branch.is_active
		from Restaurant_branch
			inner join Restaurants on Restaurant_branch.resto_id = Restaurants.id
			inner join Resto_branch_contacts on Restaurant_branch.contact_id = Resto_branch_contacts.id
			inner join Resto_branch_address on Restaurant_branch.address_id = Resto_branch_address.id
			inner join Resto_images on Restaurant_branch.resto_id = Resto_images.id
	$$
	language 'sql';