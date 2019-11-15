app.controller('Product', function(
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
    $scope.voucher = {};
    $scope.finals = {};
    $scope.upload_image = {};
    $scope.upload_image.queue = {};
    $scope.aomos_staff_name = {};
    $scope.aomos_staff_discount = false;
    $scope.voucherstatus = false;
    $scope.aomos_dscnt_status = false;
    $scope.edit_upload_image = {};
    $scope.permissions = {};
    $scope.edit_upload_image.queue = {};
    $scope.datass = {};
    $scope.fa = {};
    $scope.depressed = 0;
    $scope.filter = {};
    $scope.tender_new = [];
    $scope.tender_voided = {};
    $scope.tender_voided.count = 0;
    $scope.request_order_status = false;
    $scope.stocks_status = 0;
    $scope.stocks_statuses = false;
    $scope.stocks_status_count = 0;
    $scope.submit_datas = {};
    $scope.check_item_data_status = {};
    $scope.product_data_expire_status = {};
    $scope.product_code = {};
    $scope.stock_amount_status = false;
    $scope.tender_show = false;
    $scope.stock_amount_finalized = 0;
    $scope.stock_amount_pk = {};
    $scope.stock_amount = {};
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

    $scope.cashier = {};

    $scope.viewby_productdata = 10;
    $scope.currentPage_productdata = 4;
    $scope.itemsPerPage_productdata = $scope.viewby_productdata;
    $scope.maxSize = 5;

    $scope.viewby_productdata_expire = 10;
    $scope.currentPage_productdata_expire = 4;
    $scope.itemsPerPage_productdata_expire = $scope.viewby_productdata_expire;
    $scope.maxSize = 5;

    $scope.viewby_ruledata = 10;
    $scope.currentPage_ruledata = 4;
    $scope.itemsPerPage_ruledata = $scope.viewby_ruledata;
    $scope.maxSize = 5;

    $scope.viewby_supplierdata = 5;
    $scope.currentPage_supplierdata = 4;
    $scope.itemsPerPage_supplierdata = $scope.viewby_supplierdata;
    $scope.maxSize = 5;

    $scope.viewby_orderdata = 10;
    $scope.currentPage_orderdata = 4;
    $scope.itemsPerPage_orderdata = $scope.viewby_orderdata;
    $scope.maxSize = 5;

    $scope.viewby_user_data = 10;
    $scope.currentPage_user_data = 4;
    $scope.itemsPerPage_user_data = $scope.viewby_user_data;
    $scope.maxSize = 5;

    $scope.customer_list;
    $scope.selected_customer;
    $scope.customer_data = {};
    $scope.temporary_product_data = {};
    $scope.product_max_qtys = {};

    var filtered = {};
    var filters= {};
    var filter= {};

    init();

    $scope.vm = {};
    $scope.vm.options = {format: 'YYYY/MM/DD HH:mm', showClear: true};

    function init(){
        get_customers();
        var promise = SessionFactory.getsession();
        promise.then(function(data){
            var _id = md5.createHash('pk');
            $scope.pk = data.data[_id];
            get_user();
            DEFAULTDATES();
            makeid();
            maketransaction_number();
            makeuser_id();

        })
        .then(null, function(data){
            window.location = './login.html';
        });
    }

    function get_customers() {
        var promise = ProductFactory.get_customers();
        promise.then(function(data){
            $scope.customer_data = data.data.result;
            setCustomerList();
        });
    }

    function setCustomerList() {
        $scope.customer_list = $scope.customer_data;
        $scope.customer_list.unshift({'pk' : 0, 'client_name' : 'Walk In'});
        $scope.selected_customer = $scope.customer_list[0];
    }

    function get_user(){
        var filters = {
            'pk' : $scope.pk
        };

        var promise = UserFactory.get_user(filters);
        promise.then(function(data){
            $scope.user = data.data.result[0];
            get_product_data();
            get_supplier_data();
            get_request_order_data();
            get_added_user_data();
            get_rule_data();
            get_product_data_expire();
            get_product_data_checker();
            get_branch_data();

        })
        .then(null, function(data){
            var promise = SessionFactory.logout();
            promise.then(function(data){
                window.location = './login.html';
            });
        });
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

    function get_branch_data(){
    cfpLoadingBar.start();

    var promise = ProductFactory.get_branch_data();
    promise.then(function(data){
        $scope.branch_data = data.data.result;

        var a = 0;

        for (var i in $scope.branch_data) {
            $scope.branch_data[i].product_expiration = new Date($scope.branch_data[i].product_expiration);
            $scope.branch_data[i].product_expiration = moment($scope.branch_data[i].product_expiration).format('LLLL');
            $scope.branch_data[i].date_created = moment($scope.branch_data[i].date_created).format('LLLL');
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

    function get_product_data_checker(){

        var promise = ProductFactory.get_product_data_checker();
        promise.then(function(data){
            $scope.product_data_checker = data.data.result;

            

        })
        .then(null, function(data){


        });
    }

    function get_added_user_data(){

        var promise = ProductFactory.get_added_user_data();
        promise.then(function(data){
            $scope.added_user_data = data.data.result;
            console.log($scope.added_user_data);
            

/*var a = 0;
for (var i in $scope.product_data) {
$scope.product_data[i].product_product_expiration = new Date($scope.product_data[i].product_product_expiration);
$scope.product_data[i].product_product_expiration = $filter('date')($scope.product_data[i].product_product_expiration, "mediumDate");
$scope.product_data[i].date_created = new Date($scope.product_data[i].date_created);
$scope.product_data[i].number = a += 1;
};*/

for (var x in $scope.added_user_data) {
    if ($scope.added_user_data[x].user_type == 2) {
        $scope.added_user_data[x].user_type = 'Cashier';
    };
    if ($scope.added_user_data[x].user_type == 1) {
        $scope.added_user_data[x].user_type = 'Admin';
    };
};

$scope.totalItems_user_data = $scope.added_user_data.length;

$scope.form = {};
})
        .then(null, function(data){


        });
    }

    $scope.setPage_user_data = function (pageNo) {
        $scope.currentPage_user_data = pageNo;
    };

    $scope.pageChanged_user_data = function() {
        console.log('Page changed to: ' + $scope.currentPage_user_data);
    };

    $scope.setItemsPerPage_user_data = function(num) {
        $scope.itemsPerPage_user_data = num;
$scope.currentPage_user_data = 1; //reset to first paghe
}

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
}

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
$scope.print_items = function(){
    window.open('./FUNCTIONS/Uploads/print_items.php?wildcard='+filters.wildcard+'&wildcard2='+filters.wildcard2+'&wildcard3='+filters.wildcard3
        );
}

$scope.print_items_csv = function(){
    window.open('./FUNCTIONS/Uploads/print_csv.php');
}

$scope.sortfood = function(){
    cfpLoadingBar.start();
    if ($scope.form.search == "" || $scope.form.search == '') {
        get_product_data_expire();
    }

    var today = new Date();
    filters = {
        sort : 'Food',
        sortnon : undefined,
        wildcard : undefined,
        date_from : $filter('date')($scope.filter.date3._d, "yyyy-MM-dd"),
        date_to : $filter('date')($scope.filter.date4._d, "yyyy-MM-dd")
    };

    var promise = ProductFactory.get_product_data_search_expire(filters);
    promise.then(function(data){
        $scope.product_data_expire = data.data.result;
        $scope.product_data_expire_status = true;
        

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
    $scope.product_data_expire_status = false;
    cfpLoadingBar.complete();
});
}
$scope.setPage_productdata_expire = function (pageNo) {
    $scope.currentPage_productdata_expire = pageNo;
};

$scope.pageChanged_productdata_expire = function() {
    console.log('Page changed to: ' + $scope.currentPage_productdata_expire);
};

$scope.setItemsPerPage_productdata_expire = function(num) {
    $scope.itemsPerPage_productdata_expire = num;
$scope.currentPage_productdata_expire = 1; //reset to first paghe
}

$scope.sortnon = function(){
    cfpLoadingBar.start();
    if ($scope.form.search == "" || $scope.form.search == '') {
        get_product_data_expire();
    }

    var today = new Date();
    filters = {
        sortnon : 'Nonfood',
        sort : undefined,
        wildcard : undefined,
        date_from : $filter('date')($scope.filter.date3._d, "yyyy-MM-dd"),
        date_to : $filter('date')($scope.filter.date4._d, "yyyy-MM-dd")
    };

    var promise = ProductFactory.get_product_data_search_expire(filters);
    promise.then(function(data){
        $scope.product_data_expire = data.data.result;
        $scope.product_data_expire_status = true;
        

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
/* filters.sort = "";
filters.wildcard = "";*/

})
.then(null, function(data){
    $scope.product_data_expire_status = false;
    cfpLoadingBar.complete();
});
}
$scope.setPage_productdata_expire = function (pageNo) {
    $scope.currentPage_productdata_expire = pageNo;
};

$scope.pageChanged_productdata_expire = function() {
    console.log('Page changed to: ' + $scope.currentPage_productdata_expire);
};

$scope.setItemsPerPage_productdata_expire = function(num) {
    $scope.itemsPerPage_productdata_expire = num;
$scope.currentPage_productdata_expire = 1; //reset to first paghe
}

$scope.search_expire_data = function(){
    cfpLoadingBar.start();
    if ($scope.form.search == "" || $scope.form.search == '') {
        get_product_data_expire();
    }

    filters = {
        wildcard : $scope.form.search,
        sort : undefined,
        sortnon : undefined,
        date_from : $filter('date')($scope.filter.date3._d, "yyyy-MM-dd"),
        date_to : $filter('date')($scope.filter.date4._d, "yyyy-MM-dd")
    };

    var promise = ProductFactory.get_product_data_search_expire(filters);
    promise.then(function(data){
        $scope.product_data_expire = data.data.result;
        $scope.product_data_expire_status = true;
        

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
    $scope.product_data_expire_status = false;
    cfpLoadingBar.complete();
});
}
$scope.setPage_productdata_expire = function (pageNo) {
    $scope.currentPage_productdata_expire = pageNo;
};

$scope.pageChanged_productdata_expire = function() {
    console.log('Page changed to: ' + $scope.currentPage_productdata_expire);
};

$scope.setItemsPerPage_productdata_expire = function(num) {
    $scope.itemsPerPage_productdata_expire = num;
$scope.currentPage_productdata_expire = 1; //reset to first paghe
}

$scope.search_expire = function(){
    cfpLoadingBar.start();
    var today = new Date();
    if ($scope.form.search == "" || $scope.form.search == '') {
        get_product_data_expire();
        date_from = $filter('date')(new Date(today.getFullYear(), today.getMonth(), today.getDate() - today.getDay()+0),"yyyy-MM-dd"),
        date_to = $filter('date')(new Date(today.getFullYear(), today.getMonth(), today.getDate() - today.getDay()+6),"yyyy-MM-dd")
    }

    filters = {
        wildcard : $scope.form.search,
        date_from : $filter('date')(new Date(today.getFullYear(), today.getMonth(), today.getDate() - today.getDay()+0),"yyyy-MM-dd"),
        date_to : $filter('date')(new Date(today.getFullYear(), today.getMonth(), today.getDate() - today.getDay()+6),"yyyy-MM-dd")
    };

    var promise = ProductFactory.get_product_data_search_expire(filters);
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
$scope.setPage_productdata_expire = function (pageNo) {
    $scope.currentPage_productdata_expire = pageNo;
};

$scope.pageChanged_productdata_expire = function() {
    console.log('Page changed to: ' + $scope.currentPage_productdata_expire);
};

$scope.setItemsPerPage_productdata_expire = function(num) {
    $scope.itemsPerPage_productdata_expire = num;
$scope.currentPage_productdata_expire = 1; //reset to first paghe
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

/*var x = .12;
for (var i in $scope.rule_data) {
$scope.form.vat_wamount = x * $scope.rule_data[i].product_srp;
$scope.rule_data[i].wamount1 = parseFloat($scope.rule_data[i].product_srp) + parseFloat($scope.form.vat_wamount);
$scope.rule_data[i].wamount3 = parseFloat($scope.rule_data[i].wamount1).toFixed(2);
console.log($scope.rule_data[i].wamount);
};

for (var z in $scope.rule_data) {
if ($scope.rule_data[z].product_status == '(OLD)') {
$scope.rule_data[z].product_status_color = 1;
$scope.rule_data[z].product_status_color1 = 'red';
}
if ($scope.rule_data[z].product_status == '(NEW)') {
$scope.rule_data[z].product_status_color = 1;
$scope.rule_data[z].product_status_color1 = 'green';
}
};*/

$scope.totalItems_ruledata = $scope.rule_data.length;
})
.then(null, function(data){

    cfpLoadingBar.complete();
});
}

$scope.setPage_ruledata = function (pageNo) {
    $scope.currentPage_ruledata = pageNo;
};

$scope.pageChanged_ruledata = function() {
    console.log('Page changed to: ' + $scope.currentPage_ruledata);
};

$scope.setItemsPerPage_ruledata = function(num) {
    $scope.itemsPerPage_ruledata = num;
$scope.currentPage_ruledata = 1; //reset to first paghe
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


$scope.setPage_supplierdata = function (pageNo) {
    $scope.currentPage_supplierdata = pageNo;
};

$scope.pageChanged_supplierdata = function() {
    console.log('Page changed to: ' + $scope.currentPage_supplierdata);
};

$scope.setItemsPerPage_supplierdata = function(num) {
    $scope.itemsPerPage_supplierdata = num;
$scope.currentPage_supplierdata = 1; //reset to first paghe
}

$scope.search_supplier = function(){
    cfpLoadingBar.start();
    if ($scope.form.search_supplier1 == "") {
        get_supplier_data();
    }

    var filters = {
        wildcard : $scope.form.search_supplier1
    };


    var promise = ProductFactory.get_supplier_data_search(filters);
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


$scope.setPage_supplierdata = function (pageNo) {
    $scope.currentPage_supplierdata = pageNo;
};

$scope.pageChanged_supplierdata = function() {
    console.log('Page changed to: ' + $scope.currentPage_supplierdata);
};

$scope.setItemsPerPage_supplierdata = function(num) {
    $scope.itemsPerPage_supplierdata = num;
$scope.currentPage_supplierdata = 1; //reset to first paghe
}

function get_request_order_data(){
cfpLoadingBar.start();
filter = {
        date_from : undefined,
        date_to : undefined
    };
    var promise = ProductFactory.get_request_order_data(filter);
    promise.then(function(data){
        $scope.request_data = data.data.result;
        

        var a = 0;
        for (var i in $scope.request_data) {
            $scope.request_data[i].product_date_needed = new Date($scope.request_data[i].product_date_needed);
            $scope.request_data[i].product_date_needed = moment($scope.request_data[i].product_date_needed).format('LLLL');
            $scope.request_data[i].date_created = new Date($scope.request_data[i].date_created);
            $scope.request_data[i].date_created = moment($scope.request_data[i].date_created).format('LLLL');
            $scope.request_data[i].number = a += 1;
        };

        $scope.totalItems_orderdata = $scope.request_data.length;

        $scope.form = {};
    })
    .then(null, function(data){
cfpLoadingBar.complete();

    });
}

$scope.setPage_orderdata = function (pageNo) {
    $scope.currentPage_orderdata = pageNo;
};

$scope.pageChanged_orderdata = function() {
    console.log('Page changed to: ' + $scope.currentPage_orderdata);
};

$scope.setItemsPerPage_orderdata = function(num) {
    $scope.itemsPerPage_orderdata = num;
$scope.currentPage_orderdata = 1; //reset to first paghe
}
$scope.logout = function(){
    var promise = SessionFactory.logout();
    promise.then(function(data){
        window.location = './login.html';
    })
}

$scope.check_item = function(){
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
}

$scope.add_product = function(){
cfpLoadingBar.start();
    $scope.datass.product_expiration = $filter('date')($scope.datass.product_expiration._d, "mediumDate");


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

    var datas = {
        product_name : $scope.form.product_name,
        product_bar_code : $scope.form.product_bar_code,
        product_stocks : $scope.form.product_stocks,
        product_srp : $scope.form.srp,
        product_price : $scope.form.product_price,
        product_product_expiration : $scope.datass.product_expiration,
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

    if (datas.product_product_code == '' || datas.product_product_code == "" || datas.product_product_code == NaN || datas.product_product_code == null || datas.product_product_code == undefined || datas.product_product_code == 'NaN') {
        var notify = $.notify('Oops there something wrong with product code value!', {'type': 'danger' ,  allow_dismiss: true });
        cfpLoadingBar.complete();
        return false;
    };

    if (datas.product_kinds == '' || datas.product_kinds == "" || datas.product_kinds == NaN || datas.product_kinds == null || datas.product_kinds == undefined || datas.product_kinds == 'NaN') {
        var notify = $.notify('Oops there something wrong with product kinds value!', {'type': 'danger' ,  allow_dismiss: true });
        cfpLoadingBar.complete();
        return false;
    };



    var promise = ProductFactory.add_product(datas);    
    promise.then(function(data){
        var notify = $.notify('You have succesfully added the product', { allow_dismiss: true });
        get_product_data();
        $scope.add_product();
        cfpLoadingBar.complete();

    })
    .then(null, function(data){
        var notify = $.notify('Oops there something wrong! Please check all datas', { allow_dismiss: true });
        cfpLoadingBar.complete();
    });
}

$scope.add_rule = function(){
cfpLoadingBar.start();
    var datas = {
        rule_name : $scope.form.rule_name
    }

    var promise = ProductFactory.add_rule(datas);    
    promise.then(function(data){
        var notify = $.notify('You have succesfully added the new rule', { allow_dismiss: true });
        get_rule_data();
        $route.reload();
        cfpLoadingBar.complete();

    })
    .then(null, function(data){
        var notify = $.notify('Oops there something wrong!', { allow_dismiss: true });
        cfpLoadingBar.complete();
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

$scope.edit_rule_data = function(v){
    
    var index = $scope.rule_data.indexOf(v);

    $scope.modal = {
        title : 'Update Rules',
        save : 'Update',
        close : 'Cancel',
        rule_name : $scope.rule_data[index].rule_name
    };

    ngDialog.openConfirm({
        template: 'EditMyRule',
        className: 'ngdialog-theme-plain dialogwidth500',
        scope: $scope,
        showClose: false
    })
    .then(function(value){
        return false;
    }, function(value){
        cfpLoadingBar.start();
        var datas = {
            pk : $scope.rule_data[index].pk,
            rule_name : $scope.modal.rule_name
        }

        var promise = ProductFactory.edit_rule_data(datas);
        promise.then(function(data){
            var notify = $.notify('You have succesfully updated the rule', { 'type': 'success', allow_dismiss: true });
            get_rule_data();
            cfpLoadingBar.complete();
        })
        .then(null, function(data){
            var notify = $.notify('Oops there something wrong!', { 'type': 'danger', allow_dismiss: true });
            cfpLoadingBar.complete();
        });
    });
} 

$scope.delete_rule = function(v){
    cfpLoadingBar.start();
    var index = $scope.rule_data.indexOf(v);


    $scope.modal.pk = $scope.rule_data[index].pk;
    var promise = ProductFactory.delete_rule($scope.modal);
    promise.then(function(data){
        var notify = $.notify('You have succesfully deleted the user', { 'type': 'success', allow_dismiss: true });
        get_rule_data();
        cfpLoadingBar.complete();
    })
    .then(null, function(data){
        var notify = $.notify('Oops there is something wrong!', { 'type': 'danger', allow_dismiss: true });
        cfpLoadingBar.complete();
    });
}

function makeuser_id() {
    var text = "0";
    var text2 = "";
    var text3 = "";
    var finalnumber = "";
    var final_user_id = "";

    var possible = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    var possible2 = "0123456789";

    for (var i = 0; i < 3; i++){
        text2 += possible2.charAt(Math.floor(Math.random() * possible2.length));
    }
    final_user_id = text+text2;
    $scope.modal.final_user_id = final_user_id;
    /*console.log($scope.modal.final_user_id);*/
}

$scope.add_user = function(){
    makeuser_id();

    $scope.modal = {
        title : 'Add User',
        save : 'Add',
        close : 'Cancel',
        final_user_id: $scope.modal.final_user_id
    }     

    ngDialog.openConfirm({
        template: 'EditUser',
        className: 'ngdialog-theme-plain dialogwidth500',
        preCloseCallback: function(value) {
            var nestedConfirmDialog;
            if($scope.modal.first_password != $scope.modal.confirm_password){
                var notify = $.notify('The Pin is incorrect!', {'type': 'danger', allow_dismiss: true });
                cfpLoadingBar.complete();
                return false;
            }
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
            var regexEmail = /\S+@\S+\.\S+/;
            if (!regexEmail.test($scope.modal.email)) {
                var notify = $.notify('Invalid Email!', {'type': 'danger' ,  allow_dismiss: true });
                cfpLoadingBar.complete();
                return false;
            }
            if ($scope.modal.user_type == '' || $scope.modal.user_type == "" || $scope.modal.user_type == NaN || $scope.modal.user_type == null || $scope.modal.user_type == undefined || $scope.modal.user_type == 'NaN') {
                var notify = $.notify('Oops there something wrong with the user type!', {'type': 'danger' ,  allow_dismiss: true });
                cfpLoadingBar.complete();
                return false;
            }
            if ($scope.modal.first_password == '' || $scope.modal.first_password == "" || $scope.modal.first_password == NaN || $scope.modal.first_password == null || $scope.modal.first_password == undefined || $scope.modal.first_password == 'NaN') {
                var notify = $.notify('Oops there something wrong with first password!', {'type': 'danger' ,  allow_dismiss: true });
                cfpLoadingBar.complete();
                return false;
            }
            if ($scope.modal.confirm_password == '' || $scope.modal.confirm_password == "" || $scope.modal.confirm_password == NaN || $scope.modal.confirm_password == null || $scope.modal.confirm_password == undefined || $scope.modal.confirm_password == 'NaN') {
                var notify = $.notify('Oops there something wrong with the confirm password!', {'type': 'danger' ,  allow_dismiss: true });
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
        $scope.modal.new_password = md5.createHash($scope.modal.first_password);

        var promise = ProductFactory.add_user($scope.modal);
        promise.then(function(data){
            var notify = $.notify('You have succesfully added a new user', { 'type': 'success', allow_dismiss: true });
            get_added_user_data();
            $route.reload();
            cfpLoadingBar.complete();
        })
        .then(null, function(data){
            var notify = $.notify('Oops there is something wrong!', { 'type': 'danger', allow_dismiss: true });
            cfpLoadingBar.complete();
        });
    });
}

$scope.edit_user = function(v){
    
    var index = $scope.added_user_data.indexOf(v);

    if ($scope.added_user_data[index].user_type == 'Cashier') {
        $scope.modal.user_type = '2';
    };
    if ($scope.added_user_data[index].user_type == 'Admin') {
        $scope.modal.user_type = '1';
    };

    /*console.log($scope.modal.user_type);*/


    $scope.modal = {
        title : 'Edit User',
        save : 'Update',
        close : 'Cancel',
        first_name: $scope.added_user_data[index].first_name,
        middle_name: $scope.added_user_data[index].middle_name,
        last_name: $scope.added_user_data[index].last_name,
        final_user_id: $scope.added_user_data[index].user_id,
        user_type: $scope.modal.user_type,
        confirm_password: $scope.added_user_data[index].password,
        first_password: $scope.added_user_data[index].password,
        email: $scope.added_user_data[index].email
    }     

    ngDialog.openConfirm({
        template: 'UpdateUser',
        className: 'ngdialog-theme-plain dialogwidth500',
        preCloseCallback: function(value) {
            var nestedConfirmDialog;
            if($scope.modal.first_password != $scope.modal.confirm_password){
                var notify = $.notify('The Pin is incorrect!', {'type': 'danger', allow_dismiss: true });
                return false;
            }
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
            var regexEmail = /\S+@\S+\.\S+/;
            if (!regexEmail.test($scope.modal.email)) {
                var notify = $.notify('Invalid Email!', {'type': 'danger' ,  allow_dismiss: true });
                cfpLoadingBar.complete();
                return false;
            }
            if ($scope.modal.user_type == '' || $scope.modal.user_type == "" || $scope.modal.user_type == NaN || $scope.modal.user_type == null || $scope.modal.user_type == undefined || $scope.modal.user_type == 'NaN') {
                var notify = $.notify('Oops there something wrong with the user type!', {'type': 'danger' ,  allow_dismiss: true });
                cfpLoadingBar.complete();
                return false;
            }
            if ($scope.modal.first_password == '' || $scope.modal.first_password == "" || $scope.modal.first_password == NaN || $scope.modal.first_password == null || $scope.modal.first_password == undefined || $scope.modal.first_password == 'NaN') {
                var notify = $.notify('Oops there something wrong with first password!', {'type': 'danger' ,  allow_dismiss: true });
                cfpLoadingBar.complete();
                return false;
            }
            if ($scope.modal.confirm_password == '' || $scope.modal.confirm_password == "" || $scope.modal.confirm_password == NaN || $scope.modal.confirm_password == null || $scope.modal.confirm_password == undefined || $scope.modal.confirm_password == 'NaN') {
                var notify = $.notify('Oops there something wrong with the confirm password!', {'type': 'danger' ,  allow_dismiss: true });
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
        if ($scope.modal.first_password == $scope.added_user_data[index].password) {
            $scope.super_final_password = $scope.modal.first_password;
        }else if ($scope.modal.first_password != $scope.added_user_data[index].password) {
            $scope.super_final_password = md5.createHash($scope.modal.first_password)
        };
        $scope.modal.new_password = $scope.super_final_password;
        $scope.modal.user_idd = $scope.added_user_data[index].user_id;
        var promise = ProductFactory.edit_user($scope.modal);
        promise.then(function(data){
            var notify = $.notify('You have succesfully updated the user', { 'type': 'success', allow_dismiss: true });
            get_added_user_data();
            cfpLoadingBar.complete();
        })
        .then(null, function(data){
            var notify = $.notify('Oops there is something wrong!', { 'type': 'danger', allow_dismiss: true });
            cfpLoadingBar.complete();
        });
    });
}

$scope.delete_user = function(v){
    cfpLoadingBar.start();
    var index = $scope.added_user_data.indexOf(v);


    $scope.modal.user_idd = $scope.added_user_data[index].user_id;
    var promise = ProductFactory.delete_user($scope.modal);
    promise.then(function(data){
        var notify = $.notify('You have succesfully deleted the user', { 'type': 'success', allow_dismiss: true });
        get_added_user_data();
        cfpLoadingBar.complete();
    })
    .then(null, function(data){
        var notify = $.notify('Oops there is something wrong!', { 'type': 'danger', allow_dismiss: true });
        cfpLoadingBar.complete();
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

function maketransaction_number() {
    var transact_number = "";

    var possible = "0123456789";
    var possible2 = "0123456789";

    for (var i = 0; i < 10; i++){
        transact_number += possible.charAt(Math.floor(Math.random() * possible.length));
    }
    $scope.form.transact_number = transact_number;
}

$scope.barcode = function(){
    cfpLoadingBar.start();
    
    filter ={
        barcode : $scope.form.barcode
    };
    var promise = ProductFactory.get_barcode(filter);
    promise.then(function(data){
        $scope.product_data = data.data.result;
        var is_new_product_to_tender = false;;

        for (var k in $scope.product_data) {

        if ($scope.stock_amount[$scope.product_data[k].pk] == undefined) {
            $scope.stock_amount[$scope.product_data[k].pk] = 0;
            $scope.product_max_qtys[$scope.product_data[k].pk] = $scope.product_data[k].product_stocks;
            is_new_product_to_tender = true;
        }

        var temporary_quantity;
        temporary_quantity = parseInt($scope.stock_amount[$scope.product_data[k].pk]) + parseInt($scope.form.countquantity);

        if (parseInt($scope.stock_amount[$scope.product_data[k].pk]) == parseInt($scope.product_data[k].product_stocks)) {
            $scope.modal = {
                title : 'WARNING!',
                close : 'Close'
            }     

            ngDialog.openConfirm({
                template: 'AdviceModal',
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

            });

            return;
        } else if (parseInt(temporary_quantity) > parseInt($scope.product_data[k].product_stocks)) {
            $scope.form.countquantity = parseInt($scope.product_data[k].product_stocks) - parseInt($scope.stock_amount[$scope.product_data[k].pk]);
            $scope.stock_amount[$scope.product_data[k].pk] = parseInt($scope.stock_amount[$scope.product_data[k].pk]) + parseInt($scope.form.countquantity);
        } else {
            $scope.stock_amount[$scope.product_data[k].pk] = parseInt(temporary_quantity);
        }

        if ($scope.stock_amount[$scope.product_data[k].pk] >= $scope.product_data[k].product_stocks) {
            $scope.modal = {
                title : 'WARNING!',
                close : 'Close'
            }     

            ngDialog.openConfirm({
                template: 'AdviceExceedModal',
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
            });
        };

    }

        if ($scope.form.countquantity == null || $scope.form.countquantity == '' || $scope.form.countquantity == "") {
            var notify = $.notify('You should specify the quantity', {'type': 'danger',  allow_dismiss: true });
            return false;
        };

        if (is_new_product_to_tender) {
            $scope.tender_data.push($scope.product_data[0]);
            $scope.tender_data[$scope.tender_data.length-1].product_quantity = $scope.stock_amount[$scope.product_data[0].pk];
        } else {
            for (var i = 0; i < $scope.tender_data.length; i++) {
                if ($scope.tender_data[i].pk == $scope.product_data[0].pk) {
                    $scope.tender_data[i].product_quantity = $scope.stock_amount[$scope.product_data[0].pk];
                    break;
                }
            }
        }

        for (var z = 0; z < $scope.tender_data.length; z++) {
            $scope.tender_data[z].product_price = $scope.tender_data[z].selling_price * $scope.tender_data[z].product_quantity;
            $scope.tender_data[z].status = true;
        };
        

        $scope.temporary();

    })
    .then(null, function(data){

        cfpLoadingBar.complete();
    });
};

$scope.enterBarcode = function(event) {
    if (event.which == 13) {
        $scope.barcode();
    }
};

$scope.changeQuantity = function(index) {
    if (parseInt($scope.tender_data[index].product_quantity) > parseInt($scope.product_max_qtys[$scope.tender_data[index].pk])) {
        $scope.tender_data[index].product_quantity = parseInt($scope.product_max_qtys[$scope.tender_data[index].pk]);
    }
    $scope.stock_amount[$scope.tender_data[index].pk] = $scope.tender_data[index].product_quantity;

    $scope.tender_data[index].product_price = $scope.tender_data[index].product_quantity * $scope.tender_data[index].selling_price;
    $scope.tender_data[index].status=true;
    $scope.temporary();
    $scope.tender_data[index].tempo_status=true;
    // $scope.stock_checker(index);
};

/*$scope.tender_product = function(test){

    $scope.product_total_tempo = 0;
    maketransaction_number();

    if (test == undefined || test == null || test == ' ' || test == " ") {
        return false;
    };


    $scope.tender_data.push(test.description);
    for (var i in $scope.tender_data) {
        $scope.tender_data[i].product_price = parseFloat($scope.tender_data[i].product_price);
        if ($scope.tender_data[i].status == true || $scope.tender_data[i].status == undefined) {
        }else{
            $scope.tender_data[i].status = false;
        };
    };

    $scope.number = $scope.tender_data[i].number;

 for (var k in $scope.tender_data){
if ($scope.tender_data[k].product_retail_price != undefined) {
if ($scope.tender_data[k].tempo_status == true || test == undefined){
$scope.product_total_tempo += parseInt($scope.tender_data[k].product_retail_price);
$scope.product_total_temporary = $scope.product_total_tempo;
console.log($scope.product_total_temporary);
};
};
};

for (var o in $scope.tender_data) {
if ($scope.tender_data[k].tempo_status == true || test == undefined){
$scope.product_total_tempo += parseInt($scope.tender_data[k].product_retail_price);
$scope.product_total_temporary = $scope.product_total_tempo;
};


}*/

$scope.temporary = function(){
    $scope.product_total_tempo = 0;
    $scope.number = 0;

/*if ($scope.tender_data[k].tempo_status == true) {
$scope.tender_data[i].product_price = 0;
};*/


for (var k in $scope.tender_data){
    $scope.product_total_tempo += parseFloat($scope.tender_data[k].product_price);
    $scope.product_total_temporary = parseFloat($scope.product_total_tempo);
    $scope.number += $scope.tender_data[k].product_quantity;
    $scope.number_total = $scope.number;
};

if ($scope.cash < $scope.product_total_temporary) {
    $scope.tender_show = false;
} else {
    $scope.tender_show = true;
}
/*if ($scope.product_total_temporary < 50 || $scope.product_total_temporary < '50') {
    $scope.aomos_dscnt_status = true;
}else{
    $scope.aomos_dscnt_status = false;
};*/


}

/*$scope.discount_amount = function(){
    $scope.discount = true;

    var notify = $.notify('You have succesfully added a Senior Citizen Discount', { allow_dismiss: true });

}*/

$scope.discount_amount = function(){
    $scope.modal = {
        title : 'Discount',
        save : 'Ok',
        close : 'Cancel'
    };
    ngDialog.openConfirm({
        template: 'DiscountModal',
        className: 'ngdialog-theme-plain dialogwidth400',
        scope: $scope,
        showClose: false
    })
    .then(function(value){
        return false;
    }, function(value){
        if ($scope.modal.discount_type == 1 || $scope.modal.discount_type == 2) {
            $scope.discount = true;
            $scope.cnumber_pwdc = $scope.modal.cnumber;
            var notify = $.notify('You have successfully top up the discount', {'type': 'success',  allow_dismiss: true });
        }else if($scope.modal.discount_type == 3){
            $scope.discount = false;
            $scope.voucherstatus = true;
            $scope.voucher.vnumber = $scope.modal.vnumber;
            $scope.voucher.vamount = $scope.modal.vamount;
            $scope.voucher.custname = $scope.modal.custname;
            $scope.cash = $scope.modal.vamount;
            var notify = $.notify('You have successfully top up the voucher', {'type': 'success',  allow_dismiss: true });
        }else{
            $scope.discount = false;
            $scope.voucherstatus = false;
            $scope.cnumber_pwdc = '';
        }    

        /*else{
            $scope.discount = false;
            $scope.company_discount = true;
            $scope.company_discount_percent = parseFloat('.'+$scope.modal.company_discount_percent);
            $scope.cnumber_pwdc = '';
        }*/
    });
    //var notify = $.notify('You have succesfully added a Senior Citizen Discount', { allow_dismiss: true });

}

$scope.pay_gift_cert = function(){

/*if($scope.modal.supplier_name == '' || $scope.modal.supplier_address == '' || $scope.modal.supplier_contact_number == '' || $scope.modal.supplier_contact_person == ''){

var notify = $.notify('There is a blank encoded product data', {'type': 'danger', allow_dismiss: true });
return false;
}*/

$scope.modal = {
    title : 'Accept Gift Certificate',
    save : 'Tender',
    close : 'Cancel'
};

ngDialog.openConfirm({
    template: 'GiftModal',
    className: 'ngdialog-theme-plain dialogwidth400',
    preCloseCallback: function(value) {
        var nestedConfirmDialog;
        if ($scope.modal.gc_name == '' || $scope.modal.gc_name == "" || $scope.modal.gc_name == NaN || $scope.modal.gc_name == null || $scope.modal.gc_name == 0.00 || $scope.modal.gc_name == undefined || $scope.modal.product_gc_name == 'NaN') {
            var notify = $.notify('Oops there something wrong with gift certificate name!', {'type': 'danger',  allow_dismiss: true });
            return false;
        };

        if ($scope.modal.gc_code == '' || $scope.modal.gc_code == "" || $scope.modal.gc_code == NaN || $scope.modal.gc_code == null || $scope.modal.gc_code == 0.00 || $scope.modal.gc_code == undefined || $scope.modal.product_gc_code == 'NaN') {
            var notify = $.notify('Oops there something wrong with gift certificate code!', {'type': 'danger',  allow_dismiss: true });
            return false;
        };

        if ($scope.modal.gc_amount == '' || $scope.modal.gc_amount == "" || $scope.modal.gc_amount == NaN || $scope.modal.gc_amount == null || $scope.modal.gc_amount == 0.00 || $scope.modal.gc_amount == undefined || $scope.modal.product_gc_amount == 'NaN') {
            var notify = $.notify('Oops there something wrong with gift certificate amount!', {'type': 'danger',  allow_dismiss: true });
            return false;
        };
        return nestedConfirmDialog;
    },
    scope: $scope,
    showClose: false
})
.then(function(value){
    return false;
}, function(value){
cfpLoadingBar.start();
    $scope.modal = {
        cashier_user_id : $scope.user.user_id,
        gc_name : $scope.modal.gc_name, 
        gc_code : $scope.modal.gc_code,
        gc_amount : $scope.modal.gc_amount
    };

    $scope.cash = $scope.modal.gc_amount;
    $scope.cash_status = true;
    $scope.gift_status = true;

    var promise = ProductFactory.gift_certificate_data($scope.modal);
    promise.then(function(data){
        var notify = $.notify('You have succesfully added the gift certificate', { 'type': 'success', allow_dismiss: true });
        get_supplier_data();
        cfpLoadingBar.complete();
    })
    .then(null, function(data){
        var notify = $.notify('Oops there something wrong!', { 'type': 'danger', allow_dismiss: true });
        cfpLoadingBar.complete();
    });

});

}

$scope.stock_checker = function(k){

    var stock_quantity_tempo 

    var stock_quantity
    stock_quantity = $scope.tender_data[k].product_quantity;
    var pk_data
    pk_data = $scope.tender_data[k].pk;
    var prd_stcks
    prd_stcks = $scope.tender_data[k].product_stocks;
    var datax
    datax = $scope.tender_data[k].pk;
    var prd_code = false;
    prd_code = $scope.tender_data[k].product_product_code;

    var new_stat = false;

    $scope.stock_amount_pk = datax;

    for (var i in $scope.product_data_checker){
        if (prd_code == "NO DATA" || prd_code == 'NO DATA' || prd_code == 'LC COMBO' || prd_code == "LC COMBO" || prd_code == 'DC COMBO' || prd_code == "DC COMBO" || prd_code == 'BC COMBO' || prd_code == "BC COMBO" || prd_code == 'MC COMBO' || prd_code == "MC COMBO") {
            if (pk_data == $scope.product_data_checker[i].pk) {
                $scope.stock_amount = parseInt(prd_stcks) - parseInt(stock_quantity);
                $scope.stock_amount_finalized = $scope.stock_amount;
                $scope.stock_amount_status = false;
                $scope.tender_new.push({
                    newstock:$scope.stock_amount,
                    status:$scope.stock_amount_status,
                    pk:pk_data
                })
            }
        }else if (prd_code == $scope.product_data_checker[i].product_product_code) {
            $scope.stock_amount = parseInt(prd_stcks) - parseInt(stock_quantity);
            $scope.stock_amount_finalized = $scope.stock_amount;
            $scope.product_code = prd_code;
            $scope.stock_amount_status = true;
            $scope.new_stat = true;
            $scope.tender_new.push({
                newstock:$scope.stock_amount,
                status:$scope.stock_amount_status,
                pk:$scope.product_data_checker[i].pk
            })
        }else{
            if (pk_data == $scope.product_data_checker[i].pk) {
                $scope.stock_amount = parseInt(prd_stcks) - parseInt(stock_quantity);
                $scope.stock_amount_finalized = $scope.stock_amount;
                $scope.stock_amount_status = false;
                $scope.tender_new.push({
                    newstock:$scope.stock_amount,
                    status:$scope.stock_amount_status,
                    pk:pk_data
                })
            }
        }

    };

    


/*if (prd_code != 'No Code') {
$scope.stock_amount_status = true;
};*/

$scope.stock_amount = parseInt($scope.tender_data[k].product_stocks) - parseInt(stock_quantity) ;
$scope.stock_amount_finalized = $scope.stock_amount;

if ($scope.stock_amount <= 0) {

    $scope.modal = {
        title : 'WARNING!',
        close : 'Close'
    }     

    ngDialog.openConfirm({
        template: 'AdviceModal',
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

    });

};

if (stock_quantity >= prd_stcks) {
    $scope.modal = {
        title : 'WARNING!',
        close : 'Close'
    }     

    ngDialog.openConfirm({
        template: 'AdviceExceedModal',
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
    });
};
if ($scope.product_total_temporary < 50 || $scope.product_total_temporary < '50') {
    $scope.aomos_dscnt_status = true;
}else{
    $scope.aomos_dscnt_status = false;
};

/*var data = {
stock_amount : $scope.stock_amount,
pk : datax
}
var promise = ProductFactory.update_stocks(data);
promise.then(function(data){
})
.then(null, function(data){

});*/

}

$scope.cancel_transaction = function(){

    $scope.modal = {
        title : 'Please input a pin',
        save : 'Confirm',
        close : 'Cancel'
    }     

    ngDialog.openConfirm({
        template: 'InputPinModal',
        className: 'ngdialog-theme-plain dialogwidth400',
        preCloseCallback: function(value) {
            var nestedConfirmDialog;
            $scope.form.pin = md5.createHash($scope.modal.pin);
            cfpLoadingBar.start();
            if($scope.form.pin != $scope.user.superior_pin){
                var notify = $.notify('The Pin is incorrect!', {'type': 'danger', allow_dismiss: true });
                return false;
            }
            $route.reload();
            cfpLoadingBar.complete();
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

$scope.next_transaction = function(){
    $route.reload();
}

$scope.check_amount = function(cash){
    if (cash < $scope.product_total_temporary) {
        var notify = $.notify('Oops your money is not enough!', {'type': 'danger', allow_dismiss: true });
        $scope.tender_show = false;
        return false;
    }; 

    $scope.tender_show = true;
}

$scope.void_product = function(k){
    

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
            if ($scope.form.pin == $scope.user.superior_pin) {
                $scope.tender_voided.count += 1;
                $scope.tender_voided.value = $scope.tender_data[k].product_price;
                $scope.tender_data[k].product_price = 0;
                $scope.tender_data[k].product_quantity = 0;
                $scope.tender_data[k].status = false;
                $scope.tender_data.splice(k, 1);
                $scope.product_total_temporary = $scope.product_total_temporary - $scope.tender_voided.value;
            }else{
                var notify = $.notify('Oops wrong pincode!', { allow_dismiss: true });
                return false;
            };
            
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

$scope.discount_product = function(k){
    

    $scope.modal = {
        title : 'Please input the discount amount',
        save : 'Discount',
        close : 'Cancel'
    }     

    ngDialog.openConfirm({
        template: 'DiscountModal',
        className: 'ngdialog-theme-plain dialogwidth400',
        preCloseCallback: function(value) {
            var nestedConfirmDialog;
            $scope.form.pin = md5.createHash($scope.modal.pin);
            if ($scope.form.pin == $scope.user.superior_pin) {
                $scope.tender_voided.value = $scope.tender_data[k].product_price;
                $scope.tender_data[k].product_price = $scope.tender_voided.value - $scope.modal.discntamnt;
                $scope.product_total_temporary = $scope.product_total_temporary - $scope.modal.discntamnt;
                var notify = $.notify('You have succesfully discounted the product', { allow_dismiss: true });
            }else{
                var notify = $.notify('Oops wrong pincode!', { allow_dismiss: true });
                return false;
            };
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

/*$scope.stock_finalizer = function(){

var stock_quantity
stock_quantity = $scope.tender_data.product_quantity;
var prd_stcks
prd_stcks = $scope.tender_data.product_stocks;
for (var i in tender_data) {
stock_quantity = $scope.tender_data[i].product_quantity;
prd_stcks = $scope.tender_data[i].product_stocks;
};
$scope.stock_amount = parseInt($scope.tender_data.product_stocks) - parseInt(stock_quantity) ;

console.log(stock_quantity);
console.log(prd_stcks);
console.log($scope.stock_amount);

}*/

function tender_status_true(){
        $scope.tender_show = true;
}


$scope.tender_product_final = function(){
    cfpLoadingBar.start();
    maketransaction_number();
    var b = 0;
    var g = 0;
    for (var i in $scope.tender_data) {
        console.log($scope.tender_data[i].selling_price);
        b = parseFloat($scope.tender_data[i].product_quantity) * parseFloat($scope.tender_data[i].selling_price); 
        $scope.tender_data[i].tempo_total = b.toFixed(2);
        $scope.tender_data[i].tempor_total = $scope.tender_data[i].selling_price; 
        g += parseInt($scope.tender_data[i].product_quantity); 
        $scope.form.product_count = g;
    };

    $scope.form.totaaal = 0;
    for (var k in $scope.tender_data) {
        $scope.form.totaaal += parseFloat($scope.tender_data[k].tempo_total);
        $scope.form.final_totaal = $scope.form.totaaal.toFixed(2);
    };

/*
var stock_quantity
var prd_stcks*/


for (var z in $scope.tender_data){
    $scope.product_total += parseFloat($scope.tender_data[z].product_price);
};

for (var o in $scope.tender_data) {
    $scope.tender_data[o].product_price = $scope.tender_data[o].product_price.toFixed(2);
    
};

for (var u in $scope.tender_data) {
    $scope.tender_data[u].stock_amount_finalized = $scope.stock_amount_finalized;
};

for (var b in $scope.tender_data) {
    $scope.tender_data[b].stock_amount_status = $scope.stock_amount_status;
};
for (var s in $scope.tender_data) {
    $scope.tender_data[s].final_date_tendered = $scope.date_ngayon;
};


/*for (var o in $scope.tender_data){
stock_quantity = $scope.tender_data[o].product_quantity;
prd_stcks = $scope.tender_data[o].product_stocks;
$scope.stock_amount = parseInt(prd_stcks) - parseInt(stock_quantity) ;
};

console.log(stock_quantity);
console.log(prd_stcks);
console.log($scope.stock_amount);*/

var vat1
vat1 = parseFloat($scope.product_total) * .12 / 1.12;
$scope.vat = vat1.toFixed(2);
var net_amnt
net_amnt = parseFloat($scope.product_total) - vat1;
$scope.net_amount = net_amnt.toFixed(2);


            /*$scope.discount_2 = false;
            $scope.discount_3 = false;
            $scope.discount_5 = true;*/

/*if ($scope.aomos_staff_discount == true) {
var aomos_dscnt
var vat1
vat1 = parseFloat($scope.product_total) * .12 / 1.12;
$scope.vat = vat1.toFixed(2);
var net_amnt
net_amnt = parseFloat($scope.product_total) - vat1;
$scope.net_amount = net_amnt.toFixed(2);
aomos_dscnt = $scope.product_total * 0.05;
$scope.product_total = parseInt($scope.product_total) - aomos_dscnt;
$scope.aomos_staff_name = $scope.modal.aomos_staff;
$scope.discount_amounts = aomos_dscnt.toFixed(2);
}*/

var dscnt_amnt
var amnt_snr
if ($scope.discount == true) {
    dscnt_amnt = net_amnt * .20;
    $scope.discount_amounts = dscnt_amnt.toFixed(2);
    amnt_snr = net_amnt - dscnt_amnt;
    $scope.amount_senior = amnt_snr.toFixed(2);
    $scope.product_total = $scope.amount_senior;
};

if ($scope.voucherstatus == true) {
    $scope.cash = $scope.voucher.vamount;
};
/*
if ($scope.aomos_staff_discount != true) {
    $scope.aomos_staff_discount = false;
};*/
if ($scope.cash_status == true) {
    $scope.cash_status = false;
};

var temp_change
var tutal
tutal = parseFloat($scope.product_total);
temp_change = parseFloat($scope.cash) - parseFloat(tutal);
$scope.change = temp_change.toFixed(2);
/*$scope.change = temp_change.toFixed(2);*/

var r
var e
e = parseFloat($scope.cash);
r = e.toFixed(2);
$scope.form.r = r;
var w
var q
w = parseFloat($scope.product_total);

q = w.toFixed(2);
$scope.form.q = q;

if ($scope.gift_status == true) {
    $scope.form.r_name = 'Gift Certificate'
}else if($scope.voucherstatus == true){
    $scope.form.r_name = 'Voucher'
}else{
    $scope.form.r_name = 'Cash'
};


if ($scope.modal.gc_amount == undefined) {
    $scope.modal.gc_amount = 0;
    $scope.modal.gc_name = 'none';
    $scope.modal.gc_code = 'none';
}else if ($scope.modal.gc_amount != undefined) {
    $scope.change = 0;
};

var data = {
    vouchernumber: $scope.voucher.vnumber,
    vouchercustname: $scope.voucher.custname,
    voucherstatus: $scope.voucherstatus,
    cashier_user_id : $scope.user.user_id,
    product_transaction_number : $scope.form.transact_number,
    client_id : $scope.selected_customer.pk,
    data : JSON.stringify($scope.tender_data),
    data_new : JSON.stringify($scope.tender_new),
    vat_percentage : 12,
    net_amount : $scope.net_amount,
    vat : $scope.vat,
    discount : $scope.discount_amounts,
    change : $scope.change,
    gc_amount : $scope.modal.gc_amount,
    gc_name : $scope.modal.gc_name, 
    gc_code : $scope.modal.gc_code,
    cash : $scope.form.r,
    total : $scope.form.q,
    stock_amount_finalized : $scope.stock_amount_finalized,
    stock_amount_status : $scope.stock_amount_status,
    product_code : $scope.product_code,
    stock_amount_pk : $scope.stock_amount_pk,
    void_count : $scope.tender_voided.count,
    r_name : $scope.form.r_name,
    name : 'Tender',
    action : ' '+$scope.user.first_name+ ' ' +$scope.user.last_name+ ' ' +'tendered an item'
};

if (data.total == '' || data.total == "" || data.total == NaN || data.total == null || data.total == 0.00 || data.total == undefined || data.product_total == 'NaN') {
    var notify = $.notify('Oops there something wrong with total!', {'type': 'danger',  allow_dismiss: true });
    tender_status = true;
    cfpLoadingBar.complete();
    return false;
};
if (data.net_amount == '' || data.net_amount == "" || data.net_amount == NaN || data.net_amount == null || data.net_amount == undefined || data.net_amount == 'NaN') {
    var notify = $.notify('Oops there something wrong with net amount value!', {'type': 'danger' , allow_dismiss: true });
    tender_status = true;
    cfpLoadingBar.complete();
    return false;
};
if (data.vat == '' || data.vat == "" || data.vat == NaN || data.vat == null || data.vat == undefined || data.vat == 'NaN') {
    var notify = $.notify('Oops there something wrong with vat value!', {'type': 'danger' , allow_dismiss: true });
    tender_status = true;
    cfpLoadingBar.complete();
    return false;
};
if (data.change == NaN || data.change == null || data.change == undefined || data.change == 'NaN') {
    var notify = $.notify('Oops there something wrong with change value!', {'type': 'danger' , allow_dismiss: true });
    tender_status = true;
    cfpLoadingBar.complete();
    return false;
};
if (data.cash == '' || data.cash == 0.00 || data.cash == "" || data.cash == NaN || data.cash == null || data.cash == undefined || data.cash == 'NaN') {
    var notify = $.notify('Oops there something wrong with cash value!', {'type': 'danger' ,  allow_dismiss: true });
    tender_status = true;
    cfpLoadingBar.complete();
    return false;
};
/*if (data.total == '' || data.total == "" || data.total == NaN || data.total == null || data.total == undefined || data.total == 'NaN') {
var notify = $.notify('Oops there something wrong with total value!', { allow_dismiss: true });
$scope.tender_status = true;
return false;
};*/
$scope.filter.product_expiration = $filter('date')($scope.filter.product_expiration, "medium");
$scope.gift_status = true;
var promise = ProductFactory.tender_product(data);
promise.then(function(data){
    var notify = $.notify('You have succesfully tendered the products', { 'type': 'success', allow_dismiss: true });
    var is_walkin;
    var customer_name;
    var customer_address;
    var customer_tin;

    if ($scope.selected_customer.pk == 0) {
        is_walkin = 'true';
        customer_name = null;
        customer_address = null;
        customer_tin = null;
    } else {
        is_walkin = 'false';
        customer_name = $scope.selected_customer.client_name;
        customer_address = $scope.selected_customer.city;
        customer_tin = $scope.selected_customer.tin;
    }

    window.open('./FUNCTIONS/Uploads/receipt.php?total=' + $scope.form.final_totaal 
        + '&user_id_fname=' + $scope.user.first_name 
        + '&user_id_lname=' + $scope.user.last_name 
        + '&date_time=' + $scope.filter.product_expiration 
        + '&TI=' + $scope.form.transact_number
        + '&count=' + g
        + '&net_amnt=' + $scope.net_amount
        + '&vat=' + $scope.vat
        + '&change=' + $scope.change
        + '&total=' + q
        + '&change=' + $scope.change
        + '&discount=' + $scope.discount_amounts
        + '&cash=' + r
        + '&rname=' + $scope.form.r_name
        + '&is_walkin=' + is_walkin
        + '&customer_name=' + customer_name
        + '&customer_address=' + customer_address
        + '&customer_tin=' + customer_tin
        );
})
.then(null, function(data){
    var notify = $.notify('Oops there something wrong with tendering!', {'type': 'danger' ,  allow_dismiss: true });
    cfpLoadingBar.complete();
});
}

$scope.send_receipt = function(){
    

    $scope.modal = {
        title : 'Send Receipt Via E-mail',
        save : 'Send',
        close : 'Cancel'
    };

    ngDialog.openConfirm({
        template: 'SendReceiptModal',
        className: 'ngdialog-theme-plain dialogwidth400',
        scope: $scope,
        showClose: false
    })
    .then(function(value){
        return false;
    }, function(value){
        cfpLoadingBar.start();

        if ($scope.gift_status == true) {
            $scope.form.r_name = 'Gift Certificate'
        }else{
            $scope.form.r_name = 'Cash'
        };

        $scope.submit_datas = {
            product_transaction_number : $scope.form.transact_number,
            cashier_user_id : $scope.user.user_id,
            data : JSON.stringify($scope.tender_data),
            vat_percentage : 12,
            net_amount : $scope.net_amount,
            stock_amount_finalized : $scope.stock_amount_finalized,
            stock_amount_pk : $scope.stock_amount_pk,
            void_count : $scope.tender_voided.count,
            email : $scope.modal.email,
            user_id_fname : $scope.user.first_name,
            user_id_lname : $scope.user.last_name ,
            date_time :$scope.filter.product_expiration,
            TI : $scope.form.transact_number,
            count : $scope.form.product_count,
            message: '<p>Dear Customer,</p><div>&nbsp;</div><div>Attached is your official receipt. Thank you for shopping with us and see you very soon!</div><div>&nbsp;</div><div>For feedback and inquiries do not hesitate to email us via the email address written in the official receipt.</div><div>&nbsp;</div><div>Thank you!</div><div>&nbsp;</div><div>GoSari Team</div>',
            vat : $scope.vat,
            change :  $scope.change,
            total :  $scope.form.q,
            discount : $scope.discount_amounts,
            cash : $scope.form.r,
            r_name: $scope.form.r_name
        };

        var notify = $.notify('Please wait for the receipt to be send', { 'type': 'warning', allow_dismiss: true });

        var promise = ProductFactory.submit_toemail($scope.submit_datas);
        promise.then(function(data){
            var notify = $.notify('You have succesfully send the receipt', { 'type': 'success', allow_dismiss: true });
            cfpLoadingBar.complete();
        })
        .then(null, function(data){
            var notify = $.notify('Oops there something wrong!', { 'type': 'danger', allow_dismiss: true });
            cfpLoadingBar.complete();
        });

    });

}

$scope.send_remarks = function(v){
    var index = $scope.request_data.indexOf(v);

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
            pk : $scope.request_data[index].pk,
            remarks : $scope.form.remarks,
            email : $scope.user.email,
            message: '<p>Good Day '+$scope.request_data[index].first_name+' '+$scope.request_data[index].last_name+',</p><p>&nbsp;</p><p>I rejected your product request order because of the reason that '+$scope.form.remarks+'</p><p>&nbsp;</p><p>Warm Regards,</p><p>'+$scope.user.first_name+' '+$scope.user.last_name+'</p>'
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

$scope.get_all_products = function(){
    get_all_products();
}

function get_all_products(){
    cfpLoadingBar.start();

    if ($scope.filter.searchstring == undefined || $scope.filter.searchstring == '' || $scope.filter.searchstring == null) {
        $scope.filter.searchstring = undefined;
    }

    var filters = {
        wildcard : $scope.filter.searchstring
    };

    var promise = ProductFactory.get_all_products(filters);
    promise.then(function(data){
        $scope.product_data = data.data.result;

    })
    .then(null, function(data){
        $scope.result_status = 'maybe';
        cfpLoadingBar.complete();
    });
}


$scope.add_supplier = function(){
    cfpLoadingBar.start();
    if ($scope.form.supplier_name == '' || $scope.form.supplier_name == "" || $scope.form.supplier_name == NaN || $scope.form.supplier_name == null || $scope.form.supplier_name == undefined || $scope.form.supplier_name == 'NaN') {
        $.notify('Name is required!', {'type': 'danger' ,  allow_dismiss: true });
        cfpLoadingBar.complete();
        return;
    }
    if ($scope.form.supplier_address == '' || $scope.form.supplier_address == "" || $scope.form.supplier_address == NaN || $scope.form.supplier_address == null || $scope.form.supplier_address == undefined || $scope.form.supplier_address == 'NaN') {
        $.notify('Address is required!', {'type': 'danger' ,  allow_dismiss: true });
        cfpLoadingBar.complete();
        return;
    }
    if ($scope.form.supplier_contact_number == '' || $scope.form.supplier_contact_number == "" || $scope.form.supplier_contact_number == NaN || $scope.form.supplier_contact_number == null || $scope.form.supplier_contact_number == undefined || $scope.form.supplier_contact_number == 'NaN') {
        $.notify('Contact Number is required!', {'type': 'danger' ,  allow_dismiss: true });
        cfpLoadingBar.complete();
        return;
    }
    if ($scope.form.supplier_contact_person == '' || $scope.form.supplier_contact_person == "" || $scope.form.supplier_contact_person == NaN || $scope.form.supplier_contact_person == null || $scope.form.supplier_contact_person == undefined || $scope.form.supplier_contact_person == 'NaN') {
        $.notify('Contact Person is required!', {'type': 'danger' ,  allow_dismiss: true });
        cfpLoadingBar.complete();
        return;
    }
    if ($scope.form.supplier_code_name == '' || $scope.form.supplier_code_name == "" || $scope.form.supplier_code_name == NaN || $scope.form.supplier_code_name == null || $scope.form.supplier_code_name == undefined || $scope.form.supplier_code_name == 'NaN') {
        $.notify('Code Name is required!', {'type': 'danger' ,  allow_dismiss: true });
        cfpLoadingBar.complete();
        return;
    }
    var datas = {
        supplier_name : $scope.form.supplier_name,
        supplier_address : $scope.form.supplier_address,
        supplier_contact_number : $scope.form.supplier_contact_number,
        supplier_contact_person : $scope.form.supplier_contact_person,
        supplier_code_name : $scope.form.supplier_code_name,
        cashier_user_id : $scope.user.user_id,
        name : 'Supplier Adding',
        action : ' '+$scope.user.first_name+ ' ' +$scope.user.last_name+ ' ' +'added'+' '+$scope.form.supplier_name+' '+'in supplier section'
    }

    var promise = ProductFactory.add_supplier(datas);
    promise.then(function(data){
        var notify = $.notify('You have succesfully added a new supplier', { allow_dismiss: true });
        get_supplier_data();
        cfpLoadingBar.complete();
    })
    .then(null, function(data){
        var notify = $.notify('Oops there something wrong!', { allow_dismiss: true });
        cfpLoadingBar.complete();
    });
}

$scope.edit_supplier_data = function(v){
    
    var index = $scope.supplier_data.indexOf(v);

    $scope.modal = {
        title : 'Update Supplier Data',
        save : 'Update',
        close : 'Cancel',
        supplier_name : $scope.supplier_data[index].supplier_name,
        supplier_address : $scope.supplier_data[index].supplier_address,
        supplier_contact_number : $scope.supplier_data[index].supplier_contact_number,
        supplier_contact_person : $scope.supplier_data[index].supplier_contact_person,
        supplier_code_name : $scope.supplier_data[index].supplier_code_name
    };

    ngDialog.openConfirm({
        template: 'EditSupplierData',
        className: 'ngdialog-theme-plain dialogwidth500',
        preCloseCallback: function(value) {
            var nestedConfirmDialog;
            if($scope.modal.supplier_name == '' || $scope.modal.supplier_address == '' || $scope.modal.supplier_contact_number == '' || $scope.modal.supplier_contact_person == ''){

                var notify = $.notify('There is a blank encoded in the supplier data', {'type': 'danger', allow_dismiss: true });
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
            pk : $scope.supplier_data[index].pk,
            supplier_name : $scope.modal.supplier_name,
            supplier_address : $scope.modal.supplier_address,
            supplier_contact_number : $scope.modal.supplier_contact_number,
            supplier_contact_person : $scope.modal.supplier_contact_person,
            supplier_code_name : $scope.modal.supplier_code_name
        }


        var promise = ProductFactory.edit_supplier_data(datas);
        promise.then(function(data){
            var notify = $.notify('You have succesfully updated the supplier data', { 'type': 'success', allow_dismiss: true });
            get_supplier_data();
            cfpLoadingBar.complete();
        })
        .then(null, function(data){
            var notify = $.notify('Oops there something wrong!', { 'type': 'danger', allow_dismiss: true });
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
        message : '<p>Good Day Sir,</p><p>&nbsp;</p><p>I have already sent a product order for '+ $scope.product_data[index].product_name +' in Grand Pen POS with a quantity of '+ $scope.modal.product_quantity +', thanks</p><p>&nbsp;</p><p>Warm Regards,</p><p>'+$scope.user.first_name+' '+$scope.user.last_name +'</p>',
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
    })
    .then(null, function(data){
        var notify = $.notify('Oops there something wrong!', { 'type': 'danger', allow_dismiss: true });
        cfpLoadingBar.complete();
    });
});
}

$scope.delete_supplier_data = function(v){
    cfpLoadingBar.start();
    var index = $scope.supplier_data.indexOf(v);

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

        var datas = {
            pk : $scope.supplier_data[index].pk
        }


        var promise = ProductFactory.delete_supplier_data(datas);
        promise.then(function(data){
            var notify = $.notify('You have succesfully deleted the supplier', { 'type': 'success', allow_dismiss: true });
            get_supplier_data();
            cfpLoadingBar.complete();
        })
        .then(null, function(data){
            var notify = $.notify('Oops there something wrong!', { 'type': 'danger', allow_dismiss: true });
            cfpLoadingBar.complete();
        });

    });
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
        get_request_order_data();
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
        get_request_order_data();
        cfpLoadingBar.complete();
    })
    .then(null, function(data){
        var notify = $.notify('Oops there something wrong!', { 'type': 'danger', allow_dismiss: true });
        cfpLoadingBar.complete();
    });
}

$scope.search_po_order = function(){
    cfpLoadingBar.start();

    filter = {
        date_from : $filter('date')($scope.filter.po1._d, "yyyy-MM-dd"),
        date_to : $filter('date')($scope.filter.po2._d, "yyyy-MM-dd")
    };

    var promise = ProductFactory.get_request_order_data(filter);
    promise.then(function(data){
        $scope.request_data = data.data.result;
        $scope.request_data_status = true;
        

        var a = 0;
        for (var i in $scope.request_data) {
            $scope.request_data[i].product_date_needed = new Date($scope.request_data[i].product_date_needed);
            $scope.request_data[i].product_date_needed = moment($scope.request_data[i].product_date_needed).format('LLLL');
            $scope.request_data[i].date_created = new Date($scope.request_data[i].date_created);
            $scope.request_data[i].date_created = moment($scope.request_data[i].date_created).format('LLLL');
            $scope.request_data[i].number = a += 1;
        };

        $scope.totalItems_orderdata = $scope.request_data.length;
    })
    .then(null, function(data){
        $scope.request_data_status = false;
cfpLoadingBar.complete();

    });
}

$scope.setPage_orderdata = function (pageNo) {
    $scope.currentPage_orderdata = pageNo;
};

$scope.pageChanged_orderdata = function() {
    console.log('Page changed to: ' + $scope.currentPage_orderdata);
};

$scope.setItemsPerPage_orderdata = function(num) {
    $scope.itemsPerPage_orderdata = num;
$scope.currentPage_orderdata = 1; //reset to first paghe
}

$scope.print_po = function(){
    window.open('./FUNCTIONS/Uploads/print_po.php?date_from='+filter.date_from+'&date_to='+filter.date_to
        );
}
$scope.print_items = function(){
    window.open('./FUNCTIONS/Uploads/print_items.php?wildcard='+filters.wildcard+'&wildcard2='+filters.wildcard2+'&wildcard3='+filters.wildcard3
        );
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

        $scope.totalItems_productdata = $scope.product_data.length;
        $scope.stocks_statuses = true;
        $scope.stocks_status = 1;
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

var upload_image = $scope.upload_image = new FileUploader({
    url: 'FUNCTIONS/Uploads/upload_image.php'
});

upload_image.filters.push({
    'name': 'enforceMaxFileSize',
    'fn': function (item) {
        return item.size <= 10485760; 
    }
});

upload_image.onWhenAddingFileFailed = function(item /*{File|FileLikeObject}*/, filter, options) {
//console.info('onWhenAddingFileFailed', item, filter, options);
};
upload_image.onAfterAddingFile = function(fileItem) {
//console.info('onAfterAddingFile', fileItem);
};
upload_image.onAfterAddingAll = function(addedFileItems) {
//console.info('onAfterAddingAll', addedFileItems);
};
upload_image.onBeforeUploadItem = function(item) {
//console.info('onBeforeUploadItem', item);
};
upload_image.onProgressItem = function(fileItem, progress) {
//console.info('onProgressItem', fileItem, progress);
};
upload_image.onProgressAll = function(progress) {
//console.info('onProgressAll', progress);
};
upload_image.onSuccessItem = function(fileItem, response, status, headers) {
//console.info('onSuccessItem', fileItem, response, status, headers);
};
upload_image.onErrorItem = function(fileItem, response, status, headers) {
//console.info('onErrorItem', fileItem, response, status, headers);
};
upload_image.onCancelItem = function(fileItem, response, status, headers) {
//console.info('onCancelItem', fileItem, response, status, headers);
};
upload_image.onCompleteItem = function(fileItem, response, status, headers) {
// console.log('onCompleteItem', fileItem, respsonse, status, headers);
//$scope.data.quotationmodal.attachment = response.file;
$scope.modal.image_source = response.file;


};
upload_image.onCompleteAll = function() {

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


};
edit_upload_image.onCompleteAll = function() {

};

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

$scope.edit_permission = function(v){
    $scope.modal = {
        title : 'Edit Permission of '+v.first_name+' '+v.last_name,
        save : 'Update',
        close : 'Close',
        permissions : JSON.parse(v.permission),
        user_id : v.user_id
    }     
    ngDialog.openConfirm({
        template: 'EditPermission',
        className: 'ngdialog-theme-plain dialogwidth500',
        scope: $scope,
        showClose: false
    })
    .then(function(value){
        return false;
    }, function(value){
        cfpLoadingBar.start();
        $scope.modal.permission = JSON.stringify($scope.modal.permissions);
        var promise = ProductFactory.edit_permission($scope.modal);
        promise.then(function(data){
            var notify = $.notify('You have succesfully updated the user', { 'type': 'success', allow_dismiss: true });
            get_added_user_data();
            cfpLoadingBar.complete();
        })
        .then(null, function(data){
            var notify = $.notify('Oops there is something wrong!', { 'type': 'danger', allow_dismiss: true });
            cfpLoadingBar.complete();
        });
    });
}

$scope.update_this = function(v){

    var index = $scope.product_data.indexOf(v);

    var datas = {
        pk : $scope.product_data[index].pk,
        product_srp : $scope.product_data[index].product_srp,
        product_price : $scope.product_data[index].product_price
    }
    $scope.form.pk = datas.pk;
    $scope.form.input_vat1 = datas.product_srp / 1.12 * .12;
    $scope.form.input_vat2 = parseFloat($scope.form.input_vat1).toFixed(2);
    //Markup Price is Product Price
    //VAT Output is based on Branch VAT Registered or Not
    $scope.form.product_price = parseInt(datas.product_price);
    $scope.form.output_vat1 = $scope.form.product_price / 1.12 * .12;
    $scope.form.output_vat2 = $scope.form.output_vat1.toFixed(2);
    $scope.form.selling_price1 = $scope.form.product_price + parseInt($scope.form.output_vat2);
    $scope.finals.pk = $scope.form.pk;
    $scope.finals.input_vat3 = $scope.form.input_vat2;
    $scope.finals.output_vat3 = $scope.form.output_vat2;
    $scope.finals.selling_price2 = $scope.form.selling_price1;
    
        var promise = ProductFactory.update_this($scope.finals);
        promise.then(function(data){
            var notify = $.notify('You have succesfully updated the user', { 'type': 'success', allow_dismiss: true });
            get_product_data();
            cfpLoadingBar.complete();
        })
        .then(null, function(data){
            var notify = $.notify('Oops there is something wrong!', { 'type': 'danger', allow_dismiss: true });
            cfpLoadingBar.complete();
        });
}

$scope.change_pin = function(){


    $scope.modal = {
        title : 'Change Superior Pin',
        save : 'Update',
        close : 'Cancel'
    }     

    ngDialog.openConfirm({
        template: 'ChangePin',
        className: 'ngdialog-theme-plain dialogwidth500',
        preCloseCallback: function(value) {
            var nestedConfirmDialog;
            $scope.form.old_pass = $scope.user.superior_pin;
            $scope.form.old_pass1 = md5.createHash($scope.modal.old_password);
            if($scope.form.old_pass1 != $scope.form.old_pass){
                var notify = $.notify('The Old Pin is incorrect!', {'type': 'danger', allow_dismiss: true });
                cfpLoadingBar.complete();
                return false;
            }
            if($scope.modal.password1 == '' || $scope.modal.password1 == "" || $scope.modal.password1 == undefined || $scope.modal.password1 == 'undefined' || $scope.modal.password1 == "undefined"){
                var notify = $.notify('The New Pin did not match!', {'type': 'danger', allow_dismiss: true });
                cfpLoadingBar.complete();
                return false;
            }

            if($scope.modal.password2 == '' || $scope.modal.password2 == "" || $scope.modal.password2 == undefined || $scope.modal.password2 == 'undefined' || $scope.modal.password2 == "undefined"){
                var notify = $.notify('The New Pin did not match!', {'type': 'danger', allow_dismiss: true });
                cfpLoadingBar.complete();
                return false;
            }

            if($scope.modal.password1 != $scope.modal.password2){
                var notify = $.notify('The New Pin did not match!', {'type': 'danger', allow_dismiss: true });
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
        $scope.modal.new_password = md5.createHash($scope.modal.password1);

        var promise = ProductFactory.update_pin($scope.modal);
        promise.then(function(data){
            var notify = $.notify('You have succesfully updated your superior pin', { 'type': 'success', allow_dismiss: true });
            get_added_user_data();
            $route.reload();
            cfpLoadingBar.complete();
        })
        .then(null, function(data){
            var notify = $.notify('Oops there is something wrong!', { 'type': 'danger', allow_dismiss: true });
            cfpLoadingBar.complete();
        });
    });
}

$scope.down_payment = function(){

    $scope.modal = {
        title : 'Down Payment',
        save : 'Tender',
        close : 'Close'
    };

    ngDialog.openConfirm({
        template: 'DownPaymentModal',
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
        $scope.tender_product_final_down_payment();
    });
};

$scope.uppercaseModalWords = function(field) {
    var value = $scope.modal[field];
    var valueArray = [];
    valueArray = value.split(' ');

    for (var i = 0; i < valueArray.length; i++) {
        valueArray[i] = valueArray[i].charAt(0).toUpperCase() + valueArray[i].substring(1);
    }

    value = valueArray.join(' ');

    $scope.modal[field] = value;
};

$scope.uppercaseFormWords = function(field) {
    var value = $scope.form[field];
    var valueArray = [];
    valueArray = value.split(' ');

    for (var i = 0; i < valueArray.length; i++) {
        valueArray[i] = valueArray[i].charAt(0).toUpperCase() + valueArray[i].substring(1);
    }

    value = valueArray.join(' ');

    $scope.form[field] = value;
};

$scope.tender_product_final_down_payment = function(){
        cfpLoadingBar.start();
        maketransaction_number();
        $scope.modal.cname = $scope.modal.cname;
        $scope.modal.down_payment_amount = $scope.modal.down_payment_amount;
        $scope.cash = $scope.modal.down_payment_amount;
        var b = 0;
        var g = 0;
        for (var i in $scope.tender_data) {
            b = parseFloat($scope.tender_data[i].product_price);
            $scope.tender_data[i].tempo_total = b.toFixed(2);
            $scope.tender_data[i].tempor_total = $scope.tender_data[i].product_price.toFixed(2); 
            g += parseInt($scope.tender_data[i].product_quantity); 
            $scope.form.product_count = g;
        };

        $scope.form.totaaal = 0;
        for (var k in $scope.tender_data) {
            $scope.form.totaaal += parseFloat($scope.tender_data[k].tempo_total);
            $scope.form.final_totaal = $scope.form.totaaal.toFixed(2);
        };

/*
var stock_quantity
var prd_stcks*/


// for (var z in $scope.tender_data){
//     $scope.product_total += parseFloat($scope.tender_data[z].product_retail_price);
// };

for (var z in $scope.tender_data){
    $scope.product_total += parseFloat($scope.tender_data[z].product_price);
};

for (var o in $scope.tender_data) {
    $scope.tender_data[o].product_price = $scope.tender_data[o].product_price.toFixed(2);
    /*console.log($scope.tender_data[o].product_price);*/
};

for (var u in $scope.tender_data) {
    $scope.tender_data[u].stock_amount_finalized = $scope.stock_amount_finalized;
};

for (var b in $scope.tender_data) {
    $scope.tender_data[b].stock_amount_status = $scope.stock_amount_status;
};

/*for (var o in $scope.tender_data){
stock_quantity = $scope.tender_data[o].product_quantity;
prd_stcks = $scope.tender_data[o].product_stocks;
$scope.stock_amount = parseInt(prd_stcks) - parseInt(stock_quantity) ;
};

console.log(stock_quantity);
console.log(prd_stcks);
console.log($scope.stock_amount);*/

var net_amnt;
net_amnt = parseFloat($scope.product_total);
$scope.net_amount = $scope.product_total;
var dscnt_amnt;
var amnt_snr;
if ($scope.discount == true) {
    dscnt_amnt = net_amnt * .20;
    $scope.discount_amounts = dscnt_amnt.toFixed(2);
    amnt_snr = net_amnt - dscnt_amnt;
    $scope.amount_senior = amnt_snr.toFixed(2);
    $scope.product_total = $scope.amount_senior;
}else if ($scope.company_discount == true) {
    dscnt_amnt = net_amnt * $scope.company_discount_percent;
    $scope.discount_amounts = dscnt_amnt.toFixed(2);
    amnt_snr = net_amnt - dscnt_amnt;
    $scope.amount_senior = amnt_snr.toFixed(2);
    $scope.product_total = $scope.amount_senior;
}else{
    $scope.discount_amounts = 0;
};

if ($scope.cash_status == true) {
    $scope.cash_status = false;
};

var temp_change
temp_change = parseFloat($scope.product_total) - parseFloat($scope.cash);
$scope.change = temp_change.toFixed(2);

var r
var e
e = parseFloat($scope.cash);
r = e.toFixed(2);
$scope.form.r = r;
var w
var q
w = parseFloat($scope.product_total);
q = w.toFixed(2);
$scope.form.q = q;

if ($scope.gift_status == true) {
    $scope.form.r_name = 'Gift Certificate'
}else{
    $scope.form.r_name = 'Cash'
};


if ($scope.modal.gc_amount == undefined) {
    $scope.modal.gc_amount = 0;
    $scope.modal.gc_name = 'none';
    $scope.modal.gc_code = 'none';
}else if ($scope.modal.gc_amount != undefined) {
    $scope.change = 0;
};

var data = {
    product_transaction_number : $scope.form.transact_number,
    cashier_user_id : $scope.user.user_id,
    data : JSON.stringify($scope.tender_data),
    data_new : JSON.stringify($scope.tender_new),
    vat_percentage : 12,
    net_amount : $scope.net_amount,
    vat : $scope.vat,
    discount : $scope.discount_amounts,
    cname : $scope.modal.cname,
    down_payment_amount : $scope.modal.down_payment_amount,
    change : $scope.change,
    gc_amount : $scope.modal.gc_amount,
    gc_name : $scope.modal.gc_name, 
    gc_code : $scope.modal.gc_code,
    cash : $scope.form.r,
    total : $scope.form.q,
    stock_amount_finalized : $scope.stock_amount_finalized,
    stock_amount_status : $scope.stock_amount_status,
    product_code : $scope.product_code,
    stock_amount_pk : $scope.stock_amount_pk,
    void_count : $scope.tender_voided.count,
    r_name : $scope.form.r_name,
    name : 'Down Payment',
    action : ' '+$scope.user.first_name+ ' ' +$scope.user.last_name+ ' ' +'tendered an item',
    cnumber : $scope.cnumber_pwdc

};


if (data.total == '' || data.total == "" || data.total == NaN || data.total == null || data.total == 0.00 || data.total == undefined || data.product_total == 'NaN') {
    var notify = $.notify('Oops there something wrong with total!', {'type': 'danger',  allow_dismiss: true });
    tender_status = true;
    cfpLoadingBar.complete();
    return false;
};
if (data.net_amount == '' || data.net_amount == "" || data.net_amount == NaN || data.net_amount == null || data.net_amount == undefined || data.net_amount == 'NaN') {
    var notify = $.notify('Oops there something wrong with net amount value!', {'type': 'danger' , allow_dismiss: true });
    tender_status = true;
    cfpLoadingBar.complete();
    return false;
};
if (data.change == NaN || data.change == null || data.change == undefined || data.change == 'NaN') {
    var notify = $.notify('Oops there something wrong with change value!', {'type': 'danger' , allow_dismiss: true });
    tender_status = true;
    cfpLoadingBar.complete();
    return false;
};
if (data.cash == '' || data.cash == 0.00 || data.cash == "" || data.cash == NaN || data.cash == null || data.cash == undefined || data.cash == 'NaN') {
    var notify = $.notify('Oops there something wrong with cash value!', {'type': 'danger' ,  allow_dismiss: true });
    tender_status = true;
    cfpLoadingBar.complete();
    return false;
};
/*if (data.total == '' || data.total == "" || data.total == NaN || data.total == null || data.total == undefined || data.total == 'NaN') {
var notify = $.notify('Oops there something wrong with total value!', { allow_dismiss: true });
$scope.tender_status = true;
return false;
};*/
$scope.tender_status = true;
$scope.filter.product_expiration = $filter('date')($scope.filter.product_expiration, "medium");
$scope.gift_status = true;
var promise = ProductFactory.tender_product_final_down_payment(data);
promise.then(function(data){
    var notify = $.notify('You have succesfully tendered the products', { 'type': 'success', allow_dismiss: true });
    window.open('./FUNCTIONS/Uploads/receipt.php?total=' + $scope.form.final_totaal 
        + '&user_id_fname=' + $scope.user.first_name 
        + '&user_id_lname=' + $scope.user.last_name 
        + '&date_time=' + $scope.filter.product_expiration 
        + '&TI=' + $scope.form.transact_number
        + '&count=' + g
        + '&net_amnt=' + $scope.net_amount
        + '&vat=' + $scope.vat
        + '&change=' + $scope.change
        + '&total=' + q
        + '&change=' + $scope.change
        + '&discount=' + $scope.discount_amounts
        + '&cash=' + r
        + '&rname=' + $scope.form.r_name
        );

})
.then(null, function(data){
    var notify = $.notify('Oops there something wrong with tendering!', {'type': 'danger' ,  allow_dismiss: true });
    cfpLoadingBar.complete();
});
}

});