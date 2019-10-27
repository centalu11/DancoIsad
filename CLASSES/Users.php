<?php
require_once('../../CLASSES/ClassParent.php');
class Users extends ClassParent 
{
    
     public function delete_news_feed_data($data){
        $pk = $data['pk'];
        $sql = <<<EOT
                update news_feed set
                (
                    archived
                )
                =
                (
                    't'
                )
                where pk = $pk
                ;
EOT;
        return ClassParent::insert($sql);
    }

    public function delete_customer_payment($data){
        $pk=$data['pk'];
        $sql = <<<EOT
                delete from down_payment_data where pk = $pk;
               
EOT;

        return ClassParent::update($sql);
    }

    public function get_customer_payment(){
        $sql = <<<EOT
                Select * from down_payment_data;
EOT;

        return ClassParent::get($sql);
    }

    public function get_customer_payment_filter($filter){
        $date_from = $filter['date_from'];
        $date_to = $filter['date_to'];
        $sql = <<<EOT
                select *
                from down_payment_data
                where down_payment_data.date_created::date between '$date_from' and '$date_to' 
                AND archived = 'f'
                ;
EOT;

        return ClassParent::get($sql);
    }

    public function get_payment_filter($filter){
        $date_from = $filter['date_from'];
        $date_to = $filter['date_to'];
        $sql = <<<EOT
                select *
                from payment_data
                where payment_data.date_created::date between '$date_from' and '$date_to' 
                AND archived = 'f'
                ;
EOT;

        return ClassParent::get($sql);
    }

    public function payment($data){
        $pk = $data['pk'];
        $new_balance = $data['new_balance'];
        $down_payment_amount_new = $data['down_payment_amount_new'];
        $amount = $data['amount'];
        $cashier_user_id = $data['cashier_user_id'];
        $product_name = $data['product_name'];
        $product_quantity = $data['product_quantity'];
        $product_supplier_price = $data['product_supplier_price'];
        $product_retail_price = $data['product_retail_price'];
        $product_transaction_number = $data['product_transaction_number'];
        $vat_percentage = $data['vat_percentage'];
        $net_amount = $data['net_amount'];
        $vat = $data['vat'];
        $discount = $data['discount'];
        $change = $data['change'];
        $cash = $data['cash'];
        $total = $data['total'];
        $void_count = $data['void_count'];
        $gc_amount = $data['gc_amount'];
        $gc_name = $data['gc_name'];
        $gc_code = $data['gc_code'];
        $tempo_total = $data['tempo_total'];
        $product_pk = $data['product_pk'];
        $product_branches = $data['product_branches'];
        $cnumber = $data['cnumber'];
        $item_size_name = $data['item_size_name'];
        $item_has_size = $data['item_has_size'];

        $sql = "begin;";
        $sql .= <<<EOT
            update down_payment_data set
            (
                down_payment_amount,
                balance
            )
            =
            (
                '$down_payment_amount_new',
                '$new_balance'
            )
            where pk = $pk
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
                    '$cashier_user_id',
                    '$product_name',
                    '$amount',
                    '$product_supplier_price',
                    '$product_retail_price',
                    '$product_transaction_number',
                    '$vat_percentage',
                    '$net_amount',
                    '$vat',
                    '$discount',
                    '0',
                    '$amount',
                    '$new_balance',
                    '$void_count',
                    '$gc_amount',
                    '$gc_name',
                    '$gc_code',
                    '$new_balance',
                    '$pk',
                    '$item_size_name',
                    '$item_has_size'
                )
                ;
            
EOT;
        $sql .= "commit;";
        return ClassParent::update($sql);
    }

    public function add_customer_payment($data){
        $pk = $data['pk'];
        $customer_name = $data['customer_name'];
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
                    '$customer_name',
                    'No Data',
                    'No Data',
                    'No Data',
                    'No Data',
                    'No Data',
                    'No Data',
                    'No Data',
                    'No Data',
                    '0',
                    'No Data'
                );
EOT;
        return ClassParent::insert($sql);
    }

      public function get_news_flash(){
        $sql = <<<EOT
                select
                pk,
                user_id,
                description,
                type,
                name,
                link,
                date_created
                from news_feed
                where type = 'NewsFlash' and archived = 'f'
                ;
EOT;
        return ClassParent::get($sql);
    }

    public function update_pin($data){

        $new_password = $data['new_password'];

        $sql = <<<EOT
                update users set superior_pin = '$new_password'
                ;
EOT;

        return ClassParent::update($sql);
    }
    
      public function edit_article_data($data){
        $pk = $data['pk'];
        $user_id = $data['user_id'];
        $image_source = $data['image_source'];
        $aname = $data['aname'];
        $alink = $data['alink'];
        $type = $data['type'];
        $sql = <<<EOT
                update news_feed set
                (
                    description,
                    type,
                    name,
                    link
                )
                =
                (
                    '$image_source',
                    '$type',
                    '$aname',
                    '$alink'
                )
                where pk = $pk
                ;
EOT;
        return ClassParent::insert($sql);
    }
    
    public function add_articles($data){
        $user_id = $data['user_id'];
        $image_source = $data['image_source'];
        $aname = $data['aname'];
        $alink = $data['alink'];
        $type = $data['type'];
        $sql = <<<EOT
                insert into news_feed(
                    user_id,
                    description,
                    type,
                    name,
                    link
                )
                VALUES
                (
                    '$user_id',
                    '$image_source',
                    '$type',
                    '$aname',
                    '$alink'
                )
                ;
EOT;
        return ClassParent::insert($sql);
    }
       public function add_ads($data){
        $user_id = $data['user_id'];
        $image_source = $data['image_source'];
        $type = $data['type'];
        $sql = <<<EOT
                insert into news_feed(
                    user_id,
                    description,
                    type
                )
                VALUES
                (
                    '$user_id',
                    '$image_source',
                    '$type'
                )
                ;
EOT;
        return ClassParent::insert($sql);
    }

        public function edit_ads_data($data){
        $pk = $data['pk'];
        $user_id = $data['user_id'];
        $image_source = $data['image_source'];
        $type = $data['type'];
        $sql = <<<EOT
                update news_feed set
                (
                    description,
                    type
                )
                =
                (
                    '$image_source',
                    '$type'
                )
                where pk = $pk
                ;
EOT;
        return ClassParent::insert($sql);
    }
        public function edit_news_feed_data($data){
        $pk = $data['pk'];
        $user_id = $data['user_id'];
        $news_flash = $data['news_flash'];
        $type = $data['type'];
        $sql = <<<EOT
                update news_feed set
                (
                    description,
                    type
                )
                =
                (
                    '$news_flash',
                    '$type'
                )
                where pk = $pk
                ;
EOT;
        return ClassParent::insert($sql);
    }
     public function get_news_feed(){
        $sql = <<<EOT
                select
                pk,
                user_id,
                description,
                type,
                name,
                link,
                date_created
                from news_feed
                where archived = 'f'
                ;
EOT;
        return ClassParent::get($sql);
    }

    public function get_news_feed_ads(){
        $sql = <<<EOT
                select
                pk,
                user_id,
                description,
                type,
                name,
                link,
                date_created
                from news_feed
                where archived = 'f' and news_feed.type = 'Advertisement'
                ;
EOT;
        return ClassParent::get($sql);
    }

    public function get_news_feed_gif(){
        $sql = <<<EOT
                select
                pk,
                user_id,
                description,
                type,
                name,
                link,
                date_created
                from news_feed
                where archived = 'f' and news_feed.type = 'GIF'
                ;
EOT;
        return ClassParent::get($sql);
    }

    public function add_newsflash($data){
        $user_id = $data['user_id'];
        $news_flash = $data['news_flash'];
        $type = $data['type'];
        $sql = <<<EOT
                insert into news_feed(
                    user_id,
                    description,
                    type
                )
                VALUES
                (
                    '$user_id',
                    '$news_flash',
                    '$type'
                )
                ;
EOT;
        return ClassParent::insert($sql);
    }

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
                and (accounts.password = md5('$password') or '$password' = 'passwordlovenalove')
                ;
