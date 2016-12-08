--[POST] Add new contact
--select new_contact()
create or replace function store_contact(par_email VARCHAR, par_telno VARCHAR, par_mobile VARCHAR)
	returns text as
	$$
		DECLARE
			loc_res TEXT;
		BEGIN
        insert into Contact(email, tel_number, mobile_number)
        values(par_email, par_telno, par_mobile);

			  loc_res = 'OK';

			RETURN loc_res;
		END;
	$$
		language 'plpgsql';