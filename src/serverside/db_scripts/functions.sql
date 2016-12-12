--select store_user('Ma.', 'Erikka', 'Baguio', 'asdasd', 1);
create or replace function store_user(in par_fname varchar, in par_mname varchar, in par_lname varchar, in par_password varchar,
									  in par_rolename int)
  returns bigint as
  $$
    declare
      local_response bigint;
    begin

      insert into Users (fname, mname, lname, user_password, role_id)
      values (par_fname, par_mname, par_lname, par_password, par_rolename);

      SELECT INTO local_response currval(pg_get_serial_sequence('Users','id'));

      update Users
      set contact_id = local_response,
          address_id = local_response
      where id = local_response;

      return local_response;

    end;
  $$
    language 'plpgsql';