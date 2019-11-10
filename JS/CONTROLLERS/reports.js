app.controller('Reports', function( 
                                $scope,
                                SessionFactory,
                                UserFactory,
                                ProductFactory,
                                md5,
                                $filter,
                                ngDialog,
                                $route,
                                cfpLoadingBar
                                ) 
{

    $scope.user = {};

    $scope.form = {};
    $scope.filter = {};
    $scope.pr_name = {};
    $scope.clicker_status = false;
    $scope.cashier_name = {};
    $scope.final_total_ito = 0;
    $scope.tender_data_status = {};
    $scope.bestselling_status = {};
    $scope.receipts_data_back_status = {};
    $scope.or_list_data_status = {};
    $scope.totalItems_reportdata = 0;

    $scope.viewby_orderdata = 10;
    $scope.currentPage_orderdata = 4;
    $scope.itemsPerPage_orderdata = $scope.viewby_orderdata;
    $scope.maxSize = 5;

    $scope.viewby_receipts_data = 10;
    $scope.currentPage_receipts_data = 4;
    $scope.itemsPerPage_receipts_data = $scope.viewby_receipts_data;
    $scope.maxSize = 5;

    $scope.viewby_bestselling = 10;
    $scope.currentPage_bestselling = 4;
    $scope.itemsPerPage_bestselling = $scope.viewby_bestselling;
    $scope.maxSize = 5;

    $scope.viewby_reportdata = 10;
    $scope.currentPage_reportdata = 4;
    $scope.itemsPerPage_reportdata = $scope.viewby_reportdata;
    $scope.maxSize = 5;

    $scope.search_filter = {
        name : 'All',
        date_from : undefined,
        date_to : undefined
    };

    $scope.search_value = "";
    $scope.product_transaction_number = "";
    $scope.product_name = "";
    $scope.full_name = "";
    $scope.sortFieldIndex = null;
    $scope.arrowSort = null;

    var filtered = {};
    var current_sort_direction = null;
    var current_sort_field = null;

    init();

    $scope.vm = {};
    $scope.vm.options = {format: 'YYYY/MM/DD HH:mm', showClear: true};

    function init(){
        var promise = SessionFactory.getsession();
        promise.then(function(data){
            var _id = md5.createHash('pk');
            $scope.pk = data.data[_id];
            get_user();
            DEFAULTDATES();

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
            get_or_data();
            get_cashier();
            get_reports();

        })
        .then(null, function(data){
            var promise = SessionFactory.logout();
            promise.then(function(data){
                window.location = './login.html';
            });
        });
    }

    function get_cashier(){

        var promise = UserFactory.get_cashier();
        promise.then(function(data){
            $scope.cashier_data = data.data.result;

        })
        .then(null, function(data){

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
        $scope.filter.sales_from = new Date();
        $scope.filter.sales_to = new Date();
        $scope.form.sales_to = new Date();
        $scope.form.sales_from = new Date();
        $scope.form.date1 = new Date();
        $scope.form.date2 = new Date();
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


    $scope.search_or = function(){
        cfpLoadingBar.start();
        if ($scope.form.search == "") {
            get_or_data();
        }

        var filters = {
            wildcard : $scope.form.search_or
        };


        var promise = ProductFactory.get_product_data_or(filters);
        promise.then(function(data){
            $scope.or_list_data = data.data.result;


            var a = 0;
            for (var i in $scope.or_list_data) {
                $scope.or_list_data[i].product_expiration = new Date($scope.or_list_data[i].product_expiration);
                $scope.or_list_data[i].product_expiration = moment($scope.or_list_data[i].product_expiration).format('LLLL');
                $scope.or_list_data[i].date_created = moment($scope.or_list_data[i].date_created).format('LLLL');
                $scope.or_list_data[i].number = a += 1;
            };

            var x = .12;
            for (var i in $scope.or_list_data) {
                $scope.form.vat_wamount = x * $scope.or_list_data[i].product_srp;
                $scope.or_list_data[i].wamount1 = parseFloat($scope.or_list_data[i].product_srp) + parseFloat($scope.form.vat_wamount);
                $scope.or_list_data[i].wamount3 = parseFloat($scope.or_list_data[i].wamount1).toFixed(2);

            };

            for (var z in $scope.or_list_data) {
                if ($scope.or_list_data[z].product_status == '(OLD)') {
                    $scope.or_list_data[z].product_status_color = 1;
                    $scope.or_list_data[z].product_status_color1 = 'red';
                }
                if ($scope.or_list_data[z].product_status == '(NEW)') {
                    $scope.or_list_data[z].product_status_color = 1;
                    $scope.or_list_data[z].product_status_color1 = 'green';
                }
            };

            for (var i in $scope.or_list_data) {
                if ($scope.or_list_data[i].product_srp == undefined || $scope.or_list_data[i].product_srp == "undefined" || $scope.or_list_data[i].product_srp == NaN || $scope.or_list_data[i].product_srp == 'NaN' || $scope.or_list_data[i].product_srp == '' || $scope.or_list_data[i].product_srp == "") {
                    $scope.or_list_data[i].product_srp = 0;
                    $scope.or_list_data[i].wamount3 = 0;
                    $scope.or_list_data[i].product_price = 0;
                };
            };

            var b = 0;
            for (var i in $scope.or_list_data) {
                b = parseFloat($scope.or_list_data[i].product_stocks) * parseFloat($scope.or_list_data[i].wamount3); 
                $scope.or_list_data[i].tempo_total = b.toFixed(2);

            };

            $scope.form.totaaal = 0;
            for (var k in $scope.or_list_data) {
                $scope.form.totaaal += parseFloat($scope.or_list_data[k].tempo_total);
                $scope.form.final_totaal = $scope.form.totaaal.toFixed(2);

            };

            $scope.or_list_data_status = true;

        })
        .then(null, function(data){
            $scope.or_list_data_status = false;
            cfpLoadingBar.complete();
        });
    }

    function get_or_data(){
        cfpLoadingBar.start();
        var promise = ProductFactory.get_data_or();
        promise.then(function(data){
            $scope.or_list_data = data.data.result;


            var a = 0;
            for (var i in $scope.or_list_data) {
                $scope.or_list_data[i].product_expiration = new Date($scope.or_list_data[i].product_expiration);
                $scope.or_list_data[i].product_expiration = moment($scope.or_list_data[i].product_expiration).format('LLLL');
                $scope.or_list_data[i].date_created = moment($scope.or_list_data[i].date_created).format('LLLL');
                $scope.or_list_data[i].number = a += 1;
            };

            var x = .12;
            for (var i in $scope.or_list_data) {
                $scope.form.vat_wamount = x * $scope.or_list_data[i].product_srp;
                $scope.or_list_data[i].wamount1 = parseFloat($scope.or_list_data[i].product_srp) + parseFloat($scope.form.vat_wamount);
                $scope.or_list_data[i].wamount3 = parseFloat($scope.or_list_data[i].wamount1).toFixed(2);

            };

            for (var z in $scope.or_list_data) {
                if ($scope.or_list_data[z].product_status == '(OLD)') {
                    $scope.or_list_data[z].product_status_color = 1;
                    $scope.or_list_data[z].product_status_color1 = 'red';
                }
                if ($scope.or_list_data[z].product_status == '(NEW)') {
                    $scope.or_list_data[z].product_status_color = 1;
                    $scope.or_list_data[z].product_status_color1 = 'green';
                }
            };

            for (var i in $scope.or_list_data) {
                if ($scope.or_list_data[i].product_srp == undefined || $scope.or_list_data[i].product_srp == "undefined" || $scope.or_list_data[i].product_srp == NaN || $scope.or_list_data[i].product_srp == 'NaN' || $scope.or_list_data[i].product_srp == '' || $scope.or_list_data[i].product_srp == "") {
                    $scope.or_list_data[i].product_srp = 0;
                    $scope.or_list_data[i].wamount3 = 0;
                    $scope.or_list_data[i].product_price = 0;
                };
            };

            var b = 0;
            for (var i in $scope.or_list_data) {
                b = parseFloat($scope.or_list_data[i].product_stocks) * parseFloat($scope.or_list_data[i].wamount3); 
                $scope.or_list_data[i].tempo_total = b.toFixed(2);

            };

            $scope.form.totaaal = 0;
            for (var k in $scope.or_list_data) {
                $scope.form.totaaal += parseFloat($scope.or_list_data[k].tempo_total);
                $scope.form.final_totaal = $scope.form.totaaal.toFixed(2);

            };

            $scope.or_list_data_status = true;
        })
        .then(null, function(data){
            $scope.or_list_data_status = false;
            cfpLoadingBar.complete();
        });
    }


    $scope.get_receipts = function(){
        cfpLoadingBar.start();
        var filter = {
            name : $scope.form.cashier_name,
            date_from : $filter('date')($scope.form.sales_from._d, "mediumDate"),
            date_to : $filter('date')($scope.form.sales_to._d, "mediumDate")
        };
        var promise = ProductFactory.get_receipts(filter);
        promise.then(function(data){
            $scope.receipts_data = data.data.result;


            var a = 0;
            for (var i in $scope.receipts_data) {
                $scope.receipts_data[i].date_created = new Date($scope.receipts_data[i].date_created);
                $scope.receipts_data[i].date_created = moment($scope.receipts_data[i].date_created).format('LLLL');
                $scope.receipts_data[i].number = a += 1;
            };

            $scope.receipts_data_status = true;

            $scope.totalItems_receipts_data = $scope.receipts_data.length;
        })
        .then(null, function(data){
            $scope.receipts_data_status = false;
            cfpLoadingBar.complete();
        });
    }

    $scope.setPage_receipts_data = function (pageNo) {
        $scope.currentPage_receipts_data = pageNo;
    };

    $scope.pageChanged_receipts_data = function() {
        console.log('Page changed to: ' + $scope.currentPage_receipts_data);
    };

    $scope.setItemsPerPage_receipts_data = function(num) {
        $scope.itemsPerPage_receipts_data = num;
        $scope.currentPage_receipts_data = 1; 
    }

    $scope.get_best_selling = function(form){
        cfpLoadingBar.start();
        $scope.form.sales_from = '';
        $scope.form.sales_to = '';

        if (form.daily == true) {
            form.weekly = false;
            form.monthly = false;
            var today = new Date();
            $scope.form.sales_from_daily = new Date();
            $scope.form.sales_to_daily = new Date();
            $scope.form.sales_from = $scope.form.sales_from_daily;
            $scope.form.sales_to = $scope.form.sales_to_daily;
        }


        if (form.weekly == true) {
            form.daily = false;
            form.monthly = false;
            var today = new Date();
            $scope.form.sales_from_weekly = new Date(today.getFullYear(), today.getMonth(), today.getDate() - today.getDay()+0);
            $scope.form.sales_to_weekly = new Date(today.getFullYear(), today.getMonth(), today.getDate() - today.getDay()+6);
            $scope.form.sales_from = $scope.form.sales_from_weekly;
            $scope.form.sales_to = $scope.form.sales_to_weekly;
        }


        if (form.monthly == true) {
            form.daily = false;
            form.weekly = false;
            var today = new Date();
            var date = new Date(), y = date.getFullYear(), m = date.getMonth();
            $scope.form.sales_from_monthly = new Date(y, m, 1);
            $scope.form.sales_to_monthly = new Date(y, m + 1, 0);
            $scope.form.sales_from = $scope.form.sales_from_monthly;
            $scope.form.sales_to = $scope.form.sales_to_monthly;
        }


        var filter = {
            date_from : $filter('date')($scope.form.sales_from, "yyyy-MM-dd"),
            date_to : $filter('date')($scope.form.sales_to, "yyyy-MM-dd")
        };

        var promise = ProductFactory.get_best_selling(filter);
        promise.then(function(data){
            $scope.bestselling_data = data.data.result;


            var a = 0;
            for (var i in $scope.bestselling_data) {
                $scope.bestselling_data[i].date_created = new Date($scope.bestselling_data[i].date_created);
                $scope.bestselling_data[i].date_created = moment($scope.bestselling_data[i].date_created).format('LLLL');
                $scope.bestselling_data[i].number = a += 1;
            };

            $scope.bestselling_status = true;

            $scope.totalItems_bestselling = $scope.bestselling_data.length;
        })
        .then(null, function(data){
            $scope.bestselling_status = false;
            cfpLoadingBar.complete();
        });
    }

    $scope.setPage_bestselling = function (pageNo) {
        $scope.currentPage_bestselling = pageNo;
    };

    $scope.pageChanged_bestselling = function() {
        console.log('Page changed to: ' + $scope.currentPage_bestselling);
    };

    $scope.setItemsPerPage_bestselling = function(num) {
        $scope.itemsPerPage_bestselling = num;
        $scope.currentPage_bestselling = 1; 
    }

    $scope.refresh = function(){
        $route.reload();
    }

    function get_reports(){
        cfpLoadingBar.start();
        var filter = {
            name : 'All',
            date_from : undefined,
            date_to : undefined
        }; 

        var promise = ProductFactory.get_reports(filter);
        promise.then(function(data){
            $scope.tender_data = data.data.result;

            var a = 0;
            for (var i in $scope.tender_data) {
                $scope.tender_data[i].date_created = new Date($scope.tender_data[i].date_created);
                $scope.tender_data[i].date_created = moment($scope.tender_data[i].date_created).format('LLLL');
                $scope.tender_data[i].number = a += 1;
            };

            var b = 0;
            var c = 0;
            var p = 0;
            var k = 0;

            for (var i in $scope.tender_data) {
                if ($scope.tender_data[i].exchange_remarks == "t") {
                    $scope.tender_data[i].tempo_total = $scope.tender_data[i].total;
                    $scope.final_total_ito += parseFloat($scope.tender_data[i].tempo_total);
                }else{
                    c = $scope.tender_data[i].product_quantity;
                    p = $scope.tender_data[i].product_retail_price;
                    k = parseFloat(c) * parseFloat(p);
                    $scope.tender_data[i].tempo_total = k;
                    $scope.final_total_ito += k;
                }
            };

            for (var i in $scope.tender_data) {
                if ($scope.tender_data[i].product_supplier_price == "undefined" || $scope.tender_data[i].product_supplier_price == "" || $scope.tender_data[i].product_supplier_price == "NaN" || $scope.tender_data[i].product_supplier_price == undefined || $scope.tender_data[i].product_supplier_price == NaN || $scope.tender_data[i].product_supplier_price == "null" || $scope.tender_data[i].product_supplier_price == null) {
                    $scope.tender_data[i].product_supplier_price = 0;
                };
            };

            for (var i in $scope.tender_data) {
                if ($scope.tender_data[i].cashier_user_id == "N/A") {
                    $scope.tender_data[i].first_name = 'N/A';
                    $scope.tender_data[i].last_name = 'N/A';
                };
            };
            $scope.tender_data_status = true;

            $scope.totalItems_reportdata = $scope.tender_data.length;

        })
        .then(null, function(data){
            $scope.tender_data_status = false;
            cfpLoadingBar.complete();

        });
    }

    $scope.setPage_reportdata = function (pageNo) {
        $scope.currentPage_reportdata = pageNo;
    };

    $scope.pageChanged_reportdata = function() {
        console.log('Page changed to: ' + $scope.currentPage_reportdata);
    };

    $scope.setItemsPerPage_reportdata = function(num) {
        $scope.itemsPerPage_reportdata = num;
        $scope.currentPage_reportdata = 1; 
    }

    $scope.print_csvs = function(){
        window.open('./FUNCTIONS/Uploads/performance_csv.php?user_id=' + filtered.name +'&date_from='+filtered.date_from+'&date_to='+filtered.date_to+'&total=' + $scope.form.final_totaal
            );
    }

    $scope.print_best_sell_pdf = function(){
        var date_from_pdf = $filter('date')($scope.form.sales_from, "yyyy-MM-dd");
        var date_to_pdf = $filter('date')($scope.form.sales_to, "yyyy-MM-dd");
        window.open('./FUNCTIONS/Uploads/print_best_sell_pdf.php?date_from='+date_from_pdf+'&date_to='+date_to_pdf
            );
    }

    $scope.print_best_sell_csv = function(){
        var date_from_pdf = $filter('date')($scope.form.sales_from, "yyyy-MM-dd");
        var date_to_pdf = $filter('date')($scope.form.sales_to, "yyyy-MM-dd");
        window.open('./FUNCTIONS/Uploads/print_best_sell_csv.php?date_from='+date_from_pdf+'&date_to='+date_to_pdf
            );
    }

    $scope.get_reports = function(form){

        cfpLoadingBar.start();
        $scope.form.sales_from = '';
        $scope.form.sales_to = '';

        if (form.defaults == true && form.defaults2 == true) {
            form.daily = false;
            form.monthly = false;
            form.weekly = false;
            var today = new Date();
            $scope.form.defaults = $scope.form.date1._d;
            $scope.form.defaults2 = $scope.form.date2._d;
            $scope.form.sales_from = $scope.form.defaults;
            $scope.form.sales_to = $scope.form.defaults2;
        }

        if (form.daily == true) {
            form.weekly = false;
            form.monthly = false;
            form.defaults = false;
            form.defaults2 = false;
            $scope.header_title = 'Daily Sales Report';
            $scope.clicker_status = true;
            var today = new Date();
            $scope.form.sales_from_daily = new Date();
            $scope.form.sales_to_daily = new Date();
            $scope.form.sales_from = $scope.form.sales_from_daily;
            $scope.form.sales_to = $scope.form.sales_to_daily;
        }

        if (form.weekly == true) {
            form.daily = false;
            form.monthly = false;
            form.defaults = false;
            form.defaults2 = false;
            $scope.header_title = 'Weekly Sales Report';
            $scope.clicker_status = true;
            var today = new Date();
            $scope.form.sales_from_weekly = new Date(today.getFullYear(), today.getMonth(), today.getDate() - today.getDay()+0);
            $scope.form.sales_to_weekly = new Date(today.getFullYear(), today.getMonth(), today.getDate() - today.getDay()+6);
            $scope.form.sales_from = $scope.form.sales_from_weekly;
            $scope.form.sales_to = $scope.form.sales_to_weekly;
        }

        if (form.monthly == true) {
            form.daily = false;
            form.weekly = false;
            form.defaults = false;
            form.defaults2 = false;
            $scope.header_title = 'Monthly Sales Report';
            $scope.clicker_status = true;
            var today = new Date();
            var date = new Date(), y = date.getFullYear(), m = date.getMonth();
            $scope.form.sales_from_monthly = new Date(y, m, 1);
            $scope.form.sales_to_monthly = new Date(y, m + 1, 0);
            $scope.form.sales_from = $scope.form.sales_from_monthly;
            $scope.form.sales_to = $scope.form.sales_to_monthly;
        }

        filtered = {
            name : $scope.form.cashier_name,
            date_from : $filter('date')($scope.form.sales_from, "yyyy-MM-dd"),
            date_to : $filter('date')($scope.form.sales_to, "yyyy-MM-dd")
        }; 

        $scope.search_filter = filtered;

        var promise = ProductFactory.get_reports(filtered);
        promise.then(function(data){
            $scope.tender_data = data.data.result;


            var a = 0;
            for (var i in $scope.tender_data) {
                $scope.tender_data[i].date_created = new Date($scope.tender_data[i].date_created);
                $scope.tender_data[i].date_created = $filter('date')($scope.tender_data[i].date_created, "medium");
                $scope.tender_data[i].number = a += 1;
            };

            var b = 0;
            var c = 0;
            var p = 0;
            var k = 0;
            $scope.final_total_ito = 0;
            for (var i in $scope.tender_data) {
                c = $scope.tender_data[i].product_quantity;
                p = $scope.tender_data[i].product_retail_price;
                k = parseFloat(c) * parseFloat(p);
                $scope.tender_data[i].tempo_total = k;
                $scope.final_total_ito += k;
            };


            for (var i in $scope.tender_data) {
                if ($scope.tender_data[i].product_supplier_price == "undefined" || $scope.tender_data[i].product_supplier_price == "" || $scope.tender_data[i].product_supplier_price == "NaN" || $scope.tender_data[i].product_supplier_price == undefined || $scope.tender_data[i].product_supplier_price == NaN || $scope.tender_data[i].product_supplier_price == "null" || $scope.tender_data[i].product_supplier_price == null) {
                    $scope.tender_data[i].product_supplier_price = 0;
                };
            };

            for (var i in $scope.tender_data) {
                if ($scope.tender_data[i].cashier_user_id == "N/A") {
                    $scope.tender_data[i].first_name = 'N/A';
                    $scope.tender_data[i].last_name = 'N/A';
                };
            };

            $scope.form.totaaal = 0;

            for (var k in $scope.tender_data) {
                $scope.form.totaaal += parseFloat($scope.tender_data[k].tempo_total);
                
            };
            $scope.form.final_totaal = $scope.final_total_ito.toFixed(2);
            $scope.tender_data_status = true;
            $scope.totalItems_reportdata = $scope.tender_data.length;
        })
        .then(null, function(data){
            $scope.tender_data_status = false;
            $scope.final_total_ito = 0;
            cfpLoadingBar.complete();
        });
    }

    $scope.setPage_reportdata = function (pageNo) {
        $scope.currentPage_reportdata = pageNo;
    };

    $scope.pageChanged_reportdata = function() {
        console.log('Page changed to: ' + $scope.currentPage_reportdata);
    };

    $scope.setItemsPerPage_reportdata = function(num) {
        $scope.itemsPerPage_reportdata = num;
        $scope.currentPage_reportdata = 1; 
    }



    $scope.edit_product_data = function(v){
        cfpLoadingBar.start();
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
            product_supplier : $scope.product_data[index].product_supplier
        };

        ngDialog.openConfirm({
            template: 'EditMyProfile',
            className: 'ngdialog-theme-plain dialogwidth400',
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


            $scope.modal.new_product_date_expiration = $filter('date')($scope.modal.product_expiration._d, "medium");

            var datas = {
                pk : $scope.product_data[index].pk,
                product_name : $scope.modal.product_name,
                product_bar_code : $scope.modal.product_bar_code,
                product_stocks : $scope.modal.product_stocks,
                product_price : $scope.modal.product_price,
                product_srp : $scope.modal.product_srp,
                product_expiration : $scope.modal.new_product_date_expiration,
                supplier_code_name : $scope.modal.supplier_code_name,
                product_supplier : $scope.modal.product_supplier
            }

            var promise = ProductFactory.edit_product_data(datas);
            promise.then(function(data){
                var notify = $.notify('You have succesfully added the product', { 'type': 'success', allow_dismiss: true });
                get_product_data();
                cfpLoadingBar.complete();
            })
            .then(null, function(data){
                var notify = $.notify('Oops there something wrong!', { 'type': 'danger', allow_dismiss: true });
                cfpLoadingBar.complete();
            });
        });
    }

    $scope.ViewReceiptModal = function(v){
        var index = $scope.receipts_data.indexOf(v);
        $scope.toget_receipt(v);

        $scope.modal = {
            title : 'Receipt List',
            close : 'Close'
        };

        ngDialog.openConfirm({
            template: 'ViewReceiptModal',
            className: 'ngdialog-theme-plain dialogwidth28',
            scope: $scope,
            showClose: false
        })
        .then(function(value){
            return false;
        }, function(value){
        });
    }

    $scope.toget_receipt = function(v) {
        cfpLoadingBar.start();
        var filter = {
            transact_number : v.product_transaction_number
        };
        var promise = ProductFactory.get_receiptsback(filter);
        promise.then(function(data){
            $scope.receipts_data_back = data.data.result;

            var a = 0;
            for (var i in $scope.receipts_data_back) {
                $scope.receipts_data_back[i].date_created = new Date($scope.receipts_data_back[i].date_created);
                $scope.receipts_data_back[i].date_created = moment($scope.receipts_data_back[i].date_created).format('LLLL');
                $scope.receipts_data_back[i].number = a += 1;
                $scope.pr_name = $scope.receipts_data_back[i].product_retail_price;
            };
            $scope.form.totaaaal = 0;
            for (var k in $scope.receipts_data_back) {
                $scope.form.totaaaal += parseFloat($scope.receipts_data_back[k].tempo_total);
                $scope.form.final_totaaaal = $scope.form.totaaaal.toFixed(2);
            };

            $scope.receipts_data_back_status = true;
        })
        .then(null, function(data){
            $scope.receipts_data_back_status = false;
            cfpLoadingBar.complete();
        });
    }

    $scope.print_pdf = function(){
        window.open('./FUNCTIONS/Uploads/performance_pdf.php?user_id=' + filtered.name +'&date_from='+filtered.date_from+'&date_to='+filtered.date_to+'&total=' + $scope.form.final_totaal
            );
    }

    $scope.download_receipt = function(){
        var a = 0;
        $scope.form.count = 0;
        for (var i in $scope.receipts_data_back) {
            $scope.form.product_transaction_number = $scope.receipts_data_back[i].product_transaction_number;
            $scope.form.first_name = $scope.receipts_data_back[i].first_name;
            $scope.form.last_name = $scope.receipts_data_back[i].last_name;
            $scope.receipts_data_back[i].date_created = new Date($scope.receipts_data_back[i].date_created);
            $scope.form.date_time = $filter('date')($scope.receipts_data_back[i].date_created, "medium");
            $scope.form.count += parseInt($scope.receipts_data_back[i].product_quantity); 
        };

        for (var k in $scope.receipts_data_back) {
            if ($scope.receipts_data_back[k].gc_amount > 0) {
                $scope.form.r_name = 'Gift Certificate'
            }else{
                $scope.form.r_name = 'Cash'
            };

        };
        window.open('./FUNCTIONS/Uploads/receipt_backup.php?reports=' + JSON.stringify($scope.receipts_data_back) 
            + '&TI=' + $scope.form.product_transaction_number
            + '&date_time=' + $scope.form.date_time
            + '&user_id_fname=' + $scope.form.first_name
            + '&user_id_lname=' + $scope.form.last_name
            + '&count=' + $scope.form.count
            + '&r_name=' + $scope.form.r_name
            + '&pr_price=' + $scope.pr_name
            );
    }

    $scope.send_receipt = function(){
        cfpLoadingBar.start();

        $scope.modal = {
            title : 'Send Receipt Via E-mail',
            save : 'Send',
            close : 'Cancel'

        };

        ngDialog.openConfirm({
            template: 'SendReceiptModal',
            className: 'ngdialog-theme-plain dialogwidth28',
            scope: $scope,
            showClose: false
        })
        .then(function(value){
            return false;
        }, function(value){

            var a = 0;
            $scope.form.count = 0;
            for (var i in $scope.receipts_data_back) {
                $scope.form.product_transaction_number = $scope.receipts_data_back[i].product_transaction_number;
                $scope.form.first_name = $scope.receipts_data_back[i].first_name;
                $scope.form.last_name = $scope.receipts_data_back[i].last_name;
                $scope.receipts_data_back[i].date_created = new Date($scope.receipts_data_back[i].date_created);
                $scope.form.date_time = $filter('date')($scope.receipts_data_back[i].date_created, "medium");
                $scope.form.count += parseInt($scope.receipts_data_back[i].product_quantity); 
            };

            for (var k in $scope.receipts_data_back) {
                if ($scope.receipts_data_back[k].gc_amount > 0) {
                    $scope.form.r_name = 'Gift Certificate'
                }else{
                    $scope.form.r_name = 'Cash'
                };

            };

            $scope.submit_datas = {
                data : JSON.stringify($scope.receipts_data_back),
                message: '<p>Dear Customer,</p><div>&nbsp;</div><div>Attached is your official receipt. Thank you for shopping with us and see you very soon!</div><div>&nbsp;</div><div>For feedback and inquiries do not hesitate to email us via the email address written in the official receipt.</div><div>&nbsp;</div><div>Thank you!</div><div>&nbsp;</div><div>GoSari Team</div>',
                TI : $scope.form.product_transaction_number,
                user_id_fname : $scope.receipts_data_back[i].first_name,
                user_id_lname : $scope.receipts_data_back[i].last_name,
                date_time : $scope.form.date_time,
                net_amount : $scope.receipts_data_back[i].net_amount,
                count : $scope.form.count,
                vat : $scope.receipts_data_back[i].vat,
                change : $scope.receipts_data_back[i].change,
                total : $scope.receipts_data_back[i].total,
                discount : $scope.receipts_data_back[i].discount,
                cash : $scope.receipts_data_back[i].cash,
                email : $scope.modal.email,
                tempo_total : $scope.receipts_data_back[i].tempo_total,
                r_name : $scope.form.r_name,
            };

            var notify = $.notify('Please wait for the receipt to be send', { 'type': 'warning', allow_dismiss: true });
            var promise = ProductFactory.submit_toemailreceipt($scope.submit_datas);

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

    $scope.search_columns = function (sortValue = []) {
        cfpLoadingBar.start();
        var filter = {
            name : $scope.search_filter.name,
            date_from : $scope.search_filter.date_from,
            date_to : $scope.search_filter.date_to
        }
        $scope.search_value = "(";
        if ($scope.product_transaction_number != "") {
            $scope.search_value += "product_transaction_number ILIKE '" + $scope.product_transaction_number + "%'";
        }

        if ($scope.product_name != "") {
            if ($scope.search_value.length > 1) {
                $scope.search_value += "AND ";
            }
            $scope.search_value += "product_name ILIKE '%" + $scope.product_name + "%'";
        }

        if ($scope.full_name != "") {
            var full_name = $scope.full_name.split(" ");
            var cashier_name = "(";
            if ($scope.search_value.length > 1) {
                $scope.search_value += "AND ";
            }
            for (var i = 0; i < full_name.length; i++) {
                if (full_name[i] != "") {
                    if (cashier_name.length > 1) {
                        cashier_name += "OR ";
                    }
                    cashier_name += "(users.first_name ILIKE '%" + full_name[i] + "%'";
                    cashier_name += "OR users.last_name ILIKE '%" + full_name[i] + "%')";
                }
            }
            cashier_name += ")";
            $scope.search_value += cashier_name;
        }
        $scope.search_value += ")";

        if ($scope.search_value != "()") {
            filter.search_term = $scope.search_value;
        }

        if (sortValue.length > 0) {
            filter.sort = "ORDER BY " + sortValue[0] + " " + sortValue[1];
        }

        $scope.totalItems_reportdata = 0;
        $scope.final_total_ito = 0;
        var promise = ProductFactory.get_reports(filter);
        promise.then(function(data){
            $scope.tender_data = data.data.result;

            var a = 0;
            for (var i in $scope.tender_data) {
                $scope.tender_data[i].date_created = new Date($scope.tender_data[i].date_created);
                $scope.tender_data[i].date_created = moment($scope.tender_data[i].date_created).format('LLLL');
                $scope.tender_data[i].number = a += 1;
            };

            var b = 0;
            var c = 0;
            var p = 0;
            var k = 0;

            for (var i in $scope.tender_data) {
                if ($scope.tender_data[i].exchange_remarks == "t") {
                    $scope.tender_data[i].tempo_total = $scope.tender_data[i].total;
                    $scope.final_total_ito += parseFloat($scope.tender_data[i].tempo_total);
                }else{
                    c = $scope.tender_data[i].product_quantity;
                    p = $scope.tender_data[i].product_retail_price;
                    k = parseFloat(c) * parseFloat(p);
                    $scope.tender_data[i].tempo_total = k;
                    $scope.final_total_ito += k;
                }
            };

            for (var i in $scope.tender_data) {
                if ($scope.tender_data[i].product_supplier_price == "undefined" || $scope.tender_data[i].product_supplier_price == "" || $scope.tender_data[i].product_supplier_price == "NaN" || $scope.tender_data[i].product_supplier_price == undefined || $scope.tender_data[i].product_supplier_price == NaN || $scope.tender_data[i].product_supplier_price == "null" || $scope.tender_data[i].product_supplier_price == null) {
                    $scope.tender_data[i].product_supplier_price = 0;
                };
            };

            for (var i in $scope.tender_data) {
                if ($scope.tender_data[i].cashier_user_id == "N/A") {
                    $scope.tender_data[i].first_name = 'N/A';
                    $scope.tender_data[i].last_name = 'N/A';
                };
            };
            $scope.tender_data_status = true;

            $scope.totalItems_reportdata = $scope.tender_data.length;
        })
        .then(null, function(data){
            $scope.tender_data_status = false;
            cfpLoadingBar.complete();

        });
    };

    $scope.sortTable = function(field, index) {
        $scope.sortFieldIndex = index;

        if (this.current_sort_field != field) {
            this.current_sort_field = field;
            this.current_sort_direction = null;
        }

        if (this.current_sort_direction == 'ASC') {
            this.current_sort_direction = 'DESC';
            $scope.arrowSort = 0;
        } else if (this.current_sort_direction == 'DESC') {
            this.current_sort_direction = null;
            $scope.arrowSort = null;
            this.search_columns();
            return null;
        } else {
            this.current_sort_direction = 'ASC'
            $scope.arrowSort = 1;
        }

        this.search_columns([field, this.current_sort_direction]);
    }
});

