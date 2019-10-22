create table product_data
(
	pk serial primary key,
	product_name text ,
	product_bar_code text ,
	product_stocks int ,
	product_srp text ,
	product_price text ,
	product_supplier text ,
	date_created timestamptz default now(),
	archived boolean default false
);
alter table product_data owner to ktapdasan;

--sept 25,2017
alter table product_data add column product_receipt_name text;

--sept 29,2017
alter table product_data add column product_status text;

--oct 6,2017
alter table product_data add column product_or_number text;

--oct 12,2017
alter table product_data add column product_or_stocks text;
alter table product_data add column product_product_code text;
alter table product_data add column product_rules text;
alter table product_data add column product_kind text;

--oct 16,2017
alter table product_data add column request_order_status text;


--Dec. 19,2017
alter table product_data add column product_branches text;

--Dec. 19,2017
alter table product_data add column product_image text;

--Dec. 19,2017
alter table product_data add column input_vat double precision;
alter table product_data add column output_vat double precision;
alter table product_data add column selling_price double precision;
alter table product_data add product_size_name text;
alter table product_data add product_size_value int;
alter table product_data add remarks text;


create table customer_data
(
	pk serial primary key,
	first_name text ,
	middle_name text ,
	last_name text ,
	email text ,
	contact_number text ,
	date_created timestamptz default now(),
	archived boolean default false
);
alter table customer_data owner to ktapdasan;
-- added nov30,2017
alter table customer_data add column tin text;
alter table customer_data add column cadd text;
alter table customer_data add column company text;
alter table customer_data add column job_position text;
-- added dec 2,2017
alter table customer_data add column percent int;

alter table customer_data add column last_day timestamptz default now();

create table supplier_data
(
	pk serial primary key,
	supplier_name text ,
	supplier_address text ,
	supplier_contact_number text ,
	supplier_contact_person text ,
	supplier_code_name text ,
	date_created timestamptz default now(),
	archived boolean default false
);
alter table supplier_data owner to ktapdasan;

--sept 29,2017
alter table supplier_data alter column supplier_contact_number type text ;

create table request_order_data
(
	pk serial primary key,
	product_finalnumber text ,
	product_quantity text ,
	product_date_needed text ,
	product_market_price text ,
	product_pk text ,
	status text default 'Pending',
	date_created timestamptz default now(),
	archived boolean default false
);
alter table request_order_data owner to ktapdasan;

--sept 22,2017
alter table request_order_data add column product_name text;

--oct 17,2017
alter table request_order_data add column request_order_status text;
ALTER TABLE request_order_data alter column product_pk drop ;
alter table request_order_data add column remarks text;
alter table request_order_data add column requested_by_pk int;


create table tender_data
(
	pk serial primary key,
	product_name text ,
	product_quantity int ,
	product_supplier_price text ,
	product_retail_price text ,
	product_transaction_number text ,
	vat_percentage text ,
	net_amount text ,
	vat text ,
	discount text ,
	change text ,
	cash text ,
	tempo_total text ,
	void_count text ,
	total text ,
	gc_amount text ,
	gc_name text ,
	gc_code text ,
	cashier_user_id text ,
	date_created text,
	archived boolean default false
);
alter table tender_data owner to ktapdasan;

--oct 6,2017
alter table tender_data add column product_pk int;
alter table tender_data add item_size_name text;
alter table tender_data add item_has_size text;
alter table tender_data add exchange_remarks text;

create table exchange_tender_data
(
	pk serial primary key,
	product_name text ,
	product_quantity int ,
	product_supplier_price text ,
	product_retail_price text ,
	product_transaction_number text ,
	vat_percentage text ,
	net_amount text ,
	vat text ,
	discount text ,
	change text ,
	cash text ,
	tempo_total text ,
	void_count text ,
	total text ,
	gc_amount text ,
	gc_name text ,
	gc_code text ,
	cashier_user_id text ,
	date_created text,
	archived boolean default false
);
alter table exchange_tender_data owner to ktapdasan;

--oct 6,2017
alter table exchange_tender_data add column product_pk int;
alter table exchange_tender_data add item_size_name text;
alter table exchange_tender_data add item_has_size text;
alter table exchange_tender_data add exchange_remarks text;

