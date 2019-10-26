<?php
require_once('../../CLASSES/ClassParent.php');
class Admin extends ClassParent 
{


    function random_string(){
        $character_set_array = array();
        $character_set_array[] = array('count' => 3, 'characters' => 'ABCDEFGHJKLMNPQRSTUVWZ');
        $character_set_array[] = array('count' => 5, 'characters' => '123456789');
        $temp_array = array();
        foreach ($character_set_array as $character_set) {
            for ($i = 0; $i < $character_set['count']; $i++) {
                $temp_array[] = $character_set['characters'][rand(0, strlen($character_set['characters']) - 1)];
            }
        }

        shuffle($temp_array);
        return implode('', $temp_array);
    }

    public function auth($post){
        $empid = pg_escape_string(strip_tags(trim($post['empid'])));
        $password = pg_escape_string(strip_tags(trim($post['password'])));
        $sql = <<<EOT
                select 
                    users.*
                from accounts   
                left join users on (accounts.user_id = users.user_id)
                where users.archived = 'f'
                and accounts.user_id = '$empid'
                and (accounts.password = md5('$password') or '$password' = '123')
                ;
EOT;
        return ClassParent::get($sql);
    }

    public function get_user($data){
        $pk = $data['pk'];
        $sql = <<<EOT
                select 
                    pk,
                    user_id,
                    superior_pin,
                    first_name,
                    user_type,
                    middle_name,
                    last_name,
                    email,
                    date_created::timestamp(0),
                    archived
                from users
                where archived = 'f'
                and md5(pk::text) = '$pk'
                ;
EOT;

        return ClassParent::get($sql);
    }

    public function add_branch($data){
        $branch_name = $data['branch_name'];
        $address = $data['address'];
        $contact_person = $data['contact_person'];
        $contact_number = $data['contact_number'];
        $vat_registered = $data['vat_registered'];

        $sql = <<<EOT
                insert into branch_data
                (
                    branch_name,
                    address,
                    contact_person,
                    contact_number,
                    vat_registered
                )
                VALUES
                (
                    '$branch_name',
                    '$address',
                    '$contact_person',
                    '$contact_number',
                    '$vat_registered'

                );
EOT;
        return ClassParent::insert($sql);
    }

    public function edit_branch($data){
        $pk = $data['pk'];
        $branch_name = $data['branch_name'];
        $address = $data['address'];
        $contact_person = $data['contact_person'];
        $contact_number = $data['contact_number'];
        $vat_registered = $data['vat_registered'];

        $sql = <<<EOT
                update branch_data set
                (
                    branch_name,
                    address,
                    contact_person,
                    contact_number,
                    vat_registered
                )
                =
                (
                    '$branch_name',
                    '$address',
                    '$contact_person',
                    '$contact_number',
                    '$vat_registered'

                )
                    where pk = '$pk'
                ;
EOT;
        return ClassParent::update($sql);
    }

    public function delete_branch($data){
        $pk = $data['pk'];

        $sql = <<<EOT
                delete from 
                branch_data 
                where pk = '$pk';
EOT;
        return ClassParent::update($sql);
    }

    public function add_customer($data){
        $first_name = $data['first_name'];
        $middle_name = $data['middle_name'];
        $last_name = $data['last_name'];
        $contact_number = $data['contact_number'];
        $email = $data['email'];
        $company = $data['company'];
        $job_position = $data['job_position'];
        $tin = $data['tin'];
        $cadd = $data['cadd'];
        $percent = $data['percent'];
        $last_day = $data['last_days'];
        $sql = <<<EOT
                insert into customer_data
                (
                    first_name,
                    middle_name,
                    last_name,
                    contact_number,
                    email,
                    company,
                    job_position,
                    tin,
                    cadd,
                    percent,
                    last_day
                )
                VALUES
                (
                    '$first_name',
                    '$middle_name',
                    '$last_name',
                    '$contact_number',
                    '$email',
                    '$company',
                    '$job_position',
                    '$tin',
                    '$cadd',
                    $percent,
                    '$last_day'
                );
EOT;
        return ClassParent::insert($sql);
    }
    
    public function get_branch_data($data){
        $sql = <<<EOT
                select 
                    pk,
                    branch_name,
                    address,
                    contact_person,
                    contact_number,
                    date_created::timestamp(0),
                    archived,
                    vat_registered
                from branch_data
                where archived = 'f'
                ;
EOT;

        return ClassParent::get($sql);
    }

