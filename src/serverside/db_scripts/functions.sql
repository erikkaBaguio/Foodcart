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