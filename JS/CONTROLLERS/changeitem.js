app.controller('Changeitem', function(
                                            $scope,
                                            SessionFactory,
                                            UserFactory,
                                            ProductFactory,
                                            md5,
                                            $filter,
                                            ngDialog,
                                            $route,
                                            FileUploader,
                                            cfpLoadingBar
                                            ) 
                                        {

    $scope.user = {};

    $scope.uploader = {};
    $scope.uploader.queue = {};

    $scope.uploaded_picture = {};

      $scope.viewby = 4;
      $scope.currentPage = 4;
      $scope.itemsPerPage = $scope.viewby;
      $scope.maxSize = 2;

    init();

    function init(){
        var promise = SessionFactory.getsession();
        promise.then(function(data){
            var _id = md5.createHash('pk');
            $scope.pk = data.data[_id];
            get_user();
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
            get_product_data();
        })
        .then(null, function(data){
            var promise = SessionFactory.logout();
            promise.then(function(data){
                window.location = './login.html';
            });
        });
    }

    $scope.search = function(){
    if ($scope.form.search == "") {
        get_product_data();
    }
    console.log($scope.form.search);
    
    if ($scope.form.search_branch == 'All') {
        $scope.form.search_branches = undefined;
    }else{
        $scope.form.search_branches = $scope.form.search_branch;
    };

    filters = {
        wildcard : $scope.form.search,
        wildcard4 : $scope.form.search_branches,
        wildcard2 : undefined,
        wildcard3 : undefined
    };



    var promise = ProductFactory.get_product_data_search(filters);
    promise.then(function(data){
        $scope.product_data = data.data.result;
        $scope.branch_status = true;


        var a = 0;
        for (var i in $scope.product_data) {
            $scope.product_data[i].product_expiration = new Date($scope.product_data[i].product_expiration);
            $scope.product_data[i].product_expiration = $filter('date')($scope.product_data[i].product_expiration, "mediumDate");
            $scope.product_data[i].date_created = new Date($scope.product_data[i].date_created);
            $scope.product_data[i].number = a += 1;
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
            if ($scope.product_data[i].product_image == 'undefined' || $scope.product_data[i].product_image == undefined || $scope.product_data[i].product_image == null) {
                $scope.product_data[i].product_image_status = false;
            }else{
                $scope.product_data[i].product_image_status = true;
            }
        }

        $scope.totalItems_productdata = $scope.product_data.length;
    })
    .then(null, function(data){
        $scope.branch_status = false;
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
    var promise = ProductFactory.get_product_data();
    promise.then(function(data){
        $scope.product_data = data.data.result;
        $scope.branch_status = true;
        


        var a = 0;
        for (var i in $scope.product_data) {
            $scope.product_data[i].product_expiration = new Date($scope.product_data[i].product_expiration);
            $scope.product_data[i].product_expiration = $filter('date')($scope.product_data[i].product_expiration, "mediumDate");
            $scope.product_data[i].date_created = new Date($scope.product_data[i].date_created);
            $scope.product_data[i].number = a += 1;
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

        for (var h in $scope.product_data) {
            $scope.view.image = $scope.product_data[h].product_image;

        };

        for(var i in $scope.product_data){
            if ($scope.product_data[i].product_image == 'undefined' || $scope.product_data[i].product_image == undefined || $scope.product_data[i].product_image == null) {
                $scope.product_data[i].product_image_status = false;
            }else{
                $scope.product_data[i].product_image_status = true;
            }
        }

        $scope.totalItems_productdata = $scope.product_data.length;
    })
    .then(null, function(data){
        $scope.branch_status = false;
        cfpLoadingBar.complete();
    });
}

$scope.change_item = function(v){

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
            product_kinds : $scope.modal.product_kinds
        }


        var promise = ProductFactory.change_item(datas);
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



});