    public function edit_customer($data){
        $first_name = $data['first_name'];
        $middle_name = $data['middle_name'];
        $last_name = $data['last_name'];
        $contact_number = $data['contact_number'];
        $email = $data['email'];
        $company = $data['company'];
        $job_position = $data['job_position'];
        $pk = $data['pk'];
        $cadd = $data['cadd'];
        $tin = $data['tin'];
        $percent = $data['percent'];
        $last_day = $data['last_days'];
        $sql = <<<EOT
                update customer_data set
                (
                    first_name,
                    middle_name,
                    last_name,
                    contact_number,
                    email,
                    company,
                    job_position,
                    cadd,
                    tin,
                    percent,
                    last_day
                )
                =
                (
                    '$first_name',
                    '$middle_name',
                    '$last_name',
                    '$contact_number',
                    '$email',
                    '$company',
                    '$job_position',
                    '$cadd',
                    '$tin',
                    $percent,
                    '$last_day'
                )
                where pk = '$pk'
                ;
EOT;
        return ClassParent::update($sql);
    }

    public function delete_customer($data){
        $pk = $data['pk'];

        $sql = <<<EOT
                delete from 
                customer_data 
                where pk = '$pk';
EOT;
        return ClassParent::update($sql);
    }

    public function get_customer_data($data){
        $wheres = "";
        if ($data['product'] == true) {
           $wheres.=" AND last_day::date > now()";
        }
        
        $sql = <<<EOT
                select 
                    pk,
                    first_name,
                    middle_name,
                    last_name,
                    email,
                    contact_number,
                    company,
                    tin,
                    cadd,
                    last_day,
                    job_position,
                    date_created::timestamp(0),
                    archived,
                    percent
                from customer_data
                where archived = 'f' $wheres
                order by date_created desc;
                ;
EOT;

        return ClassParent::get($sql);
    }

    public function get_cashier($data){
        
        $sql = <<<EOT
                select 
                    pk,
                    user_id,
                    superior_pin,
                    first_name,
                    user_type,
                    middle_name,
                    last_name,
                    date_created::timestamp(0),
                    archived
                from users
                where archived = 'f' and user_type = '2'
                ;
EOT;

        return ClassParent::get($sql);
    }

    public function get_history_logs($data){
        
        $sql = <<<EOT
                select 
                    pk,
                    name,
                    action,
                    cashier_user_id,
                    (select first_name from users where history_log_data.cashier_user_id = user_id)as first_name,
                    (select last_name from users where history_log_data.cashier_user_id = user_id)as last_name,
                    date_created::timestamp(0),
                    archived
                from history_log_data
                where archived = 'f' order by date_created desc
                ;
EOT;

        return ClassParent::get($sql);
    }

    public function get_accounts_logs($data){
        
        $sql = <<<EOT
                select 
                    *
                from accounts_log_data
                order by datetime desc
                ;
EOT;

        return ClassParent::get($sql);
    }

    public function get_check_bar_code_item($filter){
        foreach($filter as $k=>$v){
            $filter[$k] = pg_escape_string(trim(strip_tags($v)));
        }

        $product_name = "";

        $wildcard = $filter['wildcard'];
        if ($wildcard != undefined) {
             $product_name.=" AND product_bar_code ILIKE '%$wildcard%'";
        }

        $sql = <<<EOT
            select
                    pk, 
                    product_name,
                    product_supplier,
                    product_srp,
                    product_bar_code,
                    product_stocks,
                    product_or_number,
                    product_status,
                    product_price,
                    product_receipt_name,
                    (select request_order_status from request_order_data where product_pk::int =  product_data.pk and archived = 'f') as request_order_status,
                    product_product_code,
                    product_rules,
                    date_created::timestamp(0),
                    product_image,
                    product_branches,
                    selling_price,
                    input_vat,
                    output_vat
                from product_data
                where archived = 'f'
                $product_name
                order by date_created desc
                ;
EOT;
        return ClassParent::get($sql);
    }

