--[POST] Add new restaurant details
--select store_restaurant('Cozy Cup', 10)
create or replace function store_restaurant(par_restoName varchar, par_minOrder float)
	returns bigint as
	$$
		DECLARE
			local_name varchar;
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


--[PUT] Update resaturant branch
--select update_restaurant_branch(1,20)
create or replace function update_restaurant_branch(in par_restoID int, par_deliveryFee float)
	returns text as
	$$
		declare
			local_response text;
		begin
			update Restaurant_branch
			set delivery_fee = par_deliveryFee
			where id = par_restoID;

			local_response = 'OK';
			return local_response;
		end;
	$$
	language 'plpgsql';


--[GET] Retrieve restaurant id
--select get_restaurant_id(1);
create or replace function get_restaurant_id(in par_resto_branch_id int)
	returns int as
	$$
		select resto_id
		from Restaurant_branch
		where id = par_resto_branch_id;
	$$
	language 'sql';


--[PUT] Update resaturant
--select update_restaurant(1,20)
create or replace function update_restaurant(in par_restoID int, par_minOrder float)
	returns text as
	$$
		declare
			local_response text;
		begin
			update Restaurants
			set min_order = par_minOrder
			where id = par_restoID;

			local_response = 'OK';
			return local_response;
		end;
	$$
	language 'plpgsql';


--[DELETE] Deactivates restaurant_branch
--select delete_restaurant_branch(1);
create or replace function delete_restaurant_branch(in par_restoID bigint)
	returns text as
	$$
		declare
			local_response text;
		begin
			update Restaurant_branch
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
create or replace function search_restaurant(in par_search text, out bigint, out varchar, out float, out int) returns setof record as
  $$
      select *
      from Restaurants
      where resto_name like '%'|| par_search || '%';
  $$
  language 'sql';


------------
--  FOOD  --
------------

--[POST] Add food
--select store_food('test food', 'test description', 1,1);
create or replace function store_food(par_food_name varchar, par_description text, par_unit_cost float, par_resto_id int)
	returns bigint as
	$$
		declare
			local_food_name	varchar;
			local_response bigint;

		begin

			select into local_food_name food_name
			from Foods
			where food_name = par_food_name;

			if local_food_name isnull
			then
				insert into Foods(food_name, description, unit_cost, resto_id)
					values (par_food_name, par_description, par_unit_cost, par_resto_id);

				select into local_response currval(pg_get_serial_sequence('Foods','id'));

				update Foods
				set image_id = local_response
				where id = local_response;

			else
				local_response = 0;

			end if;

			return local_response;

		end;
	$$
	language 'plpgsql';


--[GET] Retrieve all food of a specific restaurant
--select show_foods(1)
create or replace function show_foods(par_resto_id int, out bigint, out varchar, out text, out float, out boolean, out boolean, out varchar)
  returns setof record as
  $$

    select Foods.id, food_name, description, unit_cost, is_available, is_active, url
    from Foods
    inner join Food_images on Foods.image_id = Food_images.id
    where Foods.resto_id= par_resto_id;

  $$
    language 'sql';


--[PUT] Update food image
--select update_food_image(1, 'sample.jpg')
create or replace function update_food_image(par_id int, in par_url varchar)
	returns text as
	$$
		declare
			local_response text;

		begin
			Update Food_images
			set url = par_url
			where id = par_id;

			local_response = 'OK';

			return local_response;
		end;
	$$
		language 'plpgsql';


--[GET] Retrieve information of a specific food
--select show_food(resto_id, food_id)
create or replace function show_food(par_resto_id int, par_food_id int, out bigint, out varchar, out text, out float, out boolean, out boolean, out varchar)
  returns setof record as
  $$

    select Foods.id, food_name, description, unit_cost, is_available, is_active, url
    from Foods
    inner join Food_images on Foods.image_id = Food_images.id
    where Foods.resto_id = par_resto_id and Foods.id = par_food_id;

  $$
    language 'sql';


--[PUT] Update food information
--select update_food(3, 'Madcow', 'The original hot and spicy pizza in the world.', 300)
--select update_food(3, 'Tacorella', 'A taste of famous Mexican taco delicacy in a pizza.', 300)
create or replace function update_food(par_food_id int, par_food_name varchar, par_description text, par_unit_cost float)
  returns text as
  $$

    declare
      local_response text;

    begin
        Update Foods
        set food_name = par_food_name,
            description = par_description,
            unit_cost = par_unit_cost
        where id = par_food_id;

        local_response = 'SUCCESS';
        return local_response;

    end;
  $$
    language 'plpgsql';


