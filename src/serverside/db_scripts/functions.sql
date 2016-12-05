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


--[PUT] Update resaturant
--select update_restaurant('Jollibee', 20, 2, 'Tibanga, Iligan City')
create or replace function update_restaurant(in par_restoID bigint, in par_restoName varchar, in par_minOrder float, in par_deliveryFee float, in par_location varchar)
	returns text as
	$$
		declare
			local_response text;
		begin
			update Restaurant
			set resto_name = par_restoName,
				min_order = par_minOrder,
				delivery_fee = par_deliveryFee,
				location = par_location
			where id = par_restoID;
			
			local_response = 'OK';			
			return local_response;
		end;
	$$
	language 'plpgsql';


--[DELETE] Deactivates restaurant
--select delete_restaurant(1);
create or replace function delete_restaurant(in par_restoID bigint) 
	returns text as
	$$
		declare
			local_response text;
		begin
			update Restaurant
			set is_active = False
			where id = par_restoID;

			local_response = 'SUCCESS';
			return local_response;
		end;
	$$
	language 'plpgsql';


--Returns set of restaurants that match or slightly match your search
--select search_restaurant('Iligan');
--source: http://www.tutorialspoint.com/postgresql/postgresql_like_clause.htm
--source on concationation in postgres: http://www.postgresql.org/docs/9.1/static/functions-string.html
create or replace function search_restaurant(in par_search text, out bigint, out varchar, out float, out float, out varchar, out boolean) returns setof record as
  $$
      select * 
      from Restaurant
      where resto_name like '%'|| par_search || '%' or location like '%'|| par_search || '%';
  $$
  language 'sql';




------------
--  FOOD  --
------------

--[POST] Add food
--select store_food('test food', 'test description', 1);
create or replace function store_food(par_food_name varchar, par_description text, par_unit_cost float)
	returns text as
	$$
		declare
			local_food_name	varchar;
			local_response text;

		begin
			select into local_food_name food_name
			from Food
			where food_name = par_food_name;

			if local_food_name isnull
			then
				insert into Food(food_name, description, unit_cost)
					values (par_food_name, par_description, par_unit_cost);

				local_response = 'OK';
			else
				local_response = 'EXISTED';
			
			end if;
			return local_response;

		end;
	$$
	language 'plpgsql';


--[GET] View all food
--select show_all_food();
create or replace function show_all_food(out bigint, out varchar, out text, out float, out boolean)
	returns setof record as
	$$
		select *
		from Food;
	$$
	language 'sql';


--[GET] View food
--select show_food(1);
create or replace function show_food(in par_foodID bigint, out bigint, out varchar, out text, out float, out boolean)
	returns setof record as
	$$
		select *
		from Food
		where id = par_foodID;
	$$
	language 'sql';