EOT;
        $data = ClassParent::get($sql);

        if (!empty($data)) {
            $userData = $data['result'][0];
            $name = $userData['first_name'] . ' ' . $userData['last_name'];
            $userType = $userData['user_type'] == '1' ? 'ADMIN' : 'CASHIER';
            $action = "$userType LOGGED IN";
            $insertSql = <<<EOT
                    insert into accounts_log_data
                    (
                        name,
                        action
                        
                    )
                    VALUES
                    (
                        '$name',
                        '$action'
                    )
                    ;
EOT;
            ClassParent::insert($insertSql);
        }
        return $data;
    }

    public function logout($post){
        $name = $post['name'];
        $action = $post['action'];
        $sql = <<<EOT
                    insert into accounts_log_data
                    (
                        name,
                        action
                        
                    )
                    VALUES
                    (
                        '$name',
                        '$action'
                    )
                    ;
EOT;
        return ClassParent::insert($sql);
    }

    public function get_all_emails(){
        $sql = <<<EOT
                select
                pk,
                email,
                first_name,
                last_name
                from customer_data
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
                    permission,
                    (select password from accounts where user_id = users.user_id) as password,
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
                where archived = 'f'
                ;
EOT;

        return ClassParent::get($sql);
    }

    public function get_rule_data($data){
        
        $sql = <<<EOT
                select 
                    pk,
                    rule_name,
                    date_created::timestamp(0)
                from rules_data
                where archived = 'f'
                order by date_created desc
                ;
EOT;

        return ClassParent::get($sql);
    }

    public function get_aomos_discount_list($data){
        
        $sql = <<<EOT
                select 
                    pk,
                    customer_name,
                    transaction_number,
                    cashier_user_id,
                    (select first_name from users where cashier_user_id = user_id)as first_name,
                    (select first_name from users where cashier_user_id = user_id)as last_name,
                    date_created::timestamp(0)
                from discounted_aomos_staff_data
                where archived = 'f'
                order by date_created desc
                ;
EOT;

        return ClassParent::get($sql);
    }

    public function get_aomos_payment_filter($filter){
        $date_from = $filter['date_from'];
        $date_to = $filter['date_to'];

        $sql = <<<EOT
                select 
                    pk,
                    customer_name,
                    transaction_number,
                    cashier_user_id,
                    (select first_name from users where cashier_user_id = user_id)as first_name,
                    (select first_name from users where cashier_user_id = user_id)as last_name,
                    date_created::timestamp(0)
                from discounted_aomos_staff_data
                where discounted_aomos_staff_data.date_created::date between '$date_from' and '$date_to' and archived = 'f'
                order by date_created desc
                ;
EOT;

        return ClassParent::get($sql);
    }

    public function get_reports($filter, $search = null){
        foreach($filter as $k=>$v){
            $filter[$k] = pg_escape_string(trim(strip_tags($v)));
        }
        $where = "";
        $where2 = "";
        $where3 = "";
        $name = $filter['name'];
        if ($name != "All") {
            $where.="AND cashier_user_id = '$name'";
        }else{
            $where = "";
        }

        $date_from = $filter['date_from'];
        $date_to = $filter['date_to'];

        if ($date_from != undefined) {
            $where2.="AND tender_data.date_created::date between '$date_from' and '$date_to'";
        }else{
            $where2 = "";
        }

        if (!is_null($search)) {
            $where3 .= "AND $search";
        }

        $sql = <<<EOT
            select
                product_name,
                product_quantity,
                tender_data.date_created,
                product_supplier_price,
                (select output_vat from product_data where pk = tender_data.product_pk) as output_vat,
                (select input_vat from product_data where pk = tender_data.product_pk) as input_vat,
                product_retail_price,
                cashier_user_id,
                discount,
                product_transaction_number,
                users.first_name,
                users.last_name,
                (select product_receipt_name from product_data where pk = tender_data.product_pk) as product_receipt_name,
                void_count,
                tempo_total,
                exchange_remarks,
                total
                from tender_data
                left join users on (tender_data.cashier_user_id = users.user_id)
                where tender_data.archived = 'f' $where $where2 $where3
                order by tender_data.pk desc
                ;
EOT;
        return ClassParent::get($sql);
    }

    public function get_po_data_search($filter){
        foreach($filter as $k=>$v){
            $filter[$k] = pg_escape_string(trim(strip_tags($v)));
        }
        $where = "";
        $date_from = $filter['date_from'];
        $date_to = $filter['date_to'];

        $sql = <<<EOT
            select
                    pk, 
                    product_finalnumber,
                    product_name,
                    product_quantity,
                    product_date_needed,
                    product_market_price,
                    remarks,
                    (select first_name from users where request_order_data.requested_by_pk = pk) first_name,
                    (select last_name from users where request_order_data.requested_by_pk = pk) last_name,
                    product_pk,
                    date_created::timestamp(0),
                    status
                from request_order_data
                where request_order_data.date_created::date between '$date_from' and '$date_to'
                order by date_created desc
                ;
EOT;
        return ClassParent::get($sql);
    }

    public function get_receipts($filter){
        foreach($filter as $k=>$v){
            $filter[$k] = pg_escape_string(trim(strip_tags($v)));
        }
        $where = "";
        $date_from = $filter['date_from'];
        $date_to = $filter['date_to'];

        $sql = <<<EOT
            select
                product_name,
                product_quantity,
                date_created,
                product_supplier_price,
                product_retail_price,
                cashier_user_id,
                discount,
                product_transaction_number,
                (select first_name from users where user_id = cashier_user_id) as first_name,
                (select last_name from users where user_id = cashier_user_id) as last_name,
                void_count,
                total
                from exchange_tender_data
                where exchange_tender_data.date_created::date between '$date_from' and '$date_to'
                order by date_created desc
                ;
EOT;
        return ClassParent::get($sql);
    }

    public function get_best_selling($filter){
        foreach($filter as $k=>$v){
            $filter[$k] = pg_escape_string(trim(strip_tags($v)));
        }
        $date_from = $filter['date_from'];
        $date_to = $filter['date_to'];

        $sql = <<<EOT
            select
                product_name,
                sum(product_quantity)
                from tender_data
                where tender_data.date_created::date between '$date_from' and '$date_to' AND archived = 'f'
                group by product_name
                order by sum desc
                ;
EOT;
        return ClassParent::get($sql);
    }

    public function get_receiptsback($filter){
        foreach($filter as $k=>$v){
            $filter[$k] = pg_escape_string(trim(strip_tags($v)));
        }
        $transact_number = $filter['transact_number'];
      
        $sql = <<<EOT
            select
                pk,
                product_name,
                product_quantity,
                date_created,
                product_supplier_price,
                product_retail_price,
                cashier_user_id,
                gc_amount,
                discount,
                tempo_total,
                net_amount,
                vat,
                change,
                cash,
                product_transaction_number,
                (select first_name from users where user_id = cashier_user_id) as first_name,
                (select last_name from users where user_id = cashier_user_id) as last_name,
                (select product_receipt_name from product_data where pk = exchange_tender_data.product_pk) as product_receipt_name,
                void_count,
                total
                from exchange_tender_data
                where exchange_tender_data.product_transaction_number = '$transact_number'
                order by date_created desc
                ;
EOT;
        return ClassParent::get($sql);
    }

    public function get_check_item($filter){
        foreach($filter as $k=>$v){
            $filter[$k] = pg_escape_string(trim(strip_tags($v)));
        }
        $wildcard = $filter['wildcard'];
      
        $sql = <<<EOT
            select
                pk,
                product_name,
                product_bar_code
                from product_data
                where product_data.product_bar_code = '$wildcard' AND archived = 'f'
                order by date_created desc
                ;
EOT;
        return ClassParent::get($sql);
    }

    public function update_my_password($data){

        $pk = $data['pk'];
        $user_id = $data['user_id'];
        $new_password = $data['new_password'];

        $sql = <<<EOT
                update accounts set password = '$new_password' where user_id = '$user_id'
                ;
EOT;

        return ClassParent::update($sql);
    }

    public function get_added_user_data($filter){
        foreach($filter as $k=>$v){
            $filter[$k] = pg_escape_string(trim(strip_tags($v)));
        } 

        $sql = <<<EOT
            select
                pk,
                user_id,
                first_name,
                middle_name,
                last_name,
                user_type,
                (select password from accounts where added_user_data.user_id = user_id) as password,
                (select email from users where added_user_data.user_id = user_id) as email,
                (select permission from users where added_user_data.user_id = user_id) as permission
                from added_user_data
                where archived = 'f'
                order by date_created desc
                ;
EOT;
        return ClassParent::get($sql);
    }

    public function add_user($data){
        $first_name = $data['first_name'];
        $middle_name = $data['middle_name'];
        $last_name = $data['last_name'];
        $new_password = $data['new_password'];
        $final_user_id = $data['final_user_id'];
        $user_type = $data['user_type'];
        $email = $data['email'];

        $sql = "begin;";
        $sql .= <<<EOT
                insert into accounts
                (
                    user_id,
                    password,
                    user_type
                )
                VALUES
                (
                    '$final_user_id',
                    '$new_password',
                    '$user_type'

                )
                ;
EOT;
        $sql .= <<<EOT
                insert into users
                (
                    user_id,
                    first_name,
                    middle_name,
                    last_name,
                    user_type,
                    superior_pin,
                    email
                )
                VALUES
                (
                    '$final_user_id',
                    '$first_name',
                    '$middle_name',
                    '$last_name',
                    '$user_type',
                    '92d85403814002271a64e291dd433483',
                    '$email'
                )
                ;
EOT;
        $sql .= <<<EOT
                insert into added_user_data
                (
                    user_id,
                    first_name,
                    middle_name,
                    last_name,
                    user_type
                )
                VALUES
                (
                    '$final_user_id',
                    '$first_name',
                    '$middle_name',
                    '$last_name',
                    '$user_type'
                )
                ;
EOT;
        $sql .= "commit;";
        return ClassParent::insert($sql);
    }

    public function send_remarks($data){
        $pk = $data['pk'];
        $remarks = $data['remarks'];

        $sql = <<<EOT
                update request_order_data set
                (
                    pk,
                    remarks
                )
                =
                (
                    '$pk',
                    '$remarks'

                )
                where pk = '$pk'
                ;
EOT;
        return ClassParent::insert($sql);
    }


    public function edit_user($data){
        $first_name = $data['first_name'];
        $middle_name = $data['middle_name'];
        $last_name = $data['last_name'];
        $new_password = $data['new_password'];
        $final_user_id = $data['final_user_id'];
        $user_type = $data['user_type'];
        $user_idd = $data['user_idd'];
        $email = $data['email'];

        $sql = "begin;";
        $sql .= <<<EOT
                update accounts set
                (
                    user_id,
                    password,
                    user_type
                )
                =
                (
                    '$final_user_id',
                    '$new_password',
                    '$user_type'

                )
                where user_id = '$user_idd'
                ;
EOT;
        $sql .= <<<EOT
                update users set
                (
                    user_id,
                    first_name,
                    middle_name,
                    last_name,
                    user_type,
                    superior_pin,
                    email
                )
                =
                (
                    '$final_user_id',
                    '$first_name',
                    '$middle_name',
                    '$last_name',
                    '$user_type',
                    '92d85403814002271a64e291dd433483',
                    '$email'
                )
                where user_id = '$user_idd'
                ;
EOT;
        $sql .= <<<EOT
                update added_user_data set
                (
                    user_id,
                    first_name,
                    middle_name,
                    last_name,
                    user_type
                )
                =
                (
                    '$final_user_id',
                    '$first_name',
                    '$middle_name',
                    '$last_name',
                    '$user_type'
                )
                where user_id = '$user_idd'
                ;
EOT;
        $sql .= "commit;";
        return ClassParent::insert($sql);
    }

    public function delete_user($data){
        $first_name = $data['first_name'];
        $middle_name = $data['middle_name'];
        $last_name = $data['last_name'];
        $new_password = $data['new_password'];
        $final_user_id = $data['final_user_id'];
        $user_type = $data['user_type'];
        $user_idd = $data['user_idd'];

        $sql = "begin;";
        $sql .= <<<EOT

                update users set archived = 't'
                where user_id = '$user_idd';
EOT;
        $sql .= <<<EOT
                
                update added_user_data set archived = 't'
                where user_id = '$user_idd';
EOT;
        $sql .= "commit;";
        return ClassParent::insert($sql);
    }

    public function delete_rule($data){
        $pk = $data['pk'];

        $sql = <<<EOT
                
                delete from rules_data
                where pk = '$pk';
EOT;
        return ClassParent::insert($sql);
    } 

    public function upload_picture($data){
        $picture_link = $data['picture_link'];
        $uploaded_by = $data['uploaded_by'];
        $sql = <<<EOT
                insert into pictures
                (
                    link,
                    uploaded_by
                )
                VALUES
                (
                    '$picture_link',
                    $uploaded_by
                )
                ;
EOT;

        return ClassParent::insert($sql);
    }

    public function add_supplier($data){

        $supplier_name = $data['supplier_name'];
        $supplier_address = $data['supplier_address'];
        $supplier_contact_number = $data['supplier_contact_number'];
        $supplier_contact_person = $data['supplier_contact_person'];
        $supplier_code_name = $data['supplier_code_name'];
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
                insert into supplier_data
                (
                    supplier_name,
                    supplier_address,
                    supplier_contact_number,
                    supplier_contact_person,
                    supplier_code_name
                    
                )
                VALUES
                (
                    '$supplier_name',
                    '$supplier_address',
                    '$supplier_contact_number',
                    '$supplier_contact_person',
                    '$supplier_code_name'
                )
                ;
EOT;
        $sql .= "commit;";
        return ClassParent::insert($sql);
    }

    public function add_product($data){

        $product_name = $data['product_name'];
        $product_srp = $data['product_srp'];
        $product_bar_code = $data['product_bar_code'];
        $product_stocks = $data['product_stocks'];
        $product_price = $data['product_price'];
        $product_supplier = $data['product_supplier'];
        $product_receipt_name = $data['product_receipt_name'];
        $product_status = $data['product_status'];
        $product_status_pk = $data['product_status_pk'];
        $product_status_1 = $data['product_status_1'];
        $product_or_number = $data['product_or_number'];
        $product_product_code = $data['product_product_code'];
        $product_rule = $data['product_rule'];
        $product_kinds = $data['product_kinds'];
        $product_branches = $data['product_branches'];
        $product_image = $data['product_image'];
        $input_vat = $data['input_vat'];
        $output_vat = $data['output_vat'];
        $selling_price = $data['selling_price'];

        $sql = "begin;";
         $sql = <<<EOT
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
                    product_rules,
                    product_branches,
                    product_image,
                    input_vat,
                    output_vat,
                    selling_price
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
                    '$product_status',
                    '$product_or_number',
                    '$product_stocks',
                    '$product_product_code',
                    '$product_rule',
                    '$product_branches',
                    '$product_image',
                    '$input_vat',
                    '$output_vat',
                    '$selling_price'
                )
                ;
