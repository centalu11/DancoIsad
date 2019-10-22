alter table customer_data add company text;
alter table customer_data add job_position text;

alter table product_data add product_size_name text;
alter table product_data add product_size_value int;

alter table branch_data add vat_registered boolean;

alter table added_user_data add branch_assignment text;
alter table users add branch_assignment text;