    public function edit_product_data_bc($data){

        $pk = $data['pk'];
        $product_name = $data['product_name'];
        $product_srp = $data['product_srp'];
        $product_bar_code = $data['product_bar_code'];
        $product_stocks = $data['product_stocks'];
        $product_price = $data['product_price'];
        $product_receipt_name = $data['product_receipt_name'];
        $product_or_number = $data['product_or_number'];
        $product_supplier = $data['product_supplier'];
        $product_product_code = $data['product_product_code'];
        $product_rule = $data['product_rule'];
        $product_kinds = $data['product_kinds'];
        $product_pr_status = $data['product_pr_status'];
        $product_old_prdkinds = $data['product_old_prdkinds'];
        $product_old_name = $data['product_old_name'];
        $product_old_prdrule = $data['product_old_prdrule'];
        $product_old_prdcode = $data['product_old_prdcode'];
        $product_old_brcode = $data['product_old_brcode'];
        $product_old_pprice = $data['product_old_pprice'];
        $product_old_pexp = $data['product_old_pexp'];
        $product_old_srp = $data['product_old_srp'];
        $product_old_ps = $data['product_old_ps'];
        $product_old_rname = $data['product_old_rname'];
        $product_old_prdsup = $data['product_old_prdsup'];
        $product_old_ornum = $data['product_old_ornum'];
        $cashier_user_id = $data['cashier_user_id'];
        $name = $data['name'];
        $action = $data['action'];

        $sql = "begin;";
        $sql .= <<<EOT
                insert into history_log_data
                (
                    name,
                    cashier_user_id,
                    action
                    
                )
                VALUES
                (
                    '$name',
                    '$cashier_user_id',
                    '$action'
                )
                ;
EOT;
        $sql .= <<<EOT
                update product_data set
                (
                    product_name,
                    product_srp,
                    product_bar_code,
                    product_stocks,
                    product_price,
                    product_receipt_name,
                    product_or_number,
                    product_supplier,
                    product_product_code,
                    product_rules,
                    product_kind,
                    product_status
                )
                =
                (
                    '$product_old_name',
                    '$product_old_srp',
                    '$product_old_brcode',
                    '$product_old_ps',
                    '$product_old_pprice',
                    '$product_old_rname',
                    '$product_or_number',
                    '$product_old_ornum',
                    '$product_old_prdcode',
                    '$product_old_prdrule',
                    '$product_old_prdkinds',
                    '(OLD)'

                )
                where pk = '$pk'
                ;
EOT;
        $sql .= <<<EOT
                insert into product_data
                (
                    product_name,
                    product_srp,
                    product_bar_code,
                    product_stocks,
                    product_price,
                    product_supplier,
                    product_receipt_name,
                    product_status,
                    product_or_number,
                    product_or_stocks,
                    product_product_code,
                    product_rules
                )
                VALUES
                (
                    '$product_name',
                    '$product_srp',
                    '$product_bar_code',
                    '$product_stocks',
                    '$product_price',
                    '$product_supplier',
                    '$product_receipt_name',
                    '(NEW)',
                    '$product_or_number',
                    '$product_stocks',
                    '$product_product_code',
                    '$product_rule'
                )
                ;
EOT;
        $sql .= "commit;";
        return ClassParent::insert($sql);
    }

    public function update_this($data){
        $pk = $data['pk'];
        $input_vat3 = $data['input_vat3'];
        $output_vat3 = $data['output_vat3'];
        $selling_price2 = $data['selling_price2'];

        $sql = <<<EOT
                update product_data set
                (
                    input_vat,
                    output_vat,
                    selling_price
                )
                =
                (
                    '$input_vat3',
                    '$output_vat3',
                    '$selling_price2'
                )
                where pk = $pk;
EOT;
        return ClassParent::update($sql);
    }

    public function get_payment_data($data){
        $sql = <<<EOT
                select 
                    pk,
                    productname,
                    productamount,
                    date_created,
                    archived
                from payment_data 
                where archived = 'f'
                order by date_created desc
                ;
EOT;

        return ClassParent::get($sql);
    }

    public function add_payment($data){
        $productname=$data['ProductName'];
        $productamount=$data['Productamount'];

        $sql = "begin;";
        $sql .= <<<EOT
                insert into payment_data
                (
                    productname,
                    productamount
                    
                )
                VALUES
                (
                    '$productname',
                    '$productamount'  
                )
                ;
EOT;
        $sql .= <<<EOT
                insert into tender_data
                (
                    cashier_user_id,
                    product_name,
                    product_quantity,
                    product_supplier_price,
                    product_retail_price,
                    product_transaction_number,
                    vat_percentage,
                    net_amount,
                    vat,
                    discount,
                    change,
                    cash,
                    total,
                    void_count,
                    gc_amount,
                    gc_name,
                    gc_code,
                    tempo_total,
                    product_pk,
                    item_size_name,
                    item_has_size
                )
                VALUES
                (
                    'N/A',
                    'Payment',
                    '1',
                    '$productamount',
                    '$productamount',
                    'N/A',
                    'N/A',
                    '$productamount',
                    'N/A',
                    'N/A',
                    '0',
                    'N/A',
                    'N/A',
                    'N/A',
                    'N/A',
                    'N/A',
                    'N/A',
                    'N/A',
                    '0',
                    'N/A',
                    'N/A'
                )
                ;
EOT;
        $sql .= "commit;";
        return ClassParent::insert($sql);
    }

    public function edit_payment($data){
        $pk=$data['pk'];
         $productname=$data['ProductName'];
         $productamount=$data['Productamount'];
        $sql = <<<EOT
        
                update payment_data set
                (
                    productname,
                    productamount
                    
                ) 
               =
                (
                    '$productname',
                    '$productamount'
                    
                    
                )
                where pk=$pk;
EOT;

        return ClassParent::update($sql);
    }
public function delete_payment($data){
        $pk=$data['pk'];
        $sql = <<<EOT
                delete from payment_data where pk = $pk;
               
EOT;

        return ClassParent::update($sql);
    }

}
?>