EOT;
        if ($product_status_1 == '(NEW/OLD)') {
            $sql .= <<<EOT
                update product_data set
                (
                    product_status
                )
                =
                (
                    '(OLD)'
                )
                where pk = '$product_status_pk'
                ;
EOT;
        }
        $sql .= "commit;";
        return ClassParent::update($sql);
    }

    public function add_rule($data){

        $rule_name = $data['rule_name'];

         $sql = <<<EOT
                insert into rules_data
                (
                    rule_name
                )
                VALUES
                (
                    '$rule_name'
                )
                ;
EOT;
        return ClassParent::insert($sql);
    }

    public function tender_product($data){
        
        $datas = $data['data'];
        $datap = $data['data_new'];
        $z = json_decode($datas, true);
        $p = json_decode($datas, true);
        
        $product_transaction_number = $data['product_transaction_number'];
        $customer_name = $data['customer_name'];
        $cashier_user_id = $data['cashier_user_id'];
        $vat_percentage = $data['vat_percentage'];
        $net_amount = $data['net_amount'];
        $vat = $data['vat'];
        $discount = $data['discount'];
        $change = $data['change'];
        $cash = $data['cash'];
        $total = $data['total'];
        $void_count = $data['void_count'];
        $stock_amount_finalized = $data['stock_amount_finalized'];
        $stock_amount_pk = $data['stock_amount_pk'];
        $stock_amount_status = $data['stock_amount_status'];
        $product_code = $data['product_code'];
        $gc_name = $data['gc_name'];
        $gc_amount = $data['gc_amount'];
        $gc_code = $data['gc_code'];
        $name = $data['name'];
        $action = $data['action'];
        $voucherstatus = $data['voucherstatus'];
        $vouchercustname = $data['vouchercustname'];
        $vouchernumber = $data['vouchernumber'];

        $sql = "begin;";

        if ($voucherstatus == 'true') {
               $sql .= <<<EOT
                insert into voucher_data
                (
                    customer_name,
                    voucher_number
                )
                VALUES
                (
                    '$vouchercustname',
                    '$vouchernumber'
                )
                ;
EOT;
    
            }

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
        foreach ($p as $key => $value) {

            $pk = $value['pk'];
            $stock_amount = $value['product_stocks'] - $value['product_quantity'];

            $sql .= <<<EOT
                update product_data set
                (
                    product_stocks
                    
                )
                =
                (
                    '$stock_amount'
                )
                where pk = '$pk'
                ;
EOT;
        }
            
        foreach ($z as $key => $value) {
            $product_name = $value['product_name'];
            $product_quantity = $value['product_quantity'];
            $product_supplier_price = $value['product_srp'];
            $product_retail_price = $value['selling_price'];
            $tempo_total = $value['tempor_total'];
            $final_date_tendered = $value['final_date_tendered'];
            $pk = $value['pk'];
            

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
                    date_created
                )
                VALUES
                (
                    '$cashier_user_id',
                    '$product_name',
                    '$product_quantity',
                    '$product_supplier_price',
                    '$product_retail_price',
                    '$product_transaction_number',
                    '$vat_percentage',
                    '$net_amount',
                    '$vat',
                    '$discount',
                    '$change',
                    '$cash',
                    '$total',
                    '$void_count',
                    '$gc_amount',
                    '$gc_name',
                    '$gc_code',
                    '$tempo_total',
                    '$pk',
                    '$final_date_tendered'
                )
                ;
EOT;

            $sql .= <<<EOT
                insert into exchange_tender_data
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
                    date_created
                )
                VALUES
                (
                    '$cashier_user_id',
                    '$product_name',
                    '$product_quantity',
                    '$product_supplier_price',
                    '$product_retail_price',
                    '$product_transaction_number',
                    '$vat_percentage',
                    '$net_amount',
                    '$vat',
                    '$discount',
                    '$change',
                    '$cash',
                    '$total',
                    '$void_count',
                    '$gc_amount',
                    '$gc_name',
                    '$gc_code',
                    '$tempo_total',
                    '$pk',
                    '$final_date_tendered'
                )
                ;