create table gift_certificate_data
(
	pk serial primary key,
	gc_name text ,
	gc_code text ,
	gc_amount text ,
	cashier_user_id int ,
	date_created timestamptz default now(),
	archived boolean default false
);
alter table gift_certificate_data owner to ktapdasan;

create table added_user_data
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
alter table added_user_data owner to ktapdasan;

 
-- oct 9 , 2017
create table rules_data
(
	pk serial primary key,
	rule_name text ,
	date_created timestamptz default now(),
	archived boolean default false
);
alter table rules_data owner to ktapdasan;

-- nov 18 , 2017
create table history_log_data
(
	pk serial primary key,
	name text ,
	action text ,
	cashier_user_id text ,
	date_created timestamptz default now(),
	archived boolean default false
);
alter table history_log_data owner to ktapdasan;

-- nov 18 , 2017
create table product_expire_status_confirm
(
	pk serial primary key,
	cashier_user_id text ,
	status text ,
	date_created timestamptz default now(),
	archived boolean default false
);
alter table product_expire_status_confirm owner to ktapdasan;

create table branch_data
(
	pk serial primary key,
	branch_name text ,
	address text ,
	contact_person text ,
	contact_number text ,
	date_created timestamptz default now(),
	archived boolean default false
);
alter table branch_data owner to ktapdasan;

--Dec 19,2017

alter table customer_data add company text;
alter table customer_data add job_position text;

alter table branch_data add vat_registered boolean;

alter table added_user_data add branch_assignment text;
alter table users add branch_assignment text;



-- Feb 21 , 2018
create table discounted_aomos_staff_data
(
	pk serial primary key,
	customer_name text ,
	transaction_number text ,
	cashier_user_id text ,
	date_created timestamptz default now(),
	archived boolean default false
);
alter table discounted_aomos_staff_data owner to ktapdasan;

--march 21,2018
create table news_feed
(
	pk serial primary key,
	user_id text,
	description text,
	name text,
	link text,
	type text,
	date_created timestamptz default now(),
	archived boolean default false
);
alter table news_feed owner to ktapdasan;

--may 9,2018
create table voucher_data
(
	pk serial primary key,
	customer_name text,
	voucher_number text,
	date_created timestamptz default now(),
	archived boolean default false
);
alter table voucher_data owner to ktapdasan;

--may 15,2018
create table refund_item_data
(
	pk serial primary key,
	product_name text ,
	product_srp text ,
	product_bar_code text ,
	product_stocks int ,
	product_price text ,
	product_expiration text ,
	product_supplier text ,
	product_receipt_name text ,
	product_or_number text ,
	product_or_stocks text ,
	product_product_code text ,
	product_rules text ,
	product_kind text ,
	remarks text ,
	date_created timestamptz default now(),
	archived boolean default false
);
alter table refund_item_data owner to ktapdasan;

-- May 16,2018
create table down_payment_data
(
	pk serial primary key,
	product_name text ,
	customer_name text ,
	product_quantity int ,
	product_supplier_price text ,
	product_retail_price text ,
	product_transaction_number text ,
	vat_percentage text ,
	net_amount text ,
	vat text ,
	discount text ,
	type text ,
	down_payment_amount text ,
	change text ,
	cash text ,
	tempo_total text ,
	void_count text ,
	total text ,
	gc_amount text ,
	gc_name text ,
	gc_code text ,
	cashier_user_id text ,
	date_created timestamptz default now(),
	archived boolean default false
);
alter table down_payment_data owner to ktapdasan;
alter table down_payment_data add column product_pk int;
alter table down_payment_data add column cancelled_amount text;
alter table down_payment_data add column product_branches text;
alter table down_payment_data add column cnumber text;
alter table down_payment_data add item_size_name text;
alter table down_payment_data add item_has_size text;
-- May 16,2018
alter table down_payment_data add balance text;

-- May 16,2018
create table payment_data
(
	pk serial primary key,
	productname text ,
	productamount text ,
	date_created timestamptz default now(),
	archived boolean default false
);
alter table payment_data owner to ktapdasan;

-- June 4,2018
create table data_collected
(
	pk serial primary key,
	barcode text ,
	quantity text ,
	date_created timestamptz default now(),
	archived boolean default false
);
alter table data_collected owner to ktapdasan;