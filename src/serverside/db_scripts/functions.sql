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