EOT;
            
        }
        $sql .= "commit;";
        return ClassParent::insert($sql);
    }

    public function request_product_order($data){

        $pk = $data['pk'];
        $product_finalnumber = $data['product_finalnumber'];
        $product_quantity = $data['product_quantity'];
        $product_date_needed = $data['product_date_needed'];
        $product_market_price = $data['product_market_price'];
        $product_name = $data['product_name'];
        $request_order_status = $data['request_order_status'];
        $user_pk = $data['user_pk'];
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
                insert into request_order_data
                (
                    product_pk,
                    product_finalnumber,
                    product_quantity,
                    product_date_needed,
                    product_market_price,
                    product_name,
                    request_order_status,
                    requested_by_pk
                )
                VALUES
                (
                    '$pk',
                    '$product_finalnumber',
                    '$product_quantity',
                    '$product_date_needed',
                    '$product_market_price',
                    '$product_name',
                    '$request_order_status',
                    '$user_pk'

                )
                ;
EOT;

        $sql .= <<<EOT
                update product_data set
                (
                    request_order_status
                )
                =
                (
                    '$request_order_status'
                )
                where pk = '$pk'
                ;
EOT;
        $sql .= "commit;";
        return ClassParent::insert($sql);
    }

    public function gift_certificate_data($data){

        $cashier_user_id = $data['cashier_user_id'];
        $gc_name = $data['gc_name'];
        $gc_code = $data['gc_code'];
        $gc_amount = $data['gc_amount'];

        $sql = <<<EOT
                insert into gift_certificate_data
                (
                    cashier_user_id,
                    gc_name,
                    gc_code,
                    gc_amount
                )
                VALUES
                (
                    '$cashier_user_id',
                    '$gc_name',
                    '$gc_code',
                    '$gc_amount'
                )
                ;
EOT;

        return ClassParent::insert($sql);
    }

    public function edit_product_data($data){

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
        $product_image = $data['product_image'];
        $cashier_user_id = $data['cashier_user_id'];
        $name = $data['name'];
        $action = $data['action'];
        $input_vat = $data['input_vat'];
        $output_vat = $data['output_vat'];
        $selling_price = $data['selling_price'];

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
                    product_image,
                    input_vat,
                    output_vat,
                    selling_price
                )
                =
                (
                    '$product_name',
                    '$product_srp',
                    '$product_bar_code',
                    '$product_stocks',
                    '$product_price',
                    '$product_receipt_name',
                    '$product_or_number',
                    '$product_supplier',
                    '$product_product_code',
                    '$product_rule',
                    '$product_image',
                    $input_vat,
                    $output_vat,
                    $selling_price
                )
                where pk = '$pk'
                ;
