app.controller('Discount', function(
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
    $scope.modal = {};
    $scope.aomos_discount_data_status = false;
    $scope.form = {};
    $scope.pk = null;

    $scope.viewby_aomos_discount_data = 10;
    $scope.currentPage_aomos_discount_data = 4;
    $scope.itemsPerPage_aomos_discount_data = $scope.viewby_aomos_discount_data;
    $scope.maxSize = 5;

    init();

    function init(){
        cfpLoadingBar.start();
        var promise = SessionFactory.getsession();
        promise.then(function(data){
            var _id = md5.createHash('pk');
            $scope.pk = data.data[_id];
            get_user();
            DEFAULTDATES();
            cfpLoadingBar.complete();
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
            get_aomos_discount_list();

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

    function get_aomos_discount_list(){

        var promise = ProductFactory.get_aomos_discount_list();
        promise.then(function(data){
            $scope.aomos_discount_data = data.data.result;

            $scope.aomos_discount_data_status = true;

            var a = 0;
            for (var i in $scope.aomos_discount_data) {
                $scope.aomos_discount_data[i].date_created = new Date($scope.aomos_discount_data[i].date_created);
                $scope.aomos_discount_data[i].number = a += 1;
            };

            /*$scope.totalItems_aomos_discount_data = $scope.aomos_discount_data.length;*/
        })
        .then(null, function(data){
            $scope.aomos_discount_data_status = false;

        });
    }

    $scope.setPage_aomos_discount_data = function (pageNo) {
        $scope.currentPage_aomos_discount_data = pageNo;
    };

    $scope.pageChanged_aomos_discount_data = function() {
        console.log('Page changed to: ' + $scope.currentPage_aomos_discount_data);
    };

    $scope.setItemsPerPage_aomos_discount_data = function(num) {
        $scope.itemsPerPage_aomos_discount_data = num;
        $scope.currentPage_aomos_discount_data = 1;
    }

    $scope.get_aomos_payment_filter = function(){

        filter = {
            date_from : $filter('date')($scope.form.date1._d, "yyyy-MM-dd"),
            date_to : $filter('date')($scope.form.date2._d, "yyyy-MM-dd")
        }
        var promise = ProductFactory.get_aomos_payment_filter(filter);
        promise.then(function(data){
            $scope.aomos_discount_data = data.data.result;
            $scope.aomos_discount_data_status = true;

            var a = 0;
            for (var i in $scope.aomos_discount_data) {
                $scope.aomos_discount_data[i].date_created = new Date($scope.aomos_discount_data[i].date_created);
                $scope.aomos_discount_data[i].number = a += 1;
            };

        })
        .then(null, function(data){
            $scope.aomos_discount_data_status = false;
        });
    }
    $scope.setPage_aomos_discount_data = function (pageNo) {
        $scope.currentPage_aomos_discount_data = pageNo;
    };

    $scope.pageChanged_aomos_discount_data = function() {
        console.log('Page changed to: ' + $scope.currentPage_aomos_discount_data);
    };

    $scope.setItemsPerPage_aomos_discount_data = function(num) {
        $scope.itemsPerPage_aomos_discount_data = num;
        $scope.currentPage_aomos_discount_data = 1;
    }

    $scope.ViewReceiptModal = function(v){
        var index = $scope.aomos_discount_data.indexOf(v);
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
            transact_number : v.transaction_number
        };
        var promise = ProductFactory.get_receiptsback(filter);
        promise.then(function(data){
            $scope.receipts_data_back = data.data.result;

            var a = 0;
            for (var i in $scope.receipts_data_back) {
                $scope.receipts_data_back[i].date_created = new Date($scope.receipts_data_back[i].date_created);
                $scope.receipts_data_back[i].date_created = $filter('date')($scope.receipts_data_back[i].date_created, "medium");
                $scope.receipts_data_back[i].number = a += 1;
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



});

