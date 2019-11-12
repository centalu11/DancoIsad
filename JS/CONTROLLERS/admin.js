app.controller('Admin', function(
                                    $scope,
                                    SessionFactory,
                                    UserFactory,
                                    ProductFactory,
                                    md5,
                                    $filter,
                                    ngDialog,
                                    $route,
                                    cfpLoadingBar,
                                    FileUploader
                                    ) 
{

    $scope.user = {};

    $scope.form = {};
    $scope.datass = {};
    $scope.filter = {};
    $scope.product_checker = {};
    $scope.tender_new = [];
    $scope.fa = {};
    $scope.stocks_status = 0;
    $scope.stocks_statuses =false;
    $scope.tender_voided = {};
    $scope.hehe = {};
    $scope.tender_voided.count = 0;
    $scope.checked_bcode_status = {};
    $scope.submit_datas = {};
    $scope.check_item_data_status = {};
    $scope.product_data_expire_status = {};
    $scope.product_code = {};
    $scope.stock_amount_status = false;
    $scope.stock_amount_finalized = 0;
    $scope.stock_amount_pk = {};
    $scope.stock_amount = 0;
    $scope.cash_status = false;
    $scope.gift_status = false;
    $scope.discount = false;
    $scope.tender_status = false;
    $scope.discount_amounts = 0;
    $scope.amount_senior = 0;
    $scope.product_total_tempo = 0;
    $scope.net_amount = 0;
    $scope.vat = 0;
    $scope.change = 0;
    $scope.cash = 0;
    $scope.number = 0;
    $scope.number_total = 0;
    $scope.product_total_temporary = 0;
    $scope.product_total = 0;
    $scope.modal = {};
    $scope.tender_data = [];
    $scope.product_checker = {};
    $scope.hehe = {};
    $scope.checked_bcode_status = {};
    $scope.upload_image2 = {};
    $scope.upload_image2.queue = {};
    $scope.edit_upload_image = {};
    $scope.edit_upload_image.queue = {};

    $scope.cashier = {};

    $scope.viewby_customerdata = 10;
    $scope.currentPage_customerdata = 4;
    $scope.itemsPerPage_customerdata = $scope.viewby_customerdata;
    $scope.maxSize = 5;

    $scope.viewby_productdata = 10;
    $scope.currentPage_productdata = 4;
    $scope.itemsPerPage_productdata = $scope.viewby_productdata;
    $scope.maxSize = 5;

    $scope.viewby_branchdata = 10;
    $scope.currentPage_branchdata = 4;
    $scope.itemsPerPage_branchdata = $scope.viewby_branchdata;
    $scope.maxSize = 5;

    $scope.viewby_cbcode_data = 10;
    $scope.currentPage_cbcode_data = 4;
    $scope.itemsPerPage_cbcode_data = $scope.viewby_cbcode_data;
    $scope.maxSize = 5;

    $scope.isVisible = false;

    var filtered = {};
    var filters= {};
    var filter= {};

    init();

    $scope.showHide = function() {
        $scope.isVisible = !$scope.isVisible;
    }

    $scope.vm = {};
    $scope.vm.options = {format: 'YYYY/MM/DD HH:mm', showClear: true};

    function init(){
        var promise = SessionFactory.getsession();
        promise.then(function(data){
            var _id = md5.createHash('pk');
            $scope.pk = data.data[_id];
            get_user();
            DEFAULTDATES();
            makeid();

        })
        .then(null, function(data){
            window.location = './login.html';
        });
    }

    function get_user(){
        var filters = {
            'pk' : $scope.pk
        };

        var promise = UserFactory.get_user(filters);
        promise.then(function(data){
            $scope.user = data.data.result[0];
            get_rule_data();
            get_supplier_data();
            get_customer_data();
            get_branch_data();
            get_product_data();
            get_product_data_expire();
            get_product_data_checker();

        })
        .then(null, function(data){
            var promise = SessionFactory.logout();
            promise.then(function(data){
                window.location = './login.html';
            });
        });
    }

    $scope.add_items = function(){
        window.location = "#/Admin";
    }

    $scope.edit_items = function(){
        window.location = "#/EditInvent";
    }


    function DEFAULTDATES(){
        var today = new Date();

        var dd = today.getDate();
        var mm = today.getMonth()+1;
        var yyyy = today.getFullYear();

        if(dd<10) {
            dd='0'+dd
        }

        if(mm<10) {
            mm='0'+mm
        }

        today = yyyy+'-'+mm+'-'+dd;


        $scope.filter.product_expiration = new Date();
        $scope.datass.product_expiration = today;
        $scope.filter.date3 = getMonday(new Date());
        $scope.filter.date4 = today;
        $scope.filter.po1 = getMonday(new Date());
        $scope.filter.po2 = today;
        $scope.date_ngayon = today;
        $scope.date_ngayon_2 = today;
    }

    function getMonday(d) {
        var d = new Date(d);
        var day = d.getDay(),
        diff = d.getDate() - day + (day == 0 ? -6:1);

        var new_date = new Date(d.setDate(diff));
        var dd = new_date.getDate();
        var mm = new_date.getMonth()+1;
        var yyyy = new_date.getFullYear();

        if(dd<10) {
            dd='0'+dd
        }

        if(mm<10) {
            mm='0'+mm
        }

        var monday = yyyy+'-'+mm+'-'+dd;

        return monday;
    }


$scope.sortstocks_checker = function(){
    if ($scope.stocks_status == 0 || $scope.stocks_statuses == false) {
        $scope.sortstocks();
        $scope.fa = "fa-sort-desc";
    };
    if ($scope.stocks_status == 1 || $scope.stocks_statuses == true) {
        $scope.sortstocks2();
        $scope.fa = "fa-caret-up";
    };
}


$scope.sortstocks = function(){
/*    if ($scope.form.search == "") {
        get_product_data();
    }*/

    filters = {
        wildcard2 : 3,
        wildcard : undefined,
        wildcard3 : undefined
    };


    var promise = ProductFactory.get_product_data_search(filters);
    promise.then(function(data){
        $scope.product_data = data.data.result;

        var a = 0;
        for (var i in $scope.product_data) {
            $scope.product_data[i].product_expiration = new Date($scope.product_data[i].product_expiration);
            $scope.product_data[i].product_expiration = moment($scope.product_data[i].product_expiration).format('LLLL');
            $scope.product_data[i].date_created = moment($scope.product_data[i].date_created).format('LLLL');
            $scope.product_data[i].number = a += 1;
        };

        var x = .12;
        for (var i in $scope.product_data) {
            $scope.form.vat_wamount = x * $scope.product_data[i].product_srp;
            $scope.product_data[i].wamount1 = parseFloat($scope.product_data[i].product_srp) + parseFloat($scope.form.vat_wamount);
            $scope.product_data[i].wamount3 = parseFloat($scope.product_data[i].wamount1).toFixed(2);

        };

        for (var z in $scope.product_data) {
            if ($scope.product_data[z].product_status == '(OLD)') {
                $scope.product_data[z].product_status_color = 1;
                $scope.product_data[z].product_status_color1 = 'red';
            }
            if ($scope.product_data[z].product_status == '(NEW)') {
                $scope.product_data[z].product_status_color = 1;
                $scope.product_data[z].product_status_color1 = 'green';
            }
        };

        for (var o in $scope.product_data) {
            if ($scope.product_data[o].request_order_status == "true") {
                $scope.product_data[o].request_order_status = 1;
            }
            if ($scope.product_data[o].request_order_status == null || $scope.product_data[o].request_order_status == "null" || $scope.product_data[o].request_order_status == 'null' && $scope.product_data[o].product_stocks <= "3" && $scope.product_data[o].product_stocks <= 3 && $scope.product_data[o].product_stocks <= '3') {
                $scope.product_data[o].request_order_status = 2;
            }
            if ($scope.product_data[o].request_order_status == 2 || $scope.product_data[o].request_order_status == null || $scope.product_data[o].request_order_status == 'null') {
                $scope.product_data[o].request_order_status = 'false';
            }
        };

        for(var i in $scope.product_data){
            if ($scope.product_data[i].product_image == 'undefined' || $scope.product_data[i].product_image == undefined || $scope.product_data[i].product_image == null || $scope.product_data[i].product_image == "null" || $scope.product_data[i].product_image == "" || $scope.product_data[i].product_image == '') {
                $scope.product_data[i].product_image_status = false;
            }else{
                $scope.product_data[i].product_image_status = true;
            }
        };

        /*$scope.totalItems_productdata = $scope.product_data.length;*/
        $scope.stocks_statuses = true;
        $scope.stocks_status = 1;
    })
.then(null, function(data){

});
}
/*$scope.setPage_productdata = function (pageNo) {
    $scope.currentPage_productdata = pageNo;
};

$scope.pageChanged_productdata = function() {
    console.log('Page changed to: ' + $scope.currentPage_productdata);
};

$scope.setItemsPerPage_productdata = function(num) {
    $scope.itemsPerPage_productdata = num;
$scope.currentPage_productdata = 1; //reset to first paghe
}
*/
$scope.sortstocks2 = function(){
/*    if ($scope.form.search == "") {
        get_product_data();
    }*/

    filters = {
        wildcard3 : 4,
        wildcard : undefined,
        wildcard2 : undefined
    };


    var promise = ProductFactory.get_product_data_search(filters);
    promise.then(function(data){
        $scope.product_data = data.data.result;


        var a = 0;
        for (var i in $scope.product_data) {
            $scope.product_data[i].product_expiration = new Date($scope.product_data[i].product_expiration);
            $scope.product_data[i].product_expiration = moment($scope.product_data[i].product_expiration).format('LLLL');
            $scope.product_data[i].date_created = moment($scope.product_data[i].date_created).format('LLLL');
            $scope.product_data[i].number = a += 1;
        };

        var x = .12;
        for (var i in $scope.product_data) {
            $scope.form.vat_wamount = x * $scope.product_data[i].product_srp;
            $scope.product_data[i].wamount1 = parseFloat($scope.product_data[i].product_srp) + parseFloat($scope.form.vat_wamount);
            $scope.product_data[i].wamount3 = parseFloat($scope.product_data[i].wamount1).toFixed(2);

        };

        for (var z in $scope.product_data) {
            if ($scope.product_data[z].product_status == '(OLD)') {
                $scope.product_data[z].product_status_color = 1;
                $scope.product_data[z].product_status_color1 = 'red';
            }
            if ($scope.product_data[z].product_status == '(NEW)') {
                $scope.product_data[z].product_status_color = 1;
                $scope.product_data[z].product_status_color1 = 'green';
            }
        };

        for (var o in $scope.product_data) {
            if ($scope.product_data[o].request_order_status == "true") {
                $scope.product_data[o].request_order_status = 1;
            }
            if ($scope.product_data[o].request_order_status == null || $scope.product_data[o].request_order_status == "null" || $scope.product_data[o].request_order_status == 'null' && $scope.product_data[o].product_stocks <= "3" && $scope.product_data[o].product_stocks <= 3 && $scope.product_data[o].product_stocks <= '3') {
                $scope.product_data[o].request_order_status = 2;
            }
            if ($scope.product_data[o].request_order_status == 2 || $scope.product_data[o].request_order_status == null || $scope.product_data[o].request_order_status == 'null') {
                $scope.product_data[o].request_order_status = 'false';
            }
        };

        for(var i in $scope.product_data){
            if ($scope.product_data[i].product_image == 'undefined' || $scope.product_data[i].product_image == undefined || $scope.product_data[i].product_image == null || $scope.product_data[i].product_image == "null" || $scope.product_data[i].product_image == "" || $scope.product_data[i].product_image == '') {
                $scope.product_data[i].product_image_status = false;
            }else{
                $scope.product_data[i].product_image_status = true;
            }
        };

        $scope.totalItems_productdata = $scope.product_data.length;
        $scope.stocks_status = 0;
        $scope.stocks_statuses = false;
    })
.then(null, function(data){

});
}
$scope.setPage_productdata = function (pageNo) {
    $scope.currentPage_productdata = pageNo;
};

$scope.pageChanged_productdata = function() {
    console.log('Page changed to: ' + $scope.currentPage_productdata);
};

$scope.setItemsPerPage_productdata = function(num) {
    $scope.itemsPerPage_productdata = num;
$scope.currentPage_productdata = 1; //reset to first paghe
}

    function get_product_data_checker(){

        var promise = ProductFactory.get_product_data_checker();
        promise.then(function(data){
            $scope.product_data_checker = data.data.result;

            

        })
        .then(null, function(data){


        });
    }

    function get_customer_data(){
    cfpLoadingBar.start();

    var promise = ProductFactory.get_customer_data();
    promise.then(function(data){
        $scope.customer_data = data.data.result;
        
        

        var a = 0;
        for (var i in $scope.customer_data) {
            $scope.customer_data[i].product_expiration = new Date($scope.customer_data[i].product_expiration);
            $scope.customer_data[i].product_expiration = moment($scope.customer_data[i].product_expiration).format('LLLL');
            $scope.customer_data[i].date_created = moment($scope.customer_data[i].date_created).format('LLLL');
            $scope.customer_data[i].number = a += 1;

            $scope.customer_data[i].last_days = new Date($scope.customer_data[i].last_day);
            $scope.customer_data[i].last_days = $filter('date')($scope.customer_data[i].last_days, "mediumDate");
        };

        $scope.totalItems_customerdata = $scope.customer_data.length;
    })
    .then(null, function(data){
        cfpLoadingBar.complete();
    });
}
$scope.setPage_customerdata = function (pageNo) {
    $scope.currentPage_customerdata = pageNo;
};

$scope.pageChanged_customerdata = function() {
    console.log('Page changed to: ' + $scope.currentPage_customerdata);
};

$scope.setItemsPerPage_customerdata = function(num) {
    $scope.itemsPerPage_customerdata = num;
$scope.currentPage_customerdata = 1; //reset to first paghe
}

$scope.add_branch = function(){


    $scope.modal = {
        title : 'Add Branch',
        save : 'Add',
        close : 'Cancel'
    }     

    ngDialog.openConfirm({
        template: 'EditUser',
        className: 'ngdialog-theme-plain dialogwidth500',
        preCloseCallback: function(value) {
            var nestedConfirmDialog;
            if ($scope.modal.branch_name == '' || $scope.modal.branch_name == "" || $scope.modal.branch_name == NaN || $scope.modal.branch_name == null || $scope.modal.branch_name == undefined || $scope.modal.branch_name == 'NaN') {
                var notify = $.notify('Oops there something wrong with the first name!', {'type': 'danger' ,  allow_dismiss: true });
                cfpLoadingBar.complete();
                return false;
            }
            if ($scope.modal.address == '' || $scope.modal.address == "" || $scope.modal.address == NaN || $scope.modal.address == null || $scope.modal.address == undefined || $scope.modal.address == 'NaN') {
                var notify = $.notify('Oops there something wrong with the middle name!', {'type': 'danger' ,  allow_dismiss: true });
                cfpLoadingBar.complete();
                return false;
            }
            if ($scope.modal.contact_person == '' || $scope.modal.contact_person == "" || $scope.modal.contact_person == NaN || $scope.modal.contact_person == null || $scope.modal.contact_person == undefined || $scope.modal.contact_person == 'NaN') {
                var notify = $.notify('Oops there something wrong with the e-mail!', {'type': 'danger' ,  allow_dismiss: true });
                cfpLoadingBar.complete();
                return false;
            }
            if ($scope.modal.contact_number == '' || $scope.modal.contact_number == "" || $scope.modal.contact_number == NaN || $scope.modal.contact_number == null || $scope.modal.contact_number == undefined || $scope.modal.contact_number == 'NaN') {
                var notify = $.notify('Oops there something wrong with the last name!', {'type': 'danger' ,  allow_dismiss: true });
                cfpLoadingBar.complete();
                return false;
            }
            if ($scope.modal.vat_registered == '' || $scope.modal.vat_registered == "" || $scope.modal.vat_registered == NaN || $scope.modal.vat_registered == null || $scope.modal.vat_registered == undefined || $scope.modal.vat_registered == 'NaN') {
                var notify = $.notify('Please specify if this branch is vat registered or not.', {'type': 'danger' ,  allow_dismiss: true });
                cfpLoadingBar.complete();
                return false;
            }
            return nestedConfirmDialog;
        },
        scope: $scope,
        showClose: false
    })
    .then(function(value){
        return false;
    }, function(value){
        cfpLoadingBar.start();
        /*$scope.modal.new_password = md5.createHash($scope.modal.first_password);*/
        var promise = ProductFactory.add_branch($scope.modal);
        promise.then(function(data){
            var notify = $.notify('You have succesfully added a new branch', { 'type': 'success', allow_dismiss: true });
            get_branch_data();
            cfpLoadingBar.complete();
        })
        .then(null, function(data){
            var notify = $.notify('Oops there is something wrong!', { 'type': 'danger', allow_dismiss: true });
            cfpLoadingBar.complete();
        });
    });
}

$scope.tabs = {
    search : false,
    addinve : false,
    editinve : false
};
$scope.tab_changer = function(tab) {
    for (var i in $scope.tabs) {
        $scope.tabs[i] = false;
    }
    $scope.tabs[tab] = true;
}

$scope.check_item = function(){
    $scope.modal = {
        title : 'Add Item',
        save : 'Save',
        close : 'Cancel'
    }     

    ngDialog.openConfirm({
        template: 'OpenModal',
        className: 'ngdialog-theme-plain dialogwidth100',
        preCloseCallback: function(value) {
            var nestedConfirmDialog;
           /* if ($scope.modal.product_name == '' || $scope.modal.product_name == "" || $scope.modal.product_name == NaN || $scope.modal.product_name == null || $scope.modal.product_name == undefined || $scope.modal.product_name == 'NaN') {
                var notify = $.notify('Oops there something wrong with the Product Name!', {'type': 'danger' ,  allow_dismiss: true });
                cfpLoadingBar.complete();
                return false;
            }
            if ($scope.modal.product_bar_code == '' || $scope.modal.product_bar_code == "" || $scope.modal.product_bar_code == NaN || $scope.modal.product_bar_code == null || $scope.modal.product_bar_code == undefined || $scope.modal.product_bar_code == 'NaN') {
                var notify = $.notify('Oops there something wrong with the Product Amount!', {'type': 'danger' ,  allow_dismiss: true });
                cfpLoadingBar.complete();
                return false;
            }*/
            return nestedConfirmDialog;
        },
        scope: $scope,
        showClose: false
    })
    .then(function(value){
        return false;
    }, function(value){
       cfpLoadingBar.start();
    var filters = {
        wildcard : $scope.form.product_bar_code
    };


    var promise = ProductFactory.get_check_item(filters);
    promise.then(function(data){
        $scope.check_item_data_status = true;
        $scope.check_item_data = data.data.result;



        for (var i in $scope.check_item_data) {
            if ($scope.form.product_bar_code == $scope.check_item_data[i].product_bar_code) {
                $scope.form.x = $scope.check_item_data[i].pk;
                $scope.form.product_status_new = '(NEW)';
                $scope.form.product_status_1 = '(NEW/OLD)';
                $scope.add_product();
            };
        };

    })
    .then(null, function(data){
        $scope.check_item_data_status = false;
        $scope.form.product_status = 1; 
        $scope.add_product();
        cfpLoadingBar.complete();
    });
    });
}

$scope.add_product = function(){
cfpLoadingBar.start();
   /* $scope.datass.product_expiration = $filter('date')($scope.datass.product_expiration._d, "mediumDate");
    $scope.splitted_product_expiration = $scope.datass.product_expiration.split(" ");*/
    /*if ($scope.splitted_product_expiration[0] == "Jan") {
        $scope.splitted_product_expiration[0] = '01';
    };
    if ($scope.splitted_product_expiration[0] == "Feb") {
        $scope.splitted_product_expiration[0] = '02';
    };
    if ($scope.splitted_product_expiration[0] == "Mar") {
        $scope.splitted_product_expiration[0] = '03';
    };
    if ($scope.splitted_product_expiration[0] == "Apr") {
        $scope.splitted_product_expiration[0] = '04';
    };
    if ($scope.splitted_product_expiration[0] == "May") {
        $scope.splitted_product_expiration[0] = '05';
    };
    if ($scope.splitted_product_expiration[0] == "Jun") {
        $scope.splitted_product_expiration[0] = '06';
    };
    if ($scope.splitted_product_expiration[0] == "Jul") {
        $scope.splitted_product_expiration[0] = '07';
    };
    if ($scope.splitted_product_expiration[0] == "Aug") {
        $scope.splitted_product_expiration[0] = '08';
    };
    if ($scope.splitted_product_expiration[0] == "Sep") {
        $scope.splitted_product_expiration[0] = '09';
    };
    if ($scope.splitted_product_expiration[0] == "Oct") {
        $scope.splitted_product_expiration[0] = '10';
    };
    if ($scope.splitted_product_expiration[0] == "Nov") {
        $scope.splitted_product_expiration[0] = '11';
    };
    if ($scope.splitted_product_expiration[0] == "Dec") {
        $scope.splitted_product_expiration[0] = '12';
    };
    $scope.splitted_product_expiration_2 = $scope.splitted_product_expiration[1].replace(",", "");
    $scope.datass.product_expiration_2 = $scope.splitted_product_expiration[2] +"-"+ $scope.splitted_product_expiration[0] +"-"+ $scope.splitted_product_expiration_2;
*/

    if ($scope.form.product_status == 1) {
        $scope.form.product_status_new = '(NEW)';
    }else{
        $scope.form.product_status_new = '(NEW)';
        $scope.form.product_status_1 = '(NEW/OLD)';
    }

    $scope.form.input_vat1 = $scope.form.srp * .12;
    $scope.form.input_vat2 = parseFloat($scope.form.input_vat1).toFixed(2);
    //Markup Price is Product Price
    //VAT Output is based on Branch VAT Registered or Not
    for(var branches in $scope.branch_data){
        if ($scope.form.branches == $scope.branch_data[branches].branch_name) {
            $scope.form.vat_register_option = $scope.branch_data[branches].vat_registered;
        }
    }
    if ($scope.form.vat_register_option == 't') {
        $scope.form.product_price = parseInt($scope.form.product_price);
        $scope.form.output_vat1 = $scope.form.product_price * .12;
        $scope.form.output_vat2 = $scope.form.output_vat1;
        $scope.form.selling_price1 = $scope.form.product_price + $scope.form.output_vat2;
        // $scope.form.selling_price2 = parseFloat($scope.form.selling_price1).toFixed(2);
    }else{
        $scope.form.output_vat1 = 0;
        $scope.form.output_vat2 = 0;
        $scope.form.selling_price1 = $scope.form.product_price;
    }

    // console.log($scope.form.selling_price1);
    // return false;

    if ($scope.form.product_kinds == '' || $scope.form.product_kinds == "" || $scope.form.product_kinds == NaN || $scope.form.product_kinds == null || $scope.form.product_kinds == undefined || $scope.form.product_kinds == 'NaN') {
        var notify = $.notify('Product Kind is required!', {'type': 'danger' ,  allow_dismiss: true });
        cfpLoadingBar.complete();
        return false;
    }

    var datas = {
        product_name : $scope.form.product_name,
        product_bar_code : $scope.form.product_bar_code,
        product_stocks : $scope.form.product_stocks,
        product_srp : $scope.form.srp,
        product_price : $scope.form.product_price,
        product_supplier : $scope.form.product_supplier,
        product_receipt_name : $scope.form.receipt_name,
        product_status : $scope.form.product_status_new,
        product_status_1 : $scope.form.product_status_1,
        product_status_pk : $scope.form.x,
        product_or_number : $scope.form.or_number,
        product_product_code : $scope.form.product_code,
        product_rule : $scope.form.product_rule,
        product_kinds : $scope.form.product_kinds,
        product_branches : $scope.form.branches,
        product_image : $scope.modal.image_source,
        input_vat:$scope.form.input_vat2,
        output_vat:$scope.form.output_vat2,
        selling_price:$scope.form.selling_price1
    }

    var promise = ProductFactory.add_product(datas);    
    promise.then(function(data){
        var notify = $.notify('You have succesfully added the product', { allow_dismiss: true });
        get_product_data();
        $route.reload();
        cfpLoadingBar.complete();

    })
    .then(null, function(data){
        var notify = $.notify('Oops there something wrong! Please check all datas', { allow_dismiss: true });
        cfpLoadingBar.complete();
    });
}


function get_branch_data(){
    cfpLoadingBar.start();

    var promise = ProductFactory.get_branch_data();
    promise.then(function(data){
        $scope.branch_data = data.data.result;

        var a = 0;

        for (var i in $scope.branch_data) {
            $scope.branch_data[i].product_expiration = new Date($scope.branch_data[i].product_expiration);
            $scope.branch_data[i].product_expiration = $filter('date')($scope.branch_data[i].product_expiration, "mediumDate");
            $scope.branch_data[i].date_created = new Date($scope.branch_data[i].date_created);
            $scope.branch_data[i].number = a += 1;

            if ($scope.branch_data[i].vat_registered == 'f'){
                $scope.branch_data[i].vat_registered_for_see = 'No.';
            }else{
                $scope.branch_data[i].vat_registered_for_see = 'Yes.';       
            }

        };

        $scope.totalItems_branchdata = $scope.branch_data.length;
    })
    .then(null, function(data){
        cfpLoadingBar.complete();
    });
}
$scope.setPage_branchdata = function (pageNo) {
    $scope.currentPage_branchdata = pageNo;
};

$scope.pageChanged_branchdata = function() {
    console.log('Page changed to: ' + $scope.currentPage_branchdata);
};

$scope.setItemsPerPage_branchdata = function(num) {
    $scope.itemsPerPage_branchdata = num;
$scope.currentPage_branchdata = 1; //reset to first paghe
}

$scope.edit_branch = function(v){
    var index = $scope.branch_data.indexOf(v);

    $scope.modal = {
        title : 'Update Branch',
        save : 'Update',
        close : 'Cancel',
        branch_name: $scope.branch_data[index].branch_name,
        address: $scope.branch_data[index].address,
        contact_person: $scope.branch_data[index].contact_person,
        contact_number: $scope.branch_data[index].contact_number,
        vat_registered : $scope.branch_data[index].vat_registered
    }     

    ngDialog.openConfirm({
        template: 'UpdateUser',
        className: 'ngdialog-theme-plain dialogwidth500',
        preCloseCallback: function(value) {
            var nestedConfirmDialog;
            if ($scope.modal.branch_name == '' || $scope.modal.branch_name == "" || $scope.modal.branch_name == NaN || $scope.modal.branch_name == null || $scope.modal.branch_name == undefined || $scope.modal.branch_name == 'NaN') {
                var notify = $.notify('Oops there something wrong with the first name!', {'type': 'danger' ,  allow_dismiss: true });
                cfpLoadingBar.complete();
                return false;
            }
            if ($scope.modal.address == '' || $scope.modal.address == "" || $scope.modal.address == NaN || $scope.modal.address == null || $scope.modal.address == undefined || $scope.modal.address == 'NaN') {
                var notify = $.notify('Oops there something wrong with the middle name!', {'type': 'danger' ,  allow_dismiss: true });
                cfpLoadingBar.complete();
                return false;
            }
            if ($scope.modal.contact_person == '' || $scope.modal.contact_person == "" || $scope.modal.contact_person == NaN || $scope.modal.contact_person == null || $scope.modal.contact_person == undefined || $scope.modal.contact_person == 'NaN') {
                var notify = $.notify('Oops there something wrong with the e-mail!', {'type': 'danger' ,  allow_dismiss: true });
                cfpLoadingBar.complete();
                return false;
            }
            if ($scope.modal.contact_number == '' || $scope.modal.contact_number == "" || $scope.modal.contact_number == NaN || $scope.modal.contact_number == null || $scope.modal.contact_number == undefined || $scope.modal.contact_number == 'NaN') {
                var notify = $.notify('Oops there something wrong with the last name!', {'type': 'danger' ,  allow_dismiss: true });
                cfpLoadingBar.complete();
                return false;
            }
            if ($scope.modal.vat_registered == '' || $scope.modal.vat_registered == "" || $scope.modal.vat_registered == NaN || $scope.modal.vat_registered == null || $scope.modal.vat_registered == undefined || $scope.modal.vat_registered == 'NaN') {
                var notify = $.notify('Please specify if this branch is vat registered or not.', {'type': 'danger' ,  allow_dismiss: true });
                cfpLoadingBar.complete();
                return false;
            }
            return nestedConfirmDialog;
        },
        scope: $scope,
        showClose: false
    })
    .then(function(value){
        return false;
    }, function(value){
        cfpLoadingBar.start();
        /*$scope.modal.new_password = md5.createHash($scope.modal.first_password);*/
        $scope.modal.pk = $scope.branch_data[index].pk;
        var promise = ProductFactory.edit_branch($scope.modal);
        promise.then(function(data){
            var notify = $.notify('You have succesfully updated the branch details', { 'type': 'success', allow_dismiss: true });
            get_branch_data();
            cfpLoadingBar.complete();
        })
        .then(null, function(data){
            var notify = $.notify('Oops there is something wrong!', { 'type': 'danger', allow_dismiss: true });
            cfpLoadingBar.complete();
        });
    });
}

$scope.delete_branch = function(v){
    var index = $scope.branch_data.indexOf(v);


    $scope.modal = {
        title : 'Are you sure you want to delete this branch?',
        save : 'Delete',
        close : 'Cancel',
        branch_name: $scope.branch_data[index].branch_name,
        address: $scope.branch_data[index].address,
        contact_person: $scope.branch_data[index].contact_person,
        contact_number: $scope.branch_data[index].contact_number
    }     

    ngDialog.openConfirm({
        template: 'ConfirmModal',
        className: 'ngdialog-theme-plain dialogwidth400',
        preCloseCallback: function(value) {
            var nestedConfirmDialog;
            return nestedConfirmDialog;
        },
        scope: $scope,
        showClose: false
    })
    .then(function(value){
        return false;
    }, function(value){
        cfpLoadingBar.start();
        /*$scope.modal.new_password = md5.createHash($scope.modal.first_password);*/
        $scope.modal.pk = $scope.branch_data[index].pk;
        var promise = ProductFactory.delete_branch($scope.modal);
        promise.then(function(data){
            var notify = $.notify('You have succesfully deleted the branch details', { 'type': 'success', allow_dismiss: true });
            get_branch_data();
            cfpLoadingBar.complete();
        })
        .then(null, function(data){
            var notify = $.notify('Oops there is something wrong!', { 'type': 'danger', allow_dismiss: true });
            cfpLoadingBar.complete();
        });
    });
}


    $scope.add_customer = function(){


    $scope.modal = {
        title : 'Add Customer',
        save : 'Add',
        close : 'Cancel'
    }     

    ngDialog.openConfirm({
        template: 'EditUser',
        className: 'ngdialog-theme-plain dialogwidth500',
        preCloseCallback: function(value) {
            var nestedConfirmDialog;
            if ($scope.modal.first_name == '' || $scope.modal.first_name == "" || $scope.modal.first_name == NaN || $scope.modal.first_name == null || $scope.modal.first_name == undefined || $scope.modal.first_name == 'NaN') {
                var notify = $.notify('Oops there something wrong with the first name!', {'type': 'danger' ,  allow_dismiss: true });
                cfpLoadingBar.complete();
                return false;
            }
            if ($scope.modal.middle_name == '' || $scope.modal.middle_name == "" || $scope.modal.middle_name == NaN || $scope.modal.middle_name == null || $scope.modal.middle_name == undefined || $scope.modal.middle_name == 'NaN') {
                var notify = $.notify('Oops there something wrong with the middle name!', {'type': 'danger' ,  allow_dismiss: true });
                cfpLoadingBar.complete();
                return false;
            }
            if ($scope.modal.last_name == '' || $scope.modal.last_name == "" || $scope.modal.last_name == NaN || $scope.modal.last_name == null || $scope.modal.last_name == undefined || $scope.modal.last_name == 'NaN') {
                var notify = $.notify('Oops there something wrong with the last name!', {'type': 'danger' ,  allow_dismiss: true });
                cfpLoadingBar.complete();
                return false;
            }
            if ($scope.modal.email == '' || $scope.modal.email == "" || $scope.modal.email == NaN || $scope.modal.email == null || $scope.modal.email == undefined || $scope.modal.email == 'NaN') {
                var notify = $.notify('Oops there something wrong with the e-mail!', {'type': 'danger' ,  allow_dismiss: true });
                cfpLoadingBar.complete();
                return false;
            }
            if ($scope.modal.contact_number == '' || $scope.modal.contact_number == "" || $scope.modal.contact_number == NaN || $scope.modal.contact_number == null || $scope.modal.contact_number == undefined || $scope.modal.contact_number == 'NaN') {
                var notify = $.notify('Oops there something wrong with the contact number!', {'type': 'danger' ,  allow_dismiss: true });
                cfpLoadingBar.complete();
                return false;
            }
            return nestedConfirmDialog;
        },
        scope: $scope,
        showClose: false
    })
    .then(function(value){
        return false;
    }, function(value){
        cfpLoadingBar.start();
        $scope.modal.last_days = $filter('date')($scope.modal.last_day._d,"yyyy/MM/dd HH:mm");
        var promise = ProductFactory.add_customer($scope.modal);
        promise.then(function(data){
            var notify = $.notify('You have succesfully added a new customer', { 'type': 'success', allow_dismiss: true });
            get_customer_data();
            cfpLoadingBar.complete();
        })
        .then(null, function(data){
            var notify = $.notify('Oops there is something wrong!', { 'type': 'danger', allow_dismiss: true });
            cfpLoadingBar.complete();
        });
    });
}


$scope.edit_customer = function(v){
    var index = $scope.customer_data.indexOf(v);


    $scope.modal = {
        title : 'Update Customer',
        save : 'Update',
        close : 'Cancel',
        first_name: $scope.customer_data[index].first_name,
        middle_name: $scope.customer_data[index].middle_name,
        last_name: $scope.customer_data[index].last_name,
        email: $scope.customer_data[index].email,
        contact_number: $scope.customer_data[index].contact_number,
        job_position : $scope.customer_data[index].job_position,
        company : $scope.customer_data[index].company,
        cadd : $scope.customer_data[index].cadd,
        tin : $scope.customer_data[index].tin,
        percent : $scope.customer_data[index].percent,
        last_day : $scope.customer_data[index].last_day
    }     

    ngDialog.openConfirm({
        template: 'UpdateUser',
        className: 'ngdialog-theme-plain dialogwidth500',
        preCloseCallback: function(value) {
            var nestedConfirmDialog;
            if ($scope.modal.first_name == '' || $scope.modal.first_name == "" || $scope.modal.first_name == NaN || $scope.modal.first_name == null || $scope.modal.first_name == undefined || $scope.modal.first_name == 'NaN') {
                var notify = $.notify('Oops there something wrong with the first name!', {'type': 'danger' ,  allow_dismiss: true });
                cfpLoadingBar.complete();
                return false;
            }
            if ($scope.modal.middle_name == '' || $scope.modal.middle_name == "" || $scope.modal.middle_name == NaN || $scope.modal.middle_name == null || $scope.modal.middle_name == undefined || $scope.modal.middle_name == 'NaN') {
                var notify = $.notify('Oops there something wrong with the middle name!', {'type': 'danger' ,  allow_dismiss: true });
                cfpLoadingBar.complete();
                return false;
            }
            if ($scope.modal.last_name == '' || $scope.modal.last_name == "" || $scope.modal.last_name == NaN || $scope.modal.last_name == null || $scope.modal.last_name == undefined || $scope.modal.last_name == 'NaN') {
                var notify = $.notify('Oops there something wrong with the last name!', {'type': 'danger' ,  allow_dismiss: true });
                cfpLoadingBar.complete();
                return false;
            }
            if ($scope.modal.email == '' || $scope.modal.email == "" || $scope.modal.email == NaN || $scope.modal.email == null || $scope.modal.email == undefined || $scope.modal.email == 'NaN') {
                var notify = $.notify('Oops there something wrong with the e-mail!', {'type': 'danger' ,  allow_dismiss: true });
                cfpLoadingBar.complete();
                return false;
            }
            if ($scope.modal.contact_number == '' || $scope.modal.contact_number == "" || $scope.modal.contact_number == NaN || $scope.modal.contact_number == null || $scope.modal.contact_number == undefined || $scope.modal.contact_number == 'NaN') {
                var notify = $.notify('Oops there something wrong with the contact number!', {'type': 'danger' ,  allow_dismiss: true });
                cfpLoadingBar.complete();
                return false;
            }
            return nestedConfirmDialog;
        },
        scope: $scope,
        showClose: false
    })
    .then(function(value){
        return false;
    }, function(value){
        cfpLoadingBar.start();
        $scope.modal.last_days = $filter('date')($scope.modal.last_day._d,"yyyy/MM/dd HH:mm");
        $scope.modal.pk = $scope.customer_data[index].pk;
        var promise = ProductFactory.edit_customer($scope.modal);
        promise.then(function(data){
            var notify = $.notify('You have succesfully updated the customer details', { 'type': 'success', allow_dismiss: true });
            get_customer_data();
            cfpLoadingBar.complete();
        })
        .then(null, function(data){
            var notify = $.notify('Oops there is something wrong!', { 'type': 'danger', allow_dismiss: true });
            cfpLoadingBar.complete();
        });
    });
}


$scope.delete_customer = function(v){
    var index = $scope.customer_data.indexOf(v);
    
    $scope.modal = {
        title : 'Are you sure you want to delete this customer?',
        save : 'Delete',
        close : 'Cancel',
        first_name: $scope.customer_data[index].first_name,
        middle_name: $scope.customer_data[index].middle_name,
        last_name: $scope.customer_data[index].last_name,
        email: $scope.customer_data[index].email,
        contact_number: $scope.customer_data[index].contact_number,
        job_position : $scope.customer_data[index].job_position,
        company : $scope.customer_data[index].company,
        last_day : $scope.customer_data[index].last_day
    }     

    ngDialog.openConfirm({
        template: 'ConfirmModal',
        className: 'ngdialog-theme-plain dialogwidth400',
        preCloseCallback: function(value) {
            var nestedConfirmDialog;
            return nestedConfirmDialog;
        },
        scope: $scope,
        showClose: false
    })
    .then(function(value){
        return false;
    }, function(value){
        cfpLoadingBar.start();
        $scope.modal.last_days = $filter('date')($scope.modal.last_day._d,"yyyy/MM/dd HH:mm");
        $scope.modal.pk = $scope.customer_data[index].pk;
        var promise = ProductFactory.delete_customer($scope.modal);
        promise.then(function(data){
            var notify = $.notify('You have succesfully deleted the customer details', { 'type': 'success', allow_dismiss: true });
            get_customer_data();
            cfpLoadingBar.complete();
        })
        .then(null, function(data){
            var notify = $.notify('Oops there is something wrong!', { 'type': 'danger', allow_dismiss: true });
            cfpLoadingBar.complete();
        });
    });
}

$scope.searchmoto = function(){
    search_item();
}

function search_item(){
    cfpLoadingBar.start();
    if ($scope.form.search_item == undefined || $scope.form.search_item == '' || $scope.form.search_item == "") {
        $scope.form.search_item = undefined;
    }

    var filters = {
        wildcard : $scope.form.search_item
    };

    var promise = ProductFactory.get_check_bar_code_item(filters);
    promise.then(function(data){
        $scope.checked_bcode_data = data.data.result;
        $scope.product_checker = data.data.result;
        console.log($scope.checked_bcode_data);
        

        var a = 0;
        for (var i in $scope.checked_bcode_data) {
            $scope.checked_bcode_data[i].product_expiration = new Date($scope.checked_bcode_data[i].product_expiration);
            $scope.checked_bcode_data[i].product_expiration = moment($scope.checked_bcode_data[i].product_expiration).format('LLLL');
            $scope.checked_bcode_data[i].date_created = moment($scope.checked_bcode_data[i].date_created).format('LLLL');
            $scope.checked_bcode_data[i].number = a += 1;
        };

        var x = .12;
        for (var i in $scope.checked_bcode_data) {
            $scope.form.vat_wamount = x * $scope.checked_bcode_data[i].product_srp;
            $scope.checked_bcode_data[i].wamount1 = parseFloat($scope.checked_bcode_data[i].product_srp) + parseFloat($scope.form.vat_wamount);
            $scope.checked_bcode_data[i].wamount3 = parseFloat($scope.checked_bcode_data[i].wamount1).toFixed(2);
            
        };

        for (var z in $scope.checked_bcode_data) {
            if ($scope.checked_bcode_data[z].product_status == '(OLD)') {
                $scope.checked_bcode_data[z].product_status_color = 1;
                $scope.checked_bcode_data[z].product_status_color1 = 'red';
            }
            if ($scope.checked_bcode_data[z].product_status == '(NEW)') {
                $scope.checked_bcode_data[z].product_status_color = 1;
                $scope.checked_bcode_data[z].product_status_color1 = 'green';
            }
        };

        for (var i in $scope.checked_bcode_data) {
           if ($scope.checked_bcode_data[i].product_srp == undefined || $scope.checked_bcode_data[i].product_srp == "undefined" || $scope.checked_bcode_data[i].product_srp == NaN || $scope.checked_bcode_data[i].product_srp == 'NaN' || $scope.checked_bcode_data[i].product_srp == '' || $scope.checked_bcode_data[i].product_srp == "") {
                $scope.checked_bcode_data[i].product_srp = 0;
                $scope.checked_bcode_data[i].wamount3 = 0;
                $scope.checked_bcode_data[i].product_price = 0;
           };
        };

        var b = 0;
        for (var i in $scope.checked_bcode_data) {
            b = parseFloat($scope.checked_bcode_data[i].product_stocks) * parseFloat($scope.checked_bcode_data[i].wamount3); 
            $scope.checked_bcode_data[i].tempo_total = b.toFixed(2);
            /*console.log($scope.checked_bcode_data[i].tempo_total);            
            console.log($scope.checked_bcode_data[i].product_quantity);            
            console.log($scope.checked_bcode_data[i].product_retail_price);*/
        };

        $scope.form.totaaal = 0;
        for (var k in $scope.checked_bcode_data) {
            $scope.form.totaaal += parseFloat($scope.checked_bcode_data[k].tempo_total);
            $scope.form.final_totaal = $scope.form.totaaal.toFixed(2);
            /*console.log($scope.form.totaaal);*/
        };

        for(var i in $scope.product_data){
            if ($scope.product_data[i].product_image == 'undefined' || $scope.product_data[i].product_image == undefined || $scope.product_data[i].product_image == null) {
                $scope.product_data[i].product_image_status = false;
            }else{
                $scope.product_data[i].product_image_status = true;
            }
        };

        $scope.checked_bcode_status = true;

        $scope.totalItems_productdata = $scope.checked_bcode_data.length;
    })
.then(null, function(data){
$scope.checked_bcode_status = false;
cfpLoadingBar.complete();
});
}

$scope.setPage_cbcode_data = function (pageNo) {
    $scope.currentPage_cbcode_data = pageNo;
};

$scope.pageChanged_cbcode_data = function() {
    console.log('Page changed to: ' + $scope.currentPage_cbcode_data);
};

$scope.setItemsPerPage_cbcode_data = function(num) {
    $scope.itemsPerPage_cbcode_data = num;
$scope.currentPage_cbcode_data = 1; //reset to first paghe
}

function get_product_data_expire(){
    cfpLoadingBar.start();
    if ($scope.form.search == "" || $scope.form.search == '') {
        $route.reload();
    }
    var today = new Date();
    var filters = {
        wildcard : $scope.form.search,
        date_from : $filter('date')(new Date(today.getFullYear(), today.getMonth(), today.getDate() - today.getDay()+0),"yyyy-MM-dd"),
        date_to : $filter('date')(new Date(today.getFullYear(), today.getMonth(), today.getDate() - today.getDay()+6),"yyyy-MM-dd")
    };

    var promise = ProductFactory.get_product_data_expire(filters);
    promise.then(function(data){
        $scope.product_data_expire = data.data.result;
        

        var a = 0;
        for (var i in $scope.product_data_expire) {
            $scope.product_data_expire[i].product_expiration = new Date($scope.product_data_expire[i].product_expiration);
            $scope.product_data_expire[i].product_expiration = moment($scope.product_data_expire[i].product_expiration).format('LLLL');
            $scope.product_data_expire[i].date_created = moment($scope.product_data_expire[i].date_created).format('LLLL');
            $scope.product_data_expire[i].number = a += 1;
        };

        var x = .12;
        for (var i in $scope.product_data_expire) {
            $scope.form.vat_wamount = x * $scope.product_data_expire[i].product_srp;
            $scope.product_data_expire[i].wamount1 = parseFloat($scope.product_data_expire[i].product_srp) + parseFloat($scope.form.vat_wamount);
            $scope.product_data_expire[i].wamount3 = parseFloat($scope.product_data_expire[i].wamount1).toFixed(2);

        };

        for (var i in $scope.product_data_expire) {
            if ($scope.product_data_expire[i].product_stocks == "0") {
                $scope.product_data_expire[i].status_exp = 'SOLD OUT';
                $scope.product_data_expire[i].status_exp_color = 'red';
            }

            if ($scope.product_data_expire[i].product_stocks != "0") {
                $scope.product_data_expire[i].status_exp = 'AVAILABLE';
                $scope.product_data_expire[i].status_exp_color = 'green';
            }

        };

        for (var z in $scope.product_data_expire) {
            if ($scope.product_data_expire[z].product_status == '(OLD)') {
                $scope.product_data_expire[z].product_status_color = 1;
                $scope.product_data_expire[z].product_status_color1 = 'red';
            }
            if ($scope.product_data_expire[z].product_status == '(NEW)') {
                $scope.product_data_expire[z].product_status_color = 1;
                $scope.product_data_expire[z].product_status_color1 = 'green';
            }
        };

        for(var i in $scope.product_data){
            if ($scope.product_data[i].product_image == 'undefined' || $scope.product_data[i].product_image == undefined || $scope.product_data[i].product_image == null || $scope.product_data[i].product_image == "null" || $scope.product_data[i].product_image == "" || $scope.product_data[i].product_image == '') {
                $scope.product_data[i].product_image_status = false;
            }else{
                $scope.product_data[i].product_image_status = true;
            }
        };

        $scope.totalItems_productdata_expire = $scope.product_data_expire.length;
    })
.then(null, function(data){

    cfpLoadingBar.complete();
});
}


$scope.print_items_csv = function(){
    window.open('./FUNCTIONS/Uploads/print_csv.php?wildcard='+filters.wildcard+'&wildcard2='+filters.wildcard2+'&wildcard3='+filters.wildcard3
        );
}

/*$scope.check_item = function(){
cfpLoadingBar.start();
    var filters = {
        wildcard : $scope.form.product_bar_code
    };


    var promise = ProductFactory.get_check_item(filters);
    promise.then(function(data){
        $scope.check_item_data_status = true;
        $scope.check_item_data = data.data.result;



        for (var i in $scope.check_item_data) {
            if ($scope.form.product_bar_code == $scope.check_item_data[i].product_bar_code) {
                $scope.form.x = $scope.check_item_data[i].pk;
                $scope.form.product_status_new = '(NEW)';
                $scope.form.product_status_1 = '(NEW/OLD)';
                $scope.add_product();
            };
        };

    })
    .then(null, function(data){
        $scope.check_item_data_status = false;
        $scope.form.product_status = 1; 
        $scope.add_product();
        cfpLoadingBar.complete();
    });
}*/

$scope.search = function(){
    if ($scope.form.search == "") {
        get_product_data();
    }

    filters = {
        wildcard : $scope.form.search,
        wildcard2 : undefined,
        wildcard3 : undefined
    };


    var promise = ProductFactory.get_product_data_search(filters);
    promise.then(function(data){
        $scope.product_data = data.data.result;


        var a = 0;
        for (var i in $scope.product_data) {
            $scope.product_data[i].product_expiration = new Date($scope.product_data[i].product_expiration);
            $scope.product_data[i].product_expiration = moment($scope.product_data[i].product_expiration).format('LLLL');
            $scope.product_data[i].date_created = moment($scope.product_data[i].date_created).format('LLLL');
            $scope.product_data[i].number = a += 1;
        };

        var x = .12;
        for (var i in $scope.product_data) {
            $scope.form.vat_wamount = x * $scope.product_data[i].product_srp;
            $scope.product_data[i].wamount1 = parseFloat($scope.product_data[i].product_srp) + parseFloat($scope.form.vat_wamount);
            $scope.product_data[i].wamount3 = parseFloat($scope.product_data[i].wamount1).toFixed(2);

        };

        for (var z in $scope.product_data) {
            if ($scope.product_data[z].product_status == '(OLD)') {
                $scope.product_data[z].product_status_color = 1;
                $scope.product_data[z].product_status_color1 = 'red';
            }
            if ($scope.product_data[z].product_status == '(NEW)') {
                $scope.product_data[z].product_status_color = 1;
                $scope.product_data[z].product_status_color1 = 'green';
            }
        };

        for (var o in $scope.product_data) {
            if ($scope.product_data[o].request_order_status == "true") {
                $scope.product_data[o].request_order_status = 1;
            }
            if ($scope.product_data[o].request_order_status == null || $scope.product_data[o].request_order_status == "null" || $scope.product_data[o].request_order_status == 'null' && $scope.product_data[o].product_stocks <= "3" && $scope.product_data[o].product_stocks <= 3 && $scope.product_data[o].product_stocks <= '3') {
                $scope.product_data[o].request_order_status = 2;
            }
            if ($scope.product_data[o].request_order_status == 2 || $scope.product_data[o].request_order_status == null || $scope.product_data[o].request_order_status == 'null') {
                $scope.product_data[o].request_order_status = 'false';
            }
        };

        for(var i in $scope.product_data){
            if ($scope.product_data[i].product_image == 'undefined' || $scope.product_data[i].product_image == undefined || $scope.product_data[i].product_image == null || $scope.product_data[i].product_image == "null" || $scope.product_data[i].product_image == "" || $scope.product_data[i].product_image == '') {
                $scope.product_data[i].product_image_status = false;
            }else{
                $scope.product_data[i].product_image_status = true;
            }
        };

        $scope.totalItems_productdata = $scope.product_data.length;
    })
.then(null, function(data){

});
}
$scope.setPage_productdata = function (pageNo) {
    $scope.currentPage_productdata = pageNo;
};

$scope.pageChanged_productdata = function() {
    console.log('Page changed to: ' + $scope.currentPage_productdata);
};

$scope.setItemsPerPage_productdata = function(num) {
    $scope.itemsPerPage_productdata = num;
$scope.currentPage_productdata = 1; //reset to first paghe
};

$scope.complete_request = function(product_id) {
    cfpLoadingBar.start();
    var promise = ProductFactory.complete_request(product_id);
    promise.then(function(data){
        get_product_data();
        cfpLoadingBar.complete();
    })
};

function get_product_data(){
    cfpLoadingBar.start();
    var promise = ProductFactory.get_product_data();
    promise.then(function(data){
        $scope.product_data = data.data.result;

        var a = 0;
        for (var i in $scope.product_data) {
            $scope.product_data[i].product_expiration = new Date($scope.product_data[i].product_expiration);
            $scope.product_data[i].product_expiration = moment($scope.product_data[i].product_expiration).format('LLLL');
            $scope.product_data[i].date_created = moment($scope.product_data[i].date_created).format('LLLL');
            $scope.product_data[i].number = a += 1;
        };

        var x = .12;
        for (var i in $scope.product_data) {
            $scope.form.vat_wamount = x * $scope.product_data[i].product_srp;
            $scope.product_data[i].wamount1 = parseFloat($scope.product_data[i].product_srp) + parseFloat($scope.form.vat_wamount);
            $scope.product_data[i].wamount3 = parseFloat($scope.product_data[i].wamount1).toFixed(2);

        };

        for (var z in $scope.product_data) {
            if ($scope.product_data[z].product_status == '(OLD)') {
                $scope.product_data[z].product_status_color = 1;
                $scope.product_data[z].product_status_color1 = 'red';
            }
            if ($scope.product_data[z].product_status == '(NEW)') {
                $scope.product_data[z].product_status_color = 1;
                $scope.product_data[z].product_status_color1 = 'green';
            }
            if ($scope.product_data[z].remarks == null || $scope.product_data[z].remarks == 'Good Merchandise') {
                $scope.product_data[z].remarks_color = 'green';
                $scope.product_data[z].remarks = 'Good Merchandise'
            }
            if ($scope.product_data[z].remarks != 'Good Merchandise') {
                $scope.product_data[z].remarks_color = 'red';
                $scope.product_data[z].remarks = 'Bad Merchandise'
            }
        };

        for (var o in $scope.product_data) {
            if ($scope.product_data[o].request_order_status == "true") {
                $scope.product_data[o].request_order_status = 1;
            };
            if ($scope.product_data[o].request_order_status == null && $scope.product_data[o].product_stocks <= "3" && $scope.product_data[o].product_stocks <= 3 && $scope.product_data[o].product_stocks <= '3') {
                $scope.product_data[o].request_order_status = 2;
            };
            if ($scope.product_data[o].request_order_status == 2) {
                $scope.product_data[o].request_order_status = 'false';
            }
        };

        for(var i in $scope.product_data){
            if ($scope.product_data[i].product_image == 'undefined' || $scope.product_data[i].product_image == undefined || $scope.product_data[i].product_image == null || $scope.product_data[i].product_image == "null" || $scope.product_data[i].product_image == "" || $scope.product_data[i].product_image == '') {
                $scope.product_data[i].product_image_status = false;
            }else{
                $scope.product_data[i].product_image_status = true;
            }
        };

        $scope.totalItems_productdata = $scope.product_data.length;
    })
.then(null, function(data){

    cfpLoadingBar.complete();
});
}
$scope.setPage_productdata = function (pageNo) {
    $scope.currentPage_productdata = pageNo;
};

$scope.pageChanged_productdata = function() {
    console.log('Page changed to: ' + $scope.currentPage_productdata);
};

$scope.setItemsPerPage_productdata = function(num) {
    $scope.itemsPerPage_productdata = num;
$scope.currentPage_productdata = 1; //reset to first paghe
}

function get_rule_data(){
    cfpLoadingBar.start();
    var promise = ProductFactory.get_rule_data();
    promise.then(function(data){
        $scope.rule_data = data.data.result;


        var a = 0;
        for (var i in $scope.rule_data) {
            $scope.rule_data[i].date_created = new Date($scope.rule_data[i].date_created);
            $scope.rule_data[i].number = a += 1;
        };

        $scope.totalItems_ruledata = $scope.rule_data.length;
    })
    .then(null, function(data){

        cfpLoadingBar.complete();
    });
}

function get_supplier_data(){
    cfpLoadingBar.start();
    var promise = ProductFactory.get_supplier_data();
    promise.then(function(data){
        $scope.supplier_data = data.data.result;
        /*console.log($scope.supplier_data);*/

        var a = 0;
        for (var i in $scope.supplier_data) {
            $scope.supplier_data[i].date_created = new Date($scope.supplier_data[i].date_created);
            $scope.supplier_data[i].number = a += 1;
        };

        $scope.totalItems_supplierdata = $scope.supplier_data.length;

    })
    .then(null, function(data){

        cfpLoadingBar.complete();
    });
}

$scope.edit_product_data = function(v){

    var x = v;
    var index2 = $scope.checked_bcode_data.indexOf(v);
    for (var i in $scope.product_checker) {
        if ($scope.product_checker[i].product_name == $scope.product_data[index2].product_name) {

            $scope.edit_product_data(x);
        }
    };

    
}
$scope.edit_product_data = function(v){

    var index = $scope.product_data.indexOf(v);

    $scope.modal = {
        title : 'Update Product',
        save : 'Update',
        close : 'Cancel',
        product_name : $scope.product_data[index].product_name,
        product_bar_code : $scope.product_data[index].product_bar_code,
        product_stocks : $scope.product_data[index].product_stocks,
        product_price : $scope.product_data[index].product_price,
        product_expiration : $scope.product_data[index].product_expiration,
        product_srp : $scope.product_data[index].product_srp,
        product_supplier : $scope.product_data[index].product_supplier,
        receipt_name : $scope.product_data[index].product_receipt_name,
        or_number : $scope.product_data[index].product_or_number,
        product_product_code : $scope.product_data[index].product_product_code,
        product_rule : $scope.product_data[index].product_rules,
        product_kinds : $scope.product_data[index].product_kind,
        image_source : $scope.product_data[index].product_image,
        product_branches : $scope.product_data[index].product_branches


    };

    ngDialog.openConfirm({
        template: 'EditMyProfile',
        className: 'ngdialog-theme-plain dialogwidth500',
        preCloseCallback: function(value) {
            var nestedConfirmDialog;
            if($scope.modal.product_name == '' || $scope.modal.product_bar_code == '' || $scope.modal.product_stocks == '' || $scope.modal.product_price == ''){

                var notify = $.notify('There is a blank encoded product data', {'type': 'danger', allow_dismiss: true });
                return false;
            }
            return nestedConfirmDialog;
        },
        scope: $scope,
        showClose: false
    })
    .then(function(value){
        return false;
    }, function(value){

        cfpLoadingBar.start();
        $scope.modal.new_product_date_expirations = $filter('date')($scope.modal.product_expiration._d, "mediumDate");
        $scope.form.input_vat1 = $scope.modal.product_srp * .12;
        $scope.form.input_vat2 = parseFloat($scope.form.input_vat1).toFixed(2);
        //Markup Price is Product Price
        //VAT Output is based on Branch VAT Registered or Not
        for(var branches in $scope.branch_data){
            if ($scope.modal.product_branches == $scope.branch_data[branches].branch_name) {
                $scope.form.vat_register_option = $scope.branch_data[branches].vat_registered;
            }
        }
        if ($scope.form.vat_register_option == 't') {
            $scope.modal.product_price = parseInt($scope.modal.product_price);
            $scope.form.output_vat1 = $scope.modal.product_price * .12;
            $scope.form.output_vat2 = $scope.form.output_vat1;
            $scope.form.selling_price1 = $scope.modal.product_price + $scope.form.output_vat2;
            // $scope.form.selling_price2 = modal($scope.form.selling_price1).toFixed(2);
        }else{
            $scope.form.output_vat1 = 0;
            $scope.form.output_vat2 = 0;
            $scope.form.selling_price1 = $scope.modal.product_price;
        }
        
        var datas = {
            pk : $scope.product_data[index].pk,
            product_name : $scope.modal.product_name,
            product_srp : $scope.modal.product_srp,
            product_bar_code : $scope.modal.product_bar_code,
            product_stocks : $scope.modal.product_stocks,
            product_price : $scope.modal.product_price,
            product_expiration : $scope.modal.new_product_date_expirations,
            supplier_code_name : $scope.modal.supplier_code_name,
            product_supplier : $scope.modal.product_supplier,
            product_receipt_name : $scope.modal.receipt_name,
            product_or_number : $scope.modal.or_number,
            product_product_code : $scope.modal.product_product_code,
            product_rule : $scope.modal.product_rule,
            product_kinds : $scope.modal.product_kinds,
            product_image : $scope.modal.image_source,
            cashier_user_id : $scope.user.user_id,
            input_vat : $scope.form.input_vat1,
            output_vat : $scope.form.output_vat2,
            selling_price:$scope.form.selling_price1,
            name : 'Product Edit',
            action : ' '+$scope.user.first_name+ ' ' +$scope.user.last_name+ ' ' +'edited'+' '+$scope.modal.product_name
        }
        
        var promise = ProductFactory.edit_product_data(datas);
        promise.then(function(data){
            var notify = $.notify('You have succesfully updated the product', { 'type': 'success', allow_dismiss: true });
            get_product_data();
            cfpLoadingBar.complete();
        })
        .then(null, function(data){
            var notify = $.notify('Oops there something wrong!', { 'type': 'danger', allow_dismiss: true });
            cfpLoadingBar.complete();
        });
    });
}
$scope.update_data_checker = function(v){

    var x = v;

    var index2 = $scope.checked_bcode_data.indexOf(v);
    for (var i in $scope.product_checker) {
        if ($scope.product_checker[i].product_name == $scope.checked_bcode_data[index2].product_name) {

            $scope.update_data_checkers(x);
        }
    };
    
}
$scope.update_data_checkers = function(x){
    
    var index = $scope.checked_bcode_data.indexOf(x);
    
    $scope.modal = {
        title : 'Update Product',
        save : 'Update',
        close : 'Cancel',
        product_name : $scope.checked_bcode_data[index].product_name,
        product_bar_code : $scope.checked_bcode_data[index].product_bar_code,
        product_stocks : $scope.checked_bcode_data[index].product_stocks,
        product_price : $scope.checked_bcode_data[index].product_price,
        product_expiration : $scope.checked_bcode_data[index].product_expiration,
        product_srp : $scope.checked_bcode_data[index].product_srp,
        product_supplier : $scope.checked_bcode_data[index].product_supplier,
        receipt_name : $scope.checked_bcode_data[index].product_receipt_name,
        or_number : $scope.checked_bcode_data[index].product_or_number,
        product_product_code : $scope.checked_bcode_data[index].product_product_code,
        product_rule : $scope.checked_bcode_data[index].product_rules,
        product_kinds : $scope.checked_bcode_data[index].product_kind


    };

    ngDialog.openConfirm({
        template: 'EditMyBarcode',
        className: 'ngdialog-theme-plain dialogwidth500',
        preCloseCallback: function(value) {
            var nestedConfirmDialog;
            if($scope.modal.product_name == '' || $scope.modal.product_bar_code == '' || $scope.modal.product_stocks == '' || $scope.modal.product_price == ''){

                var notify = $.notify('There is a blank encoded product data', {'type': 'danger', allow_dismiss: true });
                return false;
            }
            return nestedConfirmDialog;
        },
        scope: $scope,
        showClose: false
    })
    .then(function(value){
        return false;
    }, function(value){

cfpLoadingBar.start();
        $scope.modal.new_product_date_expirations = $filter('date')($scope.modal.product_expiration._d, "mediumDate");
        $scope.datass.a = $scope.checked_bcode_data[index].product_kind;
            if ($scope.modal.product_kinds != $scope.datass.a) {
                $scope.hehe.old_prdkinds = $scope.checked_bcode_data[index].product_kind;
                $scope.modal.product_kinds = $scope.modal.product_kinds;
                $scope.hehe.pr_status = true;
            }else{
                $scope.hehe.old_prdkinds = $scope.modal.product_kinds;
            };
            if ($scope.modal.product_rule != $scope.checked_bcode_data[index].product_rules) {
                $scope.hehe.old_prdrule = $scope.checked_bcode_data[index].product_rules;
                $scope.modal.product_rule = $scope.modal.product_rule;
                $scope.hehe.pr_status = true;
            }else{
                $scope.hehe.old_prdrule = $scope.modal.product_rule;
            };
            if ($scope.modal.product_product_code != $scope.checked_bcode_data[index].product_product_code) {
                $scope.hehe.old_prdcode = $scope.checked_bcode_data[index].product_product_code;
                $scope.modal.product_product_code = $scope.modal.product_product_code;
                $scope.hehe.pr_status = true;
            }else{
                $scope.hehe.old_prdcode = $scope.modal.product_product_code;
            };
            if ($scope.modal.product_name != $scope.checked_bcode_data[index].product_name) {
                $scope.hehe.old_name = $scope.checked_bcode_data[index].product_name;
                $scope.modal.product_name = $scope.modal.product_name;
                $scope.hehe.pr_status = true;
            }else{
                $scope.hehe.old_name = $scope.modal.product_name;
            };
            if ($scope.modal.product_bar_code != $scope.checked_bcode_data[index].product_bar_code) {
                $scope.hehe.old_brcode = $scope.checked_bcode_data[index].product_bar_code;
                $scope.modal.product_bar_code = $scope.modal.product_bar_code;
                $scope.hehe.pr_status = true;
            }else{
                $scope.hehe.old_brcode = $scope.modal.product_bar_code;
            };
            if ($scope.modal.product_stocks != $scope.checked_bcode_data[index].product_stocks) {
                $scope.hehe.old_ps = $scope.checked_bcode_data[index].product_stocks;
                $scope.modal.product_stocks = $scope.modal.product_stocks;
                $scope.hehe.pr_status = true;
            }else{
                $scope.hehe.old_ps = $scope.modal.product_stocks;
            };
            if ($scope.modal.product_price != $scope.checked_bcode_data[index].product_price) {
                $scope.hehe.old_pprice = $scope.checked_bcode_data[index].product_price;
                $scope.modal.product_price = $scope.modal.product_price;
                $scope.hehe.pr_status = true;
            }else{
                $scope.hehe.old_pprice = $scope.modal.product_price;
            };
            if ($scope.modal.product_expiration != $scope.checked_bcode_data[index].product_expiration) {
                $scope.hehe.old_pexp = $scope.checked_bcode_data[index].product_expiration;
                $scope.modal.product_expiration = $scope.modal.product_expiration;
                $scope.hehe.pr_status = true;
            }else{
                $scope.hehe.old_pexp = $scope.modal.product_expiration;
            };
            if ($scope.modal.product_srp != $scope.checked_bcode_data[index].product_srp) {
                $scope.hehe.old_srp = $scope.checked_bcode_data[index].product_srp;
                $scope.modal.product_srp = $scope.modal.product_srp;
                $scope.hehe.pr_status = true;
            }else{
                $scope.hehe.old_srp = $scope.modal.product_srp;
            };
            if ($scope.modal.product_supplier != $scope.checked_bcode_data[index].product_supplier) {
                $scope.hehe.old_prdsup = $scope.checked_bcode_data[index].product_supplier;
                $scope.modal.product_supplier = $scope.modal.product_supplier;
                $scope.hehe.pr_status = true;
            }else{
                $scope.hehe.old_prdsup = $scope.modal.product_supplier;
            };
            if ($scope.modal.product_receipt_name != $scope.checked_bcode_data[index].product_receipt_name) {
                $scope.hehe.old_rname = $scope.checked_bcode_data[index].product_receipt_name;
                $scope.modal.product_receipt_name = $scope.modal.product_receipt_name;
                $scope.hehe.pr_status = true;
            }else{
                $scope.hehe.old_rname = $scope.modal.product_receipt_name;
            };
            if ($scope.modal.product_or_number != $scope.checked_bcode_data[index].product_or_number) {
                $scope.hehe.old_ornum = $scope.checked_bcode_data[index].product_or_number;
                $scope.modal.product_or_number = $scope.modal.product_or_number;
                $scope.hehe.pr_status = true;
            }else{
                $scope.hehe.old_ornum = $scope.modal.product_or_number;
            };

        /*for (var i in $scope.checked_bcode_data) {
            if ($scope.modal.product_kinds == $scope.checked_bcode_data[i].product_kind) {
                $scope.hehe.old_prdkinds = $scope.modal.product_kinds;
                console.log($scope.hehe.old_prdkinds);
            }
            if ($scope.modal.product_name == $scope.checked_bcode_data[i].product_name) {
                $scope.hehe.old_name = $scope.modal.product_name;
                console.log($scope.hehe.old_name);
            }
            if ($scope.modal.product_bar_code == $scope.checked_bcode_data[i].product_bar_code) {
                $scope.hehe.old_brcode = $scope.modal.product_bar_code;
                console.log($scope.hehe.old_brcode);
            }
            if ($scope.modal.product_product_code == $scope.checked_bcode_data[i].product_product_code) {
                $scope.hehe.old_prdcode = $scope.modal.product_product_code;
                console.log($scope.hehe.old_prdcode);
            }
            if ($scope.modal.product_rule == $scope.checked_bcode_data[i].product_rules) {
                $scope.hehe.old_prdrule = $scope.modal.product_rule;
                console.log($scope.hehe.old_prdrule);
            }
            if ($scope.modal.product_stocks == $scope.checked_bcode_data[i].product_stocks) {
                $scope.hehe.old_ps = $scope.modal.product_stocks;
                console.log($scope.hehe.old_ps);
            }
            if ($scope.modal.product_price == $scope.checked_bcode_data[i].product_price) {
                $scope.hehe.old_pprice = $scope.modal.product_price;
                console.log($scope.hehe.old_pprice);
            }
            if ($scope.modal.product_expiration == $scope.checked_bcode_data[i].product_expiration) {
                $scope.hehe.old_pexp = $scope.modal.product_expiration;
                console.log($scope.hehe.old_pexp);
            }
            if ($scope.modal.product_srp == $scope.checked_bcode_data[i].product_srp) {
                $scope.hehe.old_srp = $scope.modal.product_srp;
                console.log($scope.hehe.old_srp);
            }
            if ($scope.modal.product_supplier == $scope.checked_bcode_data[i].product_supplier) {
                $scope.hehe.old_prdsup = $scope.modal.product_supplier;
                console.log($scope.hehe.old_prdsup);
            }
            if ($scope.modal.product_receipt_name == $scope.checked_bcode_data[i].product_receipt_name) {
                $scope.hehe.old_rname = $scope.modal.product_receipt_name;
                console.log($scope.hehe.old_rname);
            }
            if ($scope.modal.product_or_number == $scope.checked_bcode_data[i].product_or_number) {
                $scope.hehe.old_ornum = $scope.modal.product_or_number;
                console.log($scope.hehe.old_ornum);
            }
        };*/

        var datas = {
            pk : $scope.checked_bcode_data[index].pk,
            product_name : $scope.modal.product_name,
            product_srp : $scope.modal.product_srp,
            product_bar_code : $scope.modal.product_bar_code,
            product_stocks : $scope.modal.product_stocks,
            product_price : $scope.modal.product_price,
            product_expiration : $scope.modal.new_product_date_expirations,
            product_supplier : $scope.modal.product_supplier,
            product_receipt_name : $scope.modal.receipt_name,
            product_or_number : $scope.modal.or_number,
            product_product_code : $scope.modal.product_product_code,
            product_rule : $scope.modal.product_rule,
            product_kinds : $scope.modal.product_kinds,
            product_old_prdkinds: $scope.hehe.old_prdkinds,
            product_old_name: $scope.hehe.old_name,
            product_old_prdrule: $scope.hehe.old_prdrule,
            product_old_prdcode: $scope.hehe.old_prdcode,
            product_old_brcode: $scope.hehe.old_brcode,
            product_old_pprice: $scope.hehe.old_pprice,
            product_old_pexp: $scope.hehe.old_pexp,
            product_old_srp: $scope.hehe.old_srp,
            product_old_ps: $scope.hehe.old_ps,
            product_old_rname: $scope.hehe.old_rname,
            product_old_prdsup: $scope.hehe.old_prdsup,
            product_old_ornum: $scope.hehe.old_ornum,
            product_pr_status : $scope.hehe.pr_status,
            cashier_user_id : $scope.user.user_id,
            name : 'Duplication',
            action : ' '+$scope.user.first_name+ ' ' +$scope.user.last_name+ ' ' +'duplicated'+' '+$scope.modal.product_name
        }

        var promise = ProductFactory.edit_product_data_bc(datas);
        promise.then(function(data){
            var notify = $.notify('You have succesfully updated the product', { 'type': 'success', allow_dismiss: true });
            $scope.search_item();
            cfpLoadingBar.complete();
        })
        .then(null, function(data){
            var notify = $.notify('Oops there something wrong!', { 'type': 'danger', allow_dismiss: true });
            cfpLoadingBar.complete();
        });
    });
}
$scope.send_remarks = function(v){
    var index = $scope.checked_bcode_data.indexOf(v);

    $scope.modal = {
        title : 'Send Remarks via E-Mail',
        save : 'Send',
        close : 'Cancel'
    };

    ngDialog.openConfirm({
        template: 'SendEmailRequest',
        className: 'ngdialog-theme-plain dialogwidthpat',
        scope: $scope,
        showClose: false
    })
    .then(function(value){
        return false;
    }, function(value){
        cfpLoadingBar.start();

        $scope.submit_datas = {
            pk : $scope.checked_bcode_data[index].pk,
            remarks : $scope.form.remarks,
            email : $scope.user.email,
            message: '<p>Good Day '+$scope.checked_bcode_data[index].first_name+' '+$scope.checked_bcode_data[index].last_name+',</p><p>&nbsp;</p><p>I rejected your product request order because of the reason that '+$scope.form.remarks+'</p><p>&nbsp;</p><p>Warm Regards,</p><p>'+$scope.user.first_name+' '+$scope.user.last_name+'</p>'
        };

        var notify = $.notify('Please wait for the E-mail to be send', { 'type': 'warning', allow_dismiss: true });

        var promise = ProductFactory.send_remarks($scope.submit_datas);
        promise.then(function(data){
            var notify = $.notify('You have succesfully send the E-mail', { 'type': 'success', allow_dismiss: true });
            get_request_order_data();
            cfpLoadingBar.complete();
        })
        .then(null, function(data){
            var notify = $.notify('Oops there something wrong!', { 'type': 'danger', allow_dismiss: true });
            get_request_order_data();
            cfpLoadingBar.complete();
        });

    });

}


$scope.delete_product_data = function(v){
    
    var index = $scope.checked_bcode_data.indexOf(v);


    $scope.modal = {
        title : 'Please input a pin',
        save : 'Delete',
        close : 'Cancel'
    }     

    ngDialog.openConfirm({
        template: 'InputPinModal',
        className: 'ngdialog-theme-plain dialogwidth400',
        preCloseCallback: function(value) {
            var nestedConfirmDialog;
            $scope.form.pin = md5.createHash($scope.modal.pin);
            if($scope.form.pin != $scope.user.superior_pin){
                var notify = $.notify('The Pin is incorrect!', {'type': 'danger', allow_dismiss: true });
                return false;
            }
            return nestedConfirmDialog;
        },
        scope: $scope,
        showClose: false
    })
    .then(function(value){
        return false;
    }, function(value){
cfpLoadingBar.start();
        var datas = {
            pk : $scope.checked_bcode_data[index].pk
        }


        var promise = ProductFactory.delete_product_data(datas);
        promise.then(function(data){
            var notify = $.notify('You have succesfully deleted the product', { 'type': 'success', allow_dismiss: true });
            get_product_data();
            cfpLoadingBar.complete();
        })
        .then(null, function(data){
            var notify = $.notify('Oops there is something wrong!', { 'type': 'danger', allow_dismiss: true });
            cfpLoadingBar.complete();
        });
    });
}

function makeid() {
    var text = "";
    var text2 = "";
    var text3 = "";
    var finalnumber = "";

    var possible = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    var possible2 = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";

    for (var i = 0; i < 5; i++){
        text += possible.charAt(Math.floor(Math.random() * possible.length));
        text2 += possible2.charAt(Math.floor(Math.random() * possible2.length));
    }
    finalnumber = text+"-"+text2;
    $scope.form.finalnumber = finalnumber;
}

$scope.approve_order_request = function(v){
    cfpLoadingBar.start();
    var index = $scope.request_data.indexOf(v);


    var datas = {
        pk : $scope.request_data[index].pk
    }


    var promise = ProductFactory.approve_order_request(datas);
    promise.then(function(data){
        var notify = $.notify('You have succesfully approved the request order', { 'type': 'success', allow_dismiss: true });
        cfpLoadingBar.complete();
    })
    .then(null, function(data){
        var notify = $.notify('Oops there something wrong!', { 'type': 'danger', allow_dismiss: true });
        cfpLoadingBar.complete();
    });
}

$scope.disapprove_order_request = function(v){
    cfpLoadingBar.start();
    var index = $scope.request_data.indexOf(v);


    var datas = {
        pk : $scope.request_data[index].pk
    }


    var promise = ProductFactory.disapprove_order_request(datas);
    promise.then(function(data){
        var notify = $.notify('You have succesfully disapproved the request order', { 'type': 'success', allow_dismiss: true });
        cfpLoadingBar.complete();
    })
    .then(null, function(data){
        var notify = $.notify('Oops there something wrong!', { 'type': 'danger', allow_dismiss: true });
        cfpLoadingBar.complete();
    });
}
$scope.print_items = function(){
    window.open('./FUNCTIONS/Uploads/print_items.php?wildcard='+filters.wildcard+'&wildcard2='+filters.wildcard2+'&wildcard3='+filters.wildcard3
        );
}
$scope.print_items_csv = function(){
    window.open('./FUNCTIONS/Uploads/print_csv.php?wildcard='+filters.wildcard+'&wildcard2='+filters.wildcard2+'&wildcard3='+filters.wildcard3
        );
}
$scope.upload_image_product = function(){

    $scope.modal = {
        title : 'Upload Image',
        close : 'Close'
    };

    ngDialog.openConfirm({
        template: 'UploadModal',
        className: 'ngdialog-theme-plain dialog_for_uploading_product_img',
        preCloseCallback: function(value) {
            var nestedConfirmDialog;
            return nestedConfirmDialog;
        },
        scope: $scope,
        showClose: false
    })
    .then(function(value){
        return false;
    }, function(value){

        var promise = ProductFactory.edit_product_data(datas);
        promise.then(function(data){
            var notify = $.notify('You have succesfully updated the product', { 'type': 'success', allow_dismiss: true });
            get_product_data();
            cfpLoadingBar.complete();
        })
        .then(null, function(data){
            var notify = $.notify('Oops there something wrong!', { 'type': 'danger', allow_dismiss: true });
            cfpLoadingBar.complete();
        });
    });
}

$scope.edit_product_data = function(v){
    
    var index = $scope.product_data.indexOf(v);

    $scope.modal = {
        title : 'Update Product',
        save : 'Update',
        close : 'Cancel',
        product_name : $scope.product_data[index].product_name,
        product_bar_code : $scope.product_data[index].product_bar_code,
        product_stocks : $scope.product_data[index].product_stocks,
        product_price : $scope.product_data[index].product_price,
        product_expiration : $scope.product_data[index].product_expiration,
        product_srp : $scope.product_data[index].product_srp,
        product_supplier : $scope.product_data[index].product_supplier,
        receipt_name : $scope.product_data[index].product_receipt_name,
        or_number : $scope.product_data[index].product_or_number,
        product_product_code : $scope.product_data[index].product_product_code,
        product_rule : $scope.product_data[index].product_rules,
        product_kinds : $scope.product_data[index].product_kind,
        image_source : $scope.product_data[index].product_image,
        product_branches : $scope.product_data[index].product_branche


    };

    ngDialog.openConfirm({
        template: 'EditMyProfile',
        className: 'ngdialog-theme-plain dialogwidth500',
        preCloseCallback: function(value) {
            var nestedConfirmDialog;
            if($scope.modal.product_name == '' || $scope.modal.product_bar_code == '' || $scope.modal.product_stocks == '' || $scope.modal.product_price == ''){

                var notify = $.notify('There is a blank encoded product data', {'type': 'danger', allow_dismiss: true });
                return false;
            }
            return nestedConfirmDialog;
        },
        scope: $scope,
        showClose: false
    })
    .then(function(value){
        return false;
    }, function(value){

cfpLoadingBar.start();
        $scope.form.input_vat1 = $scope.modal.product_srp * .12;
        $scope.form.input_vat2 = parseFloat($scope.form.input_vat1).toFixed(2);
        //Markup Price is Product Price
        //VAT Output is based on Branch VAT Registered or Not
        for(var branches in $scope.branch_data){
            if ($scope.modal.product_branches == $scope.branch_data[branches].branch_name) {
                $scope.form.vat_register_option = $scope.branch_data[branches].vat_registered;
            }
        }
        if ($scope.form.vat_register_option == 't') {
            $scope.modal.product_price = parseInt($scope.modal.product_price);
            $scope.form.output_vat1 = $scope.modal.product_price * .12;
            $scope.form.output_vat2 = $scope.form.output_vat1;
            $scope.form.selling_price1 = $scope.modal.product_price + $scope.form.output_vat2;
            // $scope.form.selling_price2 = modal($scope.form.selling_price1).toFixed(2);
        }else{
            $scope.form.output_vat1 = 0;
            $scope.form.output_vat2 = 0;
            $scope.form.selling_price1 = $scope.modal.product_price;
        }

        var datas = {
            pk : $scope.product_data[index].pk,
            product_name : $scope.modal.product_name,
            product_srp : $scope.modal.product_srp,
            product_bar_code : $scope.modal.product_bar_code,
            product_stocks : $scope.modal.product_stocks,
            product_price : $scope.modal.product_price,
            product_expiration : $scope.modal.new_product_date_expirations_2,
            supplier_code_name : $scope.modal.supplier_code_name,
            product_supplier : $scope.modal.product_supplier,
            product_receipt_name : $scope.modal.receipt_name,
            product_or_number : $scope.modal.or_number,
            product_product_code : $scope.modal.product_product_code,
            product_rule : $scope.modal.product_rule,
            product_kinds : $scope.modal.product_kinds,
            product_image : $scope.modal.image_source,
            cashier_user_id : $scope.user.user_id,
            input_vat : $scope.form.input_vat1,
            output_vat : $scope.form.output_vat2,
            selling_price:$scope.form.selling_price1,
            name : 'Product Edit',
            action : ' '+$scope.user.first_name+ ' ' +$scope.user.last_name+ ' ' +'edited'+' '+$scope.modal.product_name
        }

        var promise = ProductFactory.edit_product_data(datas);
        promise.then(function(data){
            var notify = $.notify('You have succesfully updated the product', { 'type': 'success', allow_dismiss: true });
            get_product_data();
            cfpLoadingBar.complete();
        })
        .then(null, function(data){
            var notify = $.notify('Oops there something wrong!', { 'type': 'danger', allow_dismiss: true });
            cfpLoadingBar.complete();
        });
    });
}

$scope.request_product_order = function(v){
    
    var index = $scope.product_data.indexOf(v);
    makeid();

    $scope.modal = {
        title : 'Request Product Order',
        save : 'Request',
        close : 'Cancel',
        finalnumber : $scope.form.finalnumber
    };

    ngDialog.openConfirm({
        template: 'RequestOrderDataModal',
        className: 'ngdialog-theme-plain dialogwidth400',
        preCloseCallback: function(value) {
            var nestedConfirmDialog;
            if($scope.modal.product_quantity == '' || $scope.modal.product_date_needed == '' || $scope.modal.product_market_price == ''
                || $scope.modal.product_quantity == "" || $scope.modal.product_date_needed == "" || $scope.modal.product_market_price == ""
                || $scope.modal.product_quantity == null || $scope.modal.product_date_needed == null || $scope.modal.product_market_price == null
                || $scope.modal.product_quantity == undefined || $scope.modal.product_date_needed == undefined || $scope.modal.product_market_price == undefined
                ){
                var notify = $.notify('Request orders will not proceed if there is an absence of data', {'type': 'danger', allow_dismiss: true });
            return false;
        }
        return nestedConfirmDialog;
    },
    scope: $scope,
    showClose: false
})
.then(function(value){
    return false;
}, function(value){
    cfpLoadingBar.start();
    $scope.modal.new_product_date_needed = $filter('date')($scope.modal.product_date_needed._d, "medium");
    var datas = {
        pk : $scope.product_data[index].pk,
        product_name : $scope.product_data[index].product_name,
        product_finalnumber : $scope.modal.finalnumber,
        product_quantity : $scope.modal.product_quantity,
        product_date_needed : $scope.modal.new_product_date_needed,
        product_market_price : $scope.modal.product_market_price,
        user_pk : $scope.user.pk,
        request_order_status : true,
        message : '<p>Good Day Sir Wayne,</p><p>&nbsp;</p><p>I have already sent a product order for '+ $scope.product_data[index].product_name +' in BunnyPOS with a quantity of '+ $scope.modal.product_quantity +', thanks</p><p>&nbsp;</p><p>Warm Regards,</p><p>'+$scope.user.first_name+' '+$scope.user.last_name +'</p>',
        cashier_user_id : $scope.user.user_id,
        name : 'Product Order',
        action : ' '+$scope.user.first_name+ ' ' +$scope.user.last_name+ ' ' +'requested for an order of'+' '+$scope.product_data[index].product_name
    }

    var notify = $.notify('Please wait while the system is sending your request', { 'type': 'warning', allow_dismiss: true });

    var promise = ProductFactory.request_product_order(datas);
    promise.then(function(data){
        var notify = $.notify('You have succesfully requested the product', { 'type': 'success', allow_dismiss: true });
        get_request_order_data();
        get_product_data();
        $route.reload();
        cfpLoadingBar.complete();
        return;
    })
    .then(null, function(data){
        get_product_data();
    });
});
}

$scope.delete_product_data = function(v){
    
    var index = $scope.product_data.indexOf(v);


    $scope.modal = {
        title : 'Please input a pin',
        save : 'Delete',
        close : 'Cancel'
    }     

    ngDialog.openConfirm({
        template: 'InputPinModal',
        className: 'ngdialog-theme-plain dialogwidth400',
        preCloseCallback: function(value) {
            var nestedConfirmDialog;
            $scope.form.pin = md5.createHash($scope.modal.pin);
            if($scope.form.pin != $scope.user.superior_pin){
                var notify = $.notify('The Pin is incorrect!', {'type': 'danger', allow_dismiss: true });
                return false;
            }
            return nestedConfirmDialog;
        },
        scope: $scope,
        showClose: false
    })
    .then(function(value){
        return false;
    }, function(value){
cfpLoadingBar.start();
        var datas = {
            pk : $scope.product_data[index].pk
        }


        var promise = ProductFactory.delete_product_data(datas);
        promise.then(function(data){
            var notify = $.notify('You have succesfully deleted the product', { 'type': 'success', allow_dismiss: true });
            get_product_data();
            cfpLoadingBar.complete();
        })
        .then(null, function(data){
            var notify = $.notify('Oops there is something wrong!', { 'type': 'danger', allow_dismiss: true });
            cfpLoadingBar.complete();
        });
    });
}

$scope.refund = function(v){

    var index = $scope.product_data.indexOf(v);

    $scope.modal = {
        title : 'Exchange Product',
        save : 'Exchange',
        close : 'Cancel',
        product_name : $scope.product_data[index].product_name,
        product_bar_code : $scope.product_data[index].product_bar_code,
        product_price : $scope.product_data[index].product_price,
        product_expiration : $scope.product_data[index].product_expiration,
        product_srp : $scope.product_data[index].product_srp,
        product_supplier : $scope.product_data[index].product_supplier,
        receipt_name : $scope.product_data[index].product_receipt_name,
        or_number : $scope.product_data[index].product_or_number,
        product_product_code : $scope.product_data[index].product_product_code,
        product_rule : $scope.product_data[index].product_rules,
        product_kinds : $scope.product_data[index].product_kind


    };
    ngDialog.openConfirm({
        template: 'RefundModal',
        className: 'ngdialog-theme-plain dialogwidth500',
        preCloseCallback: function(value) {
            var nestedConfirmDialog;
            $scope.form.pin = md5.createHash($scope.modal.pin);
            if($scope.form.pin != $scope.user.superior_pin){
                var notify = $.notify('The Pin is incorrect!', {'type': 'danger', allow_dismiss: true });
                return false;
            }
            return nestedConfirmDialog;
        },
        scope: $scope,
        showClose: false
    })
    .then(function(value){
        return false;
    }, function(value){

        cfpLoadingBar.start();
        $scope.modal.new_product_date_expirations = $filter('date')($scope.modal.product_expiration, "mediumDate");

        var x = 0;
        var g = 0;
        for (var i in $scope.tender_data) {
            x = parseFloat($scope.tender_data[i].product_quantity) * parseFloat($scope.tender_data[i].product_retail_price); 
            $scope.tender_data[i].tempo_total = x.toFixed(2);
            $scope.tender_data[i].tempor_total = $scope.tender_data[i].product_retail_price.toFixed(2); 
            g += $scope.tender_data[i].product_quantity; 
            $scope.form.product_count = g;
        };

        $scope.form.totaaal = 0;
        for (var k in $scope.tender_data) {
            $scope.form.totaaal += parseFloat($scope.tender_data[k].tempo_total);
            $scope.form.final_totaal = $scope.form.totaaal.toFixed(2);
        };

        var a = $scope.product_data[index].product_stocks;
        var b = $scope.modal.product_stocks;
        var tot = parseInt($scope.product_data[index].product_stocks) + parseInt($scope.modal.product_stocks);
        var datas = {
            pk : $scope.product_data[index].pk,
            product_name : $scope.modal.product_name,
            product_srp : $scope.modal.product_srp,
            product_bar_code : $scope.modal.product_bar_code,
            product_stocks_2 : $scope.modal.product_stocks,
            product_stocks : tot,
            product_price : $scope.modal.product_price,
            product_expiration : $scope.modal.new_product_date_expirations,
            product_supplier : $scope.modal.product_supplier,
            product_receipt_name : $scope.modal.receipt_name,
            product_or_number : $scope.modal.or_number,
            product_product_code : $scope.modal.product_product_code,
            product_rule : $scope.modal.product_rule,
            product_kinds : $scope.modal.product_kinds,
            remarks : 'Bad Merchandise'
        }


        var promise = ProductFactory.refund_item(datas);
        promise.then(function(data){
            var notify = $.notify('You have succesfully updated the product and the refunded item has been marked Bad Merchandise', { 'type': 'success', allow_dismiss: true });
            get_product_data();
            $route.reload();
            cfpLoadingBar.complete();
        })
        .then(null, function(data){
            var notify = $.notify('Oops there something wrong!', { 'type': 'danger', allow_dismiss: true });
            cfpLoadingBar.complete();
        });
    });
}

$scope.exchange = function(v){

    var index = $scope.product_data.indexOf(v);

    $scope.modal = {
        title : 'Exchange Product',
        save : 'Exchange',
        close : 'Cancel',
        product_name : $scope.product_data[index].product_name,
        product_bar_code : $scope.product_data[index].product_bar_code,
        product_price : $scope.product_data[index].product_price,
        product_expiration : $scope.product_data[index].product_expiration,
        product_srp : $scope.product_data[index].product_srp,
        product_supplier : $scope.product_data[index].product_supplier,
        receipt_name : $scope.product_data[index].product_receipt_name,
        or_number : $scope.product_data[index].product_or_number,
        product_product_code : $scope.product_data[index].product_product_code,
        product_rule : $scope.product_data[index].product_rules,
        product_kinds : $scope.product_data[index].product_kind


    };
    ngDialog.openConfirm({
        template: 'ExchangeModal',
        className: 'ngdialog-theme-plain dialogwidth500',
        preCloseCallback: function(value) {
            var nestedConfirmDialog;
            $scope.form.pin = md5.createHash($scope.modal.pin);
            if($scope.form.pin != $scope.user.superior_pin){
                var notify = $.notify('The Pin is incorrect!', {'type': 'danger', allow_dismiss: true });
                return false;
            }
            return nestedConfirmDialog;
        },
        scope: $scope,
        showClose: false
    })
    .then(function(value){
        return false;
    }, function(value){
        cfpLoadingBar.start();
        $scope.modal.new_product_date_expirations = $filter('date')($scope.product_data[index].product_expiration, "mediumDate");
        var a = $scope.modal.new_product_date_expirations.split(" ");
        var b = a[1].replace("ch", " ");
        var c = b + a[2] +" "+ a[3];
        var today2 = new Date();
        var today3 = $filter('date')(today2, "mediumDate");
        var today4 = $scope.date_ngayon_2;
        if (c == today3) {
            var j = $scope.product_data[index].product_stocks;
            var kk = $scope.modal.product_stocks;
            var tot = parseInt($scope.product_data[index].product_stocks) - parseInt($scope.modal.product_stocks);
        }
        if($scope.modal.product_name == $scope.form.exchange_product_name && c == today3){
            var notify = $.notify('Oops the item is expired!', { 'type': 'danger', allow_dismiss: true });
            return false;
        }else{
            var j = $scope.product_data[index].product_stocks;
            var kk = $scope.modal.product_stocks;
            var tot = parseInt($scope.product_data[index].product_stocks) - parseInt($scope.modal.product_stocks);
        };
        var datas = {
            pk : $scope.product_data[index].pk,
            product_name : $scope.modal.product_name,
            product_srp : $scope.modal.product_srp,
            product_bar_code : $scope.modal.product_bar_code,
            product_stocks_2 : $scope.modal.product_stocks,
            product_stocks : tot,
            product_price : $scope.modal.product_price,
            product_expiration : $scope.modal.new_product_date_expirations,
            product_supplier : $scope.modal.product_supplier,
            product_receipt_name : $scope.modal.receipt_name,
            product_or_number : $scope.modal.or_number,
            product_product_code : $scope.modal.product_product_code,
            product_rule : $scope.modal.product_rule,
            product_kinds : $scope.modal.product_kinds,
            remarks : 'Good Merchandise',
            exchange_product_name : $scope.form.exchange_product_name,
            cashier_user_id : $scope.user.user_id,
            final_date_tendered : $scope.date_ngayon,
            final_date_tendered_2 : today4

        }
        var promise = ProductFactory.exchange_item(datas);
        promise.then(function(data){
            var notify = $.notify('You have succesfully updated the product', { 'type': 'success', allow_dismiss: true });
            get_product_data();
            $route.reload();
            cfpLoadingBar.complete();
        })
        .then(null, function(data){
            var notify = $.notify('Oops there something wrong!', { 'type': 'danger', allow_dismiss: true });
            cfpLoadingBar.complete();
        });
    });
}

$scope.upload_items_inventory = function(){

    $scope.modal = {
        title : 'Upload Inventory',
        close : 'Close'
    };

    ngDialog.openConfirm({
        template: 'UploadModal2',
        className: 'ngdialog-theme-plain dialog_for_uploading_product_img',
        preCloseCallback: function(value) {
            var nestedConfirmDialog;
            return nestedConfirmDialog;
        },
        scope: $scope,
        showClose: false
    })
    .then(function(value){
        return false;
    }, function(value){

    });
}

var upload_image2 = $scope.upload_image2 = new FileUploader({
    url: 'FUNCTIONS/Uploads/upload_inventory.php'
});

upload_image2.filters.push({
    'name': 'enforceMaxFileSize',
    'fn': function (item) {
        return item.size <= 10485760; 
    }
});

upload_image2.onWhenAddingFileFailed = function(item /*{File|FileLikeObject}*/, filter, options) {
//console.info('onWhenAddingFileFailed', item, filter, options);
};
upload_image2.onAfterAddingFile = function(fileItem) {
//console.info('onAfterAddingFile', fileItem);
};
upload_image2.onAfterAddingAll = function(addedFileItems) {
//console.info('onAfterAddingAll', addedFileItems);
};
upload_image2.onBeforeUploadItem = function(item) {
//console.info('onBeforeUploadItem', item);
};
upload_image2.onProgressItem = function(fileItem, progress) {
//console.info('onProgressItem', fileItem, progress);
};
upload_image2.onProgressAll = function(progress) {
//console.info('onProgressAll', progress);
};
upload_image2.onSuccessItem = function(fileItem, response, status, headers) {
//console.info('onSuccessItem', fileItem, response, status, headers);
};
upload_image2.onErrorItem = function(fileItem, response, status, headers) {
//console.info('onErrorItem', fileItem, response, status, headers);
};
upload_image2.onCancelItem = function(fileItem, response, status, headers) {
//console.info('onCancelItem', fileItem, response, status, headers);
};
upload_image2.onCompleteItem = function(fileItem, response, status, headers) {
// console.log('onCompleteItem', fileItem, respsonse, status, headers);
//$scope.data.quotationmodal.attachment = response.file;


};
upload_image2.onCompleteAll = function() {
var notify = $.notify('You have succesfully uploaded the inventory', { 'type': 'success', allow_dismiss: true });
get_product_data();
};

var edit_upload_image = $scope.edit_upload_image = new FileUploader({
    url: 'FUNCTIONS/Uploads/upload_image.php'
});

edit_upload_image.filters.push({
    'name': 'enforceMaxFileSize',
    'fn': function (item) {
        return item.size <= 10485760; 
    }
});

edit_upload_image.onWhenAddingFileFailed = function(item /*{File|FileLikeObject}*/, filter, options) {
//console.info('onWhenAddingFileFailed', item, filter, options);
};
edit_upload_image.onAfterAddingFile = function(fileItem) {
//console.info('onAfterAddingFile', fileItem);
};
edit_upload_image.onAfterAddingAll = function(addedFileItems) {
//console.info('onAfterAddingAll', addedFileItems);
};
edit_upload_image.onBeforeUploadItem = function(item) {
//console.info('onBeforeUploadItem', item);
};
edit_upload_image.onProgressItem = function(fileItem, progress) {
//console.info('onProgressItem', fileItem, progress);
};
edit_upload_image.onProgressAll = function(progress) {
//console.info('onProgressAll', progress);
};
edit_upload_image.onSuccessItem = function(fileItem, response, status, headers) {
//console.info('onSuccessItem', fileItem, response, status, headers);
};
edit_upload_image.onErrorItem = function(fileItem, response, status, headers) {
//console.info('onErrorItem', fileItem, response, status, headers);
};
edit_upload_image.onCancelItem = function(fileItem, response, status, headers) {
//console.info('onCancelItem', fileItem, response, status, headers);
};
edit_upload_image.onCompleteItem = function(fileItem, response, status, headers) {
// console.log('onCompleteItem', fileItem, respsonse, status, headers);
//$scope.data.quotationmodal.attachment = response.file;


$scope.modal.image_source = response.file;
console.log($scope.modal.image_source);
};
edit_upload_image.onCompleteAll = function() {
var notify = $.notify('You have succesfully uploaded the inventory', { 'type': 'success', allow_dismiss: true });
get_product_data();
};

});