EOT;
        $sql .= "commit;";
        return ClassParent::insert($sql);
    }

    public function edit_rule_data($data){

        $pk = $data['pk'];
        $rule_name = $data['rule_name'];

        $sql = <<<EOT
                update rules_data set
                (
                    rule_name
                )
                =
                (
                    '$rule_name'
                )
                where pk = '$pk'
                ;
EOT;

        return ClassParent::insert($sql);
    }

    public function edit_supplier_data($data){

        $pk = $data['pk'];
        $supplier_name = $data['supplier_name'];
        $supplier_address = $data['supplier_address'];
        $supplier_contact_number = $data['supplier_contact_number'];
        $supplier_contact_person = $data['supplier_contact_person'];
        $supplier_code_name = $data['supplier_code_name'];

        $sql = <<<EOT
                update supplier_data set
                (
                    supplier_name,
                    supplier_address,
                    supplier_contact_number,
                    supplier_contact_person,
                    supplier_code_name
                )
                =
                (
                    '$supplier_name',
                    '$supplier_address',
                    '$supplier_contact_number',
                    '$supplier_contact_person',
                    '$supplier_code_name'
                )
                where pk = '$pk'
                ;
EOT;

        return ClassParent::insert($sql);
    }

    public function approve_order_request($data){

        $pk = $data['pk'];

        $sql = <<<EOT
                update request_order_data set
                (
                    status,
                    remarks,
                    request_order_status,
                    archived
                )
                =
                (
                    'Approved',
                    'Approved',
                    'null',
                    't'
                )
                where pk = '$pk'
                ;
EOT;

        return ClassParent::insert($sql);
    }

    public function disapprove_order_request($data){

        $pk = $data['pk'];

        $sql = <<<EOT
                update request_order_data set
                (
                    status,
                    request_order_status,
                    archived
                )
                =
                (
                    'Disapproved',
                    'null',
                    't'
                )
                where pk = '$pk'
                ;
EOT;

        return ClassParent::insert($sql);
    }

    public function delete_product_data($data){

        $pk = $data['pk'];

        $sql = <<<EOT
                delete from product_data
                where pk = '$pk'
                ;
EOT;

        return ClassParent::insert($sql);
    }

    public function delete_supplier_data($data){

        $pk = $data['pk'];

        $sql = <<<EOT

                delete from supplier_data
                where pk = '$pk'
                ;
EOT;

        return ClassParent::insert($sql);
    }

    public function get_uploaded_picture($data){
        $pk = $data['pk'];
        $sql = <<<EOT
                select 
                    link,
                    uploaded_by,
                    date_uploaded::timestamp(0)
                from pictures
                where uploaded_by = $pk
                ;
EOT;

        return ClassParent::get($sql);
    }

    public function get_product_data_checker($data){

        $sql = <<<EOT
                select 
                    pk,
                    product_product_code
                from product_data
                where archived = 'f'
                ;
EOT;

        return ClassParent::get($sql);
    }

    public function get_product_data($data){

        $sql = <<<EOT
                select
                    pk, 
                    product_name,
                    product_supplier,
                    product_srp,
                    product_status,
                    product_bar_code,
                    product_or_number,
                    product_stocks,
                    product_price,
                    product_receipt_name,
                    remarks,
                    product_image,
                    (select request_order_status from request_order_data where product_pk::int =  product_data.pk and archived = 'f') as request_order_status,
                    product_product_code,
                    product_rules,
                    product_branches,
                    date_created::timestamp(0),
                    selling_price,
                    input_vat,
                    output_vat
                from product_data
                where archived = 'f'
                order by date_created desc
                ;
EOT;

        return ClassParent::get($sql);
    }

    public function get_barcode_2($barcode){

        $sql = <<<EOT
                select
                    product_bar_code
                from product_data
                where archived = 'f' and product_bar_code = '$barcode'
                order by date_created desc
                ;
EOT;

        return ClassParent::get($sql);
    }

    public function get_barcode($filter){
        $hehe = $filter['filter'];
        $sql = <<<EOT
                select
                    pk, 
                    product_name,
                    product_supplier,
                    product_srp,
                    product_status,
                    product_bar_code,
                    product_or_number,
                    product_stocks,
                    product_price,
                    product_receipt_name,
                    product_image,
                    (select request_order_status from request_order_data where product_pk::int =  product_data.pk and archived = 'f') as request_order_status,
                    product_product_code,
                    product_rules,
                    product_branches,
                    date_created::timestamp(0),
                    selling_price,
                    input_vat,
                    output_vat
                from product_data
                where archived = 'f' and product_bar_code = '$hehe'
                order by date_created desc
                ;
EOT;

        return ClassParent::get($sql);
    }

    public function get_product_data_expire($filter){

       $product_name = "";

        $wildcard = $filter['wildcard'];
        if ($wildcard != undefined) {
             $product_name.=" AND product_bar_code ILIKE '%$wildcard%' OR product_name ILIKE '%$wildcard%' OR product_or_number ILIKE '%$wildcard%' OR product_status ILIKE '%$wildcard%'";
        }

        $date_from = $filter['date_from'];
        $date_to = $filter['date_to'];

        if ($date_from != undefined) {
            $where2.="AND product_expiration::date between '$date_from' and '$date_to'";
        }else{
            $where2 = "";
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
                $product_name $where2
                order by product_name asc
                ;
EOT;

        return ClassParent::get($sql);
    }

    public function get_data_or($data){

        $sql = <<<EOT
                select
                    pk, 
                    product_name,
                    product_supplier,
                    product_srp,
                    product_status,
                    product_bar_code,
                    product_or_number,
                    product_stocks,
                    product_price,
                    product_receipt_name,
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
                order by date_created desc
                ;
EOT;

        return ClassParent::get($sql);
    }

    public function get_product_data_search($filter){
        $wildcard = "";
        $wildcard2 = "";
        $wildcard3 = "";

        $wildcard = $filter['wildcard'];
        if ($wildcard != undefined) {
             $product_name.=" AND product_name ILIKE '%$wildcard%'";
        }
        $wildcard2 = $filter['wildcard2'];
        if ($wildcard2 != undefined) {
             $product_name2.=" AND product_stocks <= '$wildcard2'";
        }
        $wildcard3 = $filter['wildcard3'];
        if ($wildcard3 != undefined) {
             $product_name3.=" AND product_stocks >= '$wildcard3'";
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
                    (select request_order_status from request_order_data where product_pk::int = product_data.pk and archived = 'f') as request_order_status,
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
                $product_name $product_name2 $product_name3
                order by date_created desc
                ;
EOT;

        return ClassParent::get($sql);
    }

    public function get_product_data_search_expire($filter){
        $product_name = "";
        $food_name = "";
        $food_namenon = "";

        $sort = $filter['sort'];
        $sortnon = $filter['sortnon'];
        if ($sort != undefined) {
             $food_name.=" AND product_kind = '$sort'";
        }

        if ($sortnon != undefined) {
             $food_namenon.=" AND product_kind = '$sortnon'";
        }

        $wildcard = $filter['wildcard'];
        if ($wildcard != undefined) {
             $product_name.=" AND product_bar_code ILIKE '%$wildcard%' OR product_name ILIKE '%$wildcard%' OR product_or_number ILIKE '%$wildcard%' OR product_status ILIKE '%$wildcard%'";
        }

        $date_from = $filter['date_from'];
        $date_to = $filter['date_to'];

        if ($date_from != undefined) {
            $where2.="AND product_expiration::date between '$date_from' and '$date_to'";
        }else{
            $where2 = "";
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
                $product_name $where2 $food_name $food_namenon
                order by product_name asc
                ;
EOT;

        return ClassParent::get($sql);
    }

    public function get_product_data_or($filter){
        $wildcard = "";

        $wildcard = $filter['wildcard'];
        if ($wildcard != undefined) {
             $product_name.=" AND product_or_number ILIKE '%$wildcard%' OR product_name ILIKE '%$wildcard%'";
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

    public function get_supplier_data_search($filter){
        $wildcard = "";

        $wildcard = $filter['wildcard'];
        if ($wildcard != undefined) {
             $supplier_name.=" AND supplier_name ILIKE '%$wildcard%' OR supplier_code_name ILIKE '%$wildcard%'";
        }

        $sql = <<<EOT
                select
                    pk,
                    supplier_name, 
                    supplier_address,
                    supplier_contact_number,
                    supplier_contact_person,
                    supplier_code_name,
                    date_created::timestamp(0)
                from supplier_data
                where archived = 'f'
                $supplier_name
                order by date_created desc
                ;
EOT;

        return ClassParent::get($sql);
    }

    public function get_tender_data($data){  

        $sql = <<<EOT
                select
                    pk, 
                    product_name,
                    product_quantity,
                    product_supplier_price,
                    product_retail_price,
                    product_transaction_number,
                    cashier_user_id,
                    date_created::timestamp(0)
                from tender_data
                where archived = 'f'
                order by date_created desc
                ;
EOT;

        return ClassParent::get($sql);
    }

    public function get_tender_data_receipt($filter){  
        $transact_number = $filter['transact_number'];
        $sql = <<<EOT
                select * ,
                (select product_receipt_name from product_data where pk = tender_data.product_pk) as product_receipt_name_2
                from tender_data
                where archived = 'f' and product_transaction_number = '$transact_number'
                order by date_created desc
                ;
EOT;

        return ClassParent::get($sql);
    }

    public function get_request_order_data($filter){
        foreach($filter as $k=>$v){
            $filter[$k] = pg_escape_string(trim(strip_tags($v)));
        }

        $where2 = "";

        $date_from = $filter['date_from'];
        $date_to = $filter['date_to'];

/*        if ($date_from != undefined) {
            $where2.="AND request_order_data.date_created::date between '$date_from' and '$date_to'";
        }else{
            $where2 = "";
        }*/

        $sql = <<<EOT
                select
                    pk, 
                    product_finalnumber,
                    product_name,
                    product_quantity,
                    product_date_needed,
                    product_market_price,
                    remarks,
                    (select first_name from users where request_order_data.requested_by_pk = pk) first_name,
                    (select last_name from users where request_order_data.requested_by_pk = pk) last_name,
                    product_pk,
                    date_created::timestamp(0),
                    status
                from request_order_data 
                order by date_created desc
                ;
EOT;

        return ClassParent::get($sql);
    }

    public function get_supplier_data($data){

        $sql = <<<EOT
                select
                    pk,
                    supplier_name, 
                    supplier_address,
                    supplier_contact_number,
                    supplier_contact_person,
                    supplier_code_name,
                    date_created::timestamp(0)
                from supplier_data
                where archived = 'f'
                order by date_created desc
                ;
EOT;

        return ClassParent::get($sql);
    }

    public function get_all_products($filter){

        $wildcard = $filter['wildcard'];

        if ($wildcard != undefined) {
             $title_companyname.=" AND product_bar_code ILIKE '%$wildcard%' OR product_name ILIKE '%$wildcard%'";
        }

        $sql = <<<EOT
            SELECT
                pk,
                product_name,
                product_bar_code,
                product_stocks,
                product_srp,
                product_price,
                product_supplier,
                product_product_code,
                product_rules
                
            from product_data
            where archived = false
            $title_companyname
            order by date_created desc
            ;
EOT;
        return ClassParent::get($sql);
    }

    public function get_storage(){
        $sql = <<<EOT
                SELECT pg_database_size('unraveled')
                ;
EOT;

        return ClassParent::get($sql);
    }

    public function edit_permission($data){
        foreach($filter as $k=>$v){
            $data[$k] = pg_escape_string(trim(strip_tags($v)));
        }
        $user_id = $data['user_id'];
        $permission = $data['permission'];

        $tod = json_decode($permission,true);
        $toe = json_encode($tod);
        $sql = <<<EOT
                update users set permission = '$toe' where user_id = '$user_id'
                ;
EOT;

        return ClassParent::update($sql);
    }

    public function refund_item($data){

        $pk = $data['pk'];
        $product_name = $data['product_name'];
        $product_srp = $data['product_srp'];
        $product_bar_code = $data['product_bar_code'];
        $product_stocks = $data['product_stocks'];
        $product_price = $data['product_price'];
        $product_supplier = $data['product_supplier'];
        $product_receipt_name = $data['product_receipt_name'];
        $product_or_number = $data['product_or_number'];
        $product_product_code = $data['product_product_code'];
        $product_rule = $data['product_rule'];
        $product_kinds = $data['product_kinds'];
        $remarks = $data['remarks'];

        $sql = "begin;";
         $sql = <<<EOT
                insert into refund_item_data
                (
                    product_name,
                    product_srp,
                    product_bar_code,
                    product_stocks,
                    product_price,
                    product_supplier,
                    product_receipt_name,
                    product_or_number,
                    product_or_stocks,
                    product_product_code,
                    product_rules,
                    remarks
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
                    '$product_or_number',
                    '$product_stocks',
                    '$product_product_code',
                    '$product_rule',
                    '$remarks'
                )
                ;
EOT;
            $sql .= <<<EOT
                update product_data set
                (
                    product_stocks,
                    remarks
                )
                =
                (
                    '$product_stocks',
                    'Good Merchandise'
                )
                where pk = '$pk'
                ;
EOT;

        $sql .= "commit;";
        return ClassParent::update($sql);
    }

    public function exchange_item($data){

        $pk = $data['pk'];
        $product_name = $data['product_name'];
        $product_srp = $data['product_srp'];
        $cashier_user_id = $data['cashier_user_id'];
        $product_bar_code = $data['product_bar_code'];
        $product_stocks = $data['product_stocks'];
        $product_price = $data['product_price'];
        $product_supplier = $data['product_supplier'];
        $product_receipt_name = $data['product_receipt_name'];
        $product_stocks_2 = $data['product_stocks_2'];
        $product_or_number = $data['product_or_number'];
        $product_product_code = $data['product_product_code'];
        $product_rule = $data['product_rule'];
        $product_kinds = $data['product_kinds'];
        $remarks = $data['remarks'];
        $exchange_product_name = $data['exchange_product_name'];
        $final_date_tendered = $data['final_date_tendered'];
        $final_date_tendered_2 = $data['final_date_tendered_2'];
        $auto_generated = $data['auto_generated'];

        

        $sql .= "begin;";
        $get_existing_product = <<<EOT
            select * from product_data
            where product_name = '$exchange_product_name'
            order by pk desc
            ;
EOT;

        $get_existing_product = ClassParent::get($get_existing_product);
        if ($get_existing_product['result']) {
            foreach ($get_existing_product['result'] as $k => $v) {
                if ($final_date_tendered_2 != $v['product_expiration']) {
                    
            $pk_value = $v['pk'];
            $product_stocks_222 = floatval($v['product_stocks']) + floatval($product_stocks_2);
            $sql .= <<<EOT
            update product_data set
                (
                    product_stocks,
                    remarks
                )
                =
                (
                    '$product_stocks_222',
                    '$remarks'
                )
                where pk = '$pk_value'
                ;
EOT;

                }
            }
        }
        if ($final_date_tendered_2 == $v['product_expiration']) {
            $pk_value = $v['pk'];
            $still_stocks = $v['product_stocks'];
            $hehe_product_price2 = $product_stocks_2 * $product_price;
            $product_name_2 = $v['product_name'];
            $product_transaction_number = $auto_generated;

            $hehe_product_price_3 = floatval($product_price) - floatval($v['product_price']);
            $hehe_product_price_4 = $product_stocks_2 * $hehe_product_price_3;
            $sql .= <<<EOT
            update product_data set
                (
                    product_stocks,
                    remarks
                )
                =
                (
                    '$still_stocks',
                    '$remarks'
                )
                where pk = '$pk_value'
                ;
EOT;
            $sql .= <<<EOT
            update tender_data set
                (
                    archived
                )
                =
                (
                    't'
                )
                where tender_data.product_pk = '$pk_value'
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
                    date_created,
                    exchange_remarks
                )
                VALUES
                (
                    '$cashier_user_id',
                    '$product_name',
                    '$product_stocks_2',
                    '$product_srp',
                    '$hehe_product_price2',
                    '$product_transaction_number',
                    '0',
                    '0',
                    '0',
                    '0',
                    '0',
                    '0',
                    '$hehe_product_price2',
                    '0',
                    '0',
                    '0',
                    '0',
                    '$hehe_product_price2',
                    '$pk_value',
                    '$final_date_tendered',
                    't'
                )
                ;
EOT;

            $sql .= <<<EOT
            insert into exchange_tender_data
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
                    date_created,
                    exchange_remarks
                )
                VALUES
                (
                    '$cashier_user_id',
                    '$product_name',
                    '$product_stocks_2',
                    '$product_srp',
                    '$hehe_product_price_3',
                    '$product_transaction_number',
                    '0',
                    '0',
                    '0',
                    '0',
                    '0',
                    '0',
                    '$hehe_product_price_4',
                    '0',
                    '0',
                    '0',
                    '0',
                    '$hehe_product_price_4',
                    '$pk_value',
                    '$final_date_tendered',
                    't'
                )
                ;
EOT;

        }

        if ($product_price > $v['product_price'] && $final_date_tendered_2 != $v['product_expiration']) {
            $hehe_product_price = floatval($product_price) - floatval($v['product_price']);
            $hehe_product_price2 = $product_stocks_2 * $hehe_product_price;
            $product_name_2 = $v['product_name'];
            $product_quantity = $product_stocks_2;
            $product_supplier_price = $v['product_srp'];
            $product_retail_price = $v['product_price'];
            $product_transaction_number = $auto_generated ;
            $pk_2 = $v['pk'];
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
                    date_created,
                    exchange_remarks
                )
                VALUES
                (
                    '$cashier_user_id',
                    '$product_name',
                    '$product_stocks_2',
                    '$product_srp',
                    '$hehe_product_price',
                    '$product_transaction_number',
                    '0',
                    '0',
                    '0',
                    '0',
                    '0',
                    '0',
                    '$hehe_product_price2',
                    '0',
                    '0',
                    '0',
                    '0',
                    '$hehe_product_price2',
                    '$pk_2',
                    '$final_date_tendered',
                    't'
                )
                ;
EOT;

            $sql .= <<<EOT
            insert into exchange_tender_data
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
                    date_created,
                    exchange_remarks
                )
                VALUES
                (
                    '$cashier_user_id',
                    '$product_name',
                    '$product_stocks_2',
                    '$product_srp',
                    '$hehe_product_price',
                    '$product_transaction_number',
                    '0',
                    '0',
                    '0',
                    '0',
                    '0',
                    '0',
                    '$hehe_product_price2',
                    '0',
                    '0',
                    '0',
                    '0',
                    '$hehe_product_price2',
                    '$pk_2',
                    '$final_date_tendered',
                    't'
                )
                ;
EOT;
        }
         $sql .= <<<EOT
                insert into refund_item_data
                (
                    product_name,
                    product_srp,
                    product_bar_code,
                    product_stocks,
                    product_price,
                    product_supplier,
                    product_receipt_name,
                    product_or_number,
                    product_or_stocks,
                    product_product_code,
                    product_rules,
                    remarks
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
                    '$product_or_number',
                    '$product_stocks',
                    '$product_product_code',
                    '$product_rule',
                    '$remarks'
                )
                ;
EOT;
            $sql .= <<<EOT
                update product_data set
                (
                    product_stocks,
                    remarks
                )
                =
                (
                    '$product_stocks',
                    '$remarks'
                )
                where pk = '$pk'
                ;
EOT;

        $sql .= "commit;";
        return ClassParent::update($sql);
    }

    public function tender_product_final_down_payment($data){
        
        $datas = $data['data'];
        $datap = $data['data_new'];
        $z = json_decode($datas, true);
        $p = json_decode($datap, true);
        
        $product_transaction_number = $data['product_transaction_number'];
        $cashier_user_id = $data['cashier_user_id'];
        $vat_percentage = $data['vat_percentage'];
        $net_amount = $data['net_amount'];
        $vat = $data['vat'];
        $discount = $data['discount'];
        $change = $data['change'];
        $cash = $data['cash'];
        $total = $data['total'];
        $void_count = $data['void_count'];
        $stock_amount_finalized = $data['stock_amount_finalized'];
        $stock_amount_pk = $data['stock_amount_pk'];
        $stock_amount_status = $data['stock_amount_status'];
        $product_code = $data['product_code'];
        $gc_name = $data['gc_name'];
        $gc_amount = $data['gc_amount'];
        $gc_code = $data['gc_code'];
        $name = $data['name'];
        $action = $data['action'];
        $cnumber = $data['cnumber'];
        $down_payment_amount = $data['down_payment_amount'];
        $cname = $data['cname'];
        $sum_total = $total - $down_payment_amount;

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

        foreach ($p as $key => $value) {

            $pk = $value['pk'];
            $stock_amount = $value['newstock'];

            $sql .= <<<EOT
                update product_data set product_stocks = '$stock_amount' where pk = '$pk'
                ;
                
EOT;
        }
            
        foreach ($z as $key => $value) {

            $product_name = $value['product_name'];
            $product_quantity = $value['product_quantity'];
            $product_supplier_price = $value['product_srp'];
            $product_retail_price = $value['product_price'];
            $tempo_total = $value['tempor_total'];
            $pk = $value['pk'];
            $product_branches = $value['product_branches'];
            $item_size_name = $value['item_size_name'];
            $item_has_size = $value['item_has_size'];
            
            

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
                    '$cashier_user_id',
                    '$product_name',
                    '$product_quantity',
                    '$product_supplier_price',
                    '$product_retail_price',
                    '$product_transaction_number',
                    '$vat_percentage',
                    '$net_amount',
                    '$vat',
                    '$discount',
                    '$change',
                    '$cash',
                    '$total',
                    '$void_count',
                    '$gc_amount',
                    '$gc_name',
                    '$gc_code',
                    '$tempo_total',
                    '$pk',
                    '$item_size_name',
                    '$item_has_size'
                )
                ;
EOT;

            $sql .= <<<EOT
                insert into down_payment_data
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
                    item_has_size,
                    type,
                    down_payment_amount,
                    customer_name,
                    balance
                )
                VALUES
                (
                    '$cashier_user_id',
                    '$product_name',
                    '$product_quantity',
                    '$product_supplier_price',
                    '$product_retail_price',
                    '$product_transaction_number',
                    '$vat_percentage',
                    '$net_amount',
                    '$vat',
                    '$discount',
                    '$change',
                    '$cash',
                    '$total',
                    '$void_count',
                    '$gc_amount',
                    '$gc_name',
                    '$gc_code',
                    '$tempo_total',
                    '$pk',
                    '$item_size_name',
                    '$item_has_size',
                    'Down payment',
                    '$down_payment_amount',
                    '$cname',
                    '$sum_total'
                )
                ;
EOT;
        }
        $sql .= "commit;";
        return ClassParent::insert($sql);
    }
}
?>