--Returns set of foods that match or slightly match your search
--select search_restaurant('Iligan');
--source: http://www.tutorialspoint.com/postgresql/postgresql_like_clause.htm
--source on concationation in postgres: http://www.postgresql.org/docs/9.1/static/functions-string.html
create or replace function search_food(in par_search text, out bigint, out varchar, out text, out float, out int, out int, out boolean, out boolean) returns setof record as
  $$
      select *
      from Foods
      where food_name like '%'|| par_search || '%';
  $$
  language 'sql';


--[DELETE] Deactivates restaurant_branch
--select delete_food(1);
create or replace function delete_food(in par_food_id bigint)
	returns text as
	$$
		declare
			local_response text;
		begin
			update Foods
			set is_active = False
			where id = par_food_id ;

			local_response = 'SUCCESS';
			return local_response;
		end;
	$$
	language 'plpgsql';

------------
--  USERS --
------------

--[POST] Sign up
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


--Check if user exists via email
create or replace function check_email(in par_email varchar) returns text as
  $$
    declare
      local_response text;
      local_id bigint;
    begin
      select into local_id id
      from User_contacts
      where User_contacts.email = par_email;

      if local_id isnull then
        local_response = 'OK';
      else
        local_response = 'ALREADY EXISTS';
      end if;

      return local_response;
    end;
  $$
    language 'plpgsql';


--[GET] Get password of a specific user
--select get_password('minho@gmail.com');
create or replace function get_password(par_email varchar) returns text as
  $$
    declare
      loc_password text;
    begin
      select into loc_password Users.user_password
      from Users, User_contacts
      where User_contacts.email = par_email;

      if loc_password isnull then
        loc_password = 'null';
      end if;
      return loc_password;
    end;
  $$
    language 'plpgsql';


--check email and password
create or replace function check_email_password(in par_email varchar, in par_password varchar) returns text as
  $$
    declare
      local_response text;
    begin
      select into local_response email
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
--select * from show_user_email('james@gmail.com	');
create or replace function show_user_email(in par_email varchar, out bigint, out varchar, out varchar, out varchar, out varchar, out float, out int, out int, out int, out boolean, out varchar, out varchar, out varchar, out varchar, out varchar, out varchar) returns setof record as
  $$
    select
      Users.id,
      Users.fname,
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
    where User_contacts.email = par_email;
  $$
    language 'sql';



--[GET] View user by ID
--select * from show_user_id(4);
create or replace function show_user_id(in par_ID bigint, out varchar, out varchar, out varchar, out varchar, out float, out int, out int, out int,
out varchar, out varchar, out varchar, out varchar, out varchar, out varchar) returns setof record as
  $$
    select Users.fname,
      Users.mname,
      Users.lname,
      Users.user_password,
      Users.earned_points,
      Users.contact_id,
      Users.address_id,
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


------------
-- ORDERS --
------------

--[POST] Add order
--select add_order(4);
create or replace function add_order(in par_userID int) returns bigint as
  $$
    declare
      local_response bigint;
    begin
      insert into Orders(user_id) values (par_userID);

      select into local_response currval(pg_get_serial_sequence('Orders', 'id'));

      update Orders
      set order_food_id = local_response
      where id = local_response;

      return local_response;
    end;
  $$
    language 'plpgsql';


--[PUT] Update Order_foods
--select update_orderfoodID(1, 1, 4, 2);
create or replace function update_orderfoodID(par_id int, in par_quantity int, in par_foodID int, in par_restobranchID int)
	 returns text as
	$$

		declare
			local_response text;

		begin
			Update Order_foods
			set quantity = par_quantity,
				food_id = par_foodID,
				resto_branch_id = par_restobranchID
			where id = par_id;

			local_response = 'OK';

			return local_response;
		end;
	$$
		language 'plpgsql';


--[GET] Retrieve order by id
--select * from show_order_id(1);
create or replace function show_order_id(in par_ID bigint, out int, out int, out int, out int, out boolean) returns setof record as
  $$
    select
      Orders.user_id,
      Order_foods.quantity,
      Order_foods.food_id,
      Order_foods.resto_branch_id,
      Orders.is_done
    from Orders
    inner join Order_foods on Orders.order_food_id = Order_foods.id
    where Orders.id = par_ID;
  $$
    language 'sql';


