<?php
require_once('../connect.php');
require_once('../../CLASSES/Users.php');
$tempPath = $_FILES[ 'file' ][ 'tmp_name' ];
$csvFile = file($tempPath);
$sql = "begin;";
foreach ($csvFile as $line) {
    $data = str_getcsv($line);
    $barcode = pg_escape_string(trim(strip_tags($data[0]))); 
    $quantity = pg_escape_string(trim(strip_tags($data[1]))); 
    $claz = new Users($data);
    $datab = $claz->get_barcode_2($barcode);
    $result = $datab['result'][0];
    $a = $result['product_bar_code'];
    if ($a == $barcode) {
        $sql .= <<<EOT
            insert into data_collected
            (
                barcode,
                quantity
                )
            values
            (
                '$barcode',
                '$quantity'
                );
EOT;

 $sql .= <<<EOT
            update product_data set
            (
                product_name,
                product_srp,
                product_bar_code,
                product_stocks,
                product_price,
                product_expiration,
                product_supplier,
                product_receipt_name,
                product_status,
                product_or_number,
                product_or_stocks,
                product_product_code,
                product_rules,
                product_kind,
                product_branches,
                input_vat,
                output_vat,
                selling_price,
                product_image
                )
            =
            (
                'Product Name',
                '0',
                '$barcode',
                '$quantity',
                '0',
                '2021-06-04 16:22:23.161762+08',
                'Product Supplier',
                'Receipt name',
                '(OLD)',
                '0',
                'None',
                'Product Code',
                'Product Rules',
                'Product Kinds',
                'Product Branches',
                '0',
                '0',
                '0',
                ''
                )
                where product_data.product_bar_code = '$barcode';
EOT;


            $sql .= <<<EOT
            insert into product_data
            (
                product_name,
                product_srp,
                product_bar_code,
                product_stocks,
                product_price,
                product_expiration,
                product_supplier,
                product_receipt_name,
                product_status,
                product_or_number,
                product_or_stocks,
                product_product_code,
                product_rules,
                product_kind,
                product_branches,
                product_image,
                input_vat,
                output_vat,
                selling_price
                )
            values
            (
                'Product Name',
                '0',
                '$barcode',
                '$quantity',
                '0',
                '2021-06-04 16:22:23.161762+08',
                'Product Supplier',
                'Receipt name',
                '(NEW)',
                '0',
                'None',
                'Product Code',
                'Product Rules',
                'Product Kinds',
                'Product Branches',
                '',
                '0',
                '0',
                '0'
                );
EOT;

           

    $sql .= "commit;";
    }else{

        $sql .= <<<EOT
            insert into data_collected
            (
                barcode,
                quantity
                )
            values
            (
                '$barcode',
                '$quantity'
                );
EOT;

$sql .= <<<EOT
            insert into product_data
            (
                product_name,
                product_srp,
                product_bar_code,
                product_stocks,
                product_price,
                product_expiration,
                product_supplier,
                product_receipt_name,
                product_status,
                product_or_number,
                product_or_stocks,
                product_product_code,
                product_rules,
                product_kind,
                product_branches,
                product_image,
                input_vat,
                output_vat,
                selling_price
                )
            values
            (
                'Product Name',
                '0',
                '$barcode',
                '$quantity',
                '0',
                '2021-06-04 16:22:23.161762+08',
                'Product Supplier',
                'Receipt name',
                '(NEW)',
                '0',
                'None',
                'Product Code',
                'Product Rules',
                'Product Kinds',
                'Product Branches',
                '',
                '0',
                '0',
                '0'
                );
EOT;

           

    $sql .= "commit;";

    }
    }

    $query = pg_query($sql);
    header("HTTP/1.0 500 Internal Server Error");
    if($data['status']==true){
    header("HTTP/1.0 200 OK");
}
    header('Content-Type: application/json');
    pg_free_result($query);



?>