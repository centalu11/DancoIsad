patchavez@Engr:~$ sudo su - postgres
[sudo] password for patchavez: 
postgres@Engr:~$ createuser unraveled 
postgres@Engr:~$ psql
psql (9.5.3)
Type "help" for help.

postgres=# alter role unraveled superuser;
ALTER ROLE
postgres=# \q
postgres@Engr:~$ exit
logout
patchavez@Engr:~$ createdb unravaled
patchavez@Engr:~$ psql unravaled
psql (9.5.3)
Type "help" for help.

contactform=# \d
No relations found.
contactform=# \q
patchavez@Engr:~$ psql unravaled 
psql (9.5.3)
Type "help" for help.

contactform=# create user ktapdasan with password '184822e36aa9494fb67770a63090acd9';
CREATE ROLE

create table accounts
(
	user_id text,
    password text DEFAULT md5('user123456'::text),
    user_type text
);
alter table accounts owner to ktapdasan;

insert into accounts
(
	user_id,
	user_type
)
VALUES
(
	'201400028',
	'1'
);



create table users
(
	pk serial primary key,
	user_id text ,
	first_name text ,
	middle_name text ,
	last_name text ,
	user_type text ,
	date_created timestamptz default now(),
	archived boolean default false
);
alter table users owner to ktapdasan;
alter table users add column superior_pin text DEFAULT md5('SirWayne'::text);

--Oct. 20,2017
alter table users add column email text;
--Dec. 19,2017
alter table users add column permission jsonb;

insert into users
(
	first_name,
	middle_name,
	last_name,
	user_id,
	user_type
)
VALUES
(
	'USER',
	'USER',
	'USER',
	'201400028',
	'1'
);



create table pictures
(
	image_pk serial primary key,
	uploaded_by int ,
	link text ,
	date_uploaded timestamptz default now(),
	archived boolean default false
);
alter table pictures owner to ktapdasan;

--mar 22, 2018
alter table users add column agreement boolean default false;

-- Beutify JSONB
{
	"Admin": {
		"Menu": true,
		"Modules": {
			"One": false,
			"Two": true,
			"Three": false,
			"Four": false,
			"Five": false,
			"Six": false,
			"Seven": false,
			"Eight": false,
			"Nine": false,
			"Ten": false,
			"Eleven": false,
			"Twelve": false,
			"Thirteen": false,
			"Fourteen":false,
			"Fifteen":false,
			"Sixteen":false,
			"Seventeen":false,
			"Eighteen":false,
			"Nineteen":false,
			"Twenty": false,
			"Twentyone": false,
			"Twentytwo": false
		}
	},
	"Cashier": {
		"Menu": true
	},
	"ProductE": {
		"Menu": true
	},
	"PriceList": {
		"Menu": true
	}
}

--Minified JSONB
{"Admin":{"Menu":true,"Modules":{"One":true,"Two":true,"Three":true,"Four":true,"Five":true,"Six":true,"Seven":true,"Eight":true,"Nine":true,"Ten":true,"Eleven":true,"Twelve":true,"Thirteen":true,"Fourteen":true,"Fifteen":true,"Sixteen":true,"Seventeen":true,"Eighteen":true,"Nineteen":true,"Twenty":true,"Twentyone":true,"Twentytwo":true}},"Cashier":{"Menu":true},"ProductE":{"Menu":true},"PriceList":{"Menu":true}}