--[GET] Retrieve all orders
--select * from show_orders();
create or replace function show_orders(out bigint, out int, out int, out boolean, out int, out int, out int) returns setof record as
  $$
    select Orders.*,
      Order_foods.quantity,
      Order_foods.food_id,
      Order_foods.resto_branch_id
    from Orders
    inner join Order_foods on Orders.order_food_id = Order_foods.id
  $$
    language 'sql';


--[PUT] Update order
--select update_order(1, 2, true);
create or replace function update_order(par_id int, par_quantity int, par_done boolean) returns text as
  $$
    declare
      local_response text;
    begin
      Update Orders
      set Order_foods.quantity = par_quantity,
          is_done = par_done
      from Order_foods
      inner join Order_foods on Orders.order_food_id = Order_foods.id
      where id = par_id;

      local_response = 'OK';

			return local_response;
		end;
  $$
    language 'plpgsql';


------------------
-- TRANSACTIONS --
------------------

--[POST] Add transaction
--select add_transaction(1, 1, 12.50);
create or replace function add_transaction(in par_transnum int, in par_orderID int, in par_total float)
 returns bigint as
  $$
    declare
      local_response bigint;
    begin
      insert into Transactions(transaction_number, order_id, total)
      values (par_transnum, par_orderID, par_total);

      select into local_response currval(pg_get_serial_sequence('Transactions', 'id'));

      update Transactions
      set address_id = local_response
      where id = local_response;

      return local_response;
    end;
  $$
    language 'plpgsql';


--[PUT] Update Transaction_address
--select update_trans_address(5, '63', 'test street', '2');
create or replace function update_trans_address(par_id int, in par_bldgNum varchar, in par_street varchar, in par_roomNum varchar)
	 returns text as
	$$

		declare
			local_response text;

		begin
			Update Transaction_address
			set bldg_number = par_bldgNum,
				street = par_street,
				room_number = par_roomNum
			where id = par_id;

			local_response = 'OK';

			return local_response;
		end;
	$$
		language 'plpgsql';


--[GET] Retrieve transaction by id
--select * from show_transaction_id(5);
create or replace function show_transaction_id(in par_ID bigint, out int, out timestamp, out int, out float,
out varchar, out varchar, out varchar, out boolean) returns setof record as
  $$
    select
      Transactions.transaction_number,
      Transactions.transaction_date,
      Transactions.order_id,
      Transactions.total,
      Transaction_address.bldg_number,
      Transaction_address.street,
      Transaction_address.room_number,
      Transactions.is_paid
    from Transactions
    inner join Transaction_address on Transactions.address_id = Transaction_address.id
    where Transactions.id = par_ID;
  $$
    language 'sql';



--[GET] Retrieve all transactions
--select * from show_transaction();
create or replace function show_transaction(out int, out timestamp, out int, out float,
out varchar, out varchar, out varchar, out boolean) returns setof record as
  $$
    select
      Transactions.transaction_number,
      Transactions.transaction_date,
      Transactions.order_id,
      Transactions.total,
      Transaction_address.bldg_number,
      Transaction_address.street,
      Transaction_address.room_number,
      Transactions.is_paid
    from Transactions
    inner join Transaction_address on Transactions.address_id = Transaction_address.id
  $$
    language 'sql';



-----------
-- ROLES --
-----------

--[POST] Add Role
--select store_role('System Admin');
create or replace function store_role(par_rolename VARCHAR)
	returns text as
	$$
		DECLARE
			loc_rname TEXT;
			loc_res TEXT;
		BEGIN
			SELECT INTO loc_rname rolename FROM Roles  WHERE rolename = par_rolename;

			IF loc_rname ISNULL
			THEN
				INSERT INTO Roles(rolename) VALUES (par_rolename);
				loc_res = 'OK';

			ELSE
				loc_res = 'EXISTED';

			END IF;
			RETURN loc_res;
		END;
	$$
		language 'plpgsql';




------------------------------------------------------------- QUERIES --------------------------------------------------------------
select store_role('System Admin');
select store_role('Business Manager');
select store_role('Customer');