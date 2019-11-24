app.controller('Navbar', function(
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
    $scope.datass = {};
    $scope.filter = {};
    $scope.product_checker = {};
    $scope.tender_new = [];
    $scope.tender_voided = {};
    $scope.hehe = {};
    $scope.tender_voided.count = 0;
    $scope.history_data_status = {};
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

    $scope.cashier = {};

    $scope.viewby_productdata = 10;
    $scope.currentPage_productdata = 4;
    $scope.itemsPerPage_productdata = $scope.viewby_productdata;
    $scope.maxSize = 5;

    var filtered = {};
    var filters= {};
    var filter= {};

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
            $scope.user.permissions = JSON.parse($scope.user.permission);
            get_product_data_expire();

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


function get_product_data_expire(){
    cfpLoadingBar.start();
    var today = new Date();
    var filters = {
        wildcard : $scope.form.search,
        date_from : $filter('date')(new Date(today.getFullYear(), today.getMonth(), today.getDate() - today.getDay()+0),"yyyy-MM-dd"),
        date_to : $filter('date')(new Date(today.getFullYear(), today.getMonth(), today.getDate() - today.getDay()+6),"yyyy-MM-dd")
    };
    var promise = ProductFactory.get_product_data_expire(filters);
    promise.then(function(data){
        $scope.product_data_expire = data.data.result;
        $scope.product_data_expire_status = true;

        if ($scope.product_data_expire_status == true) {
                $scope.expire_modal();   
            }


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

        $scope.totalItems_productdata_expire = $scope.product_data_expire.length;

    })
.then(null, function(data){

    cfpLoadingBar.complete();
    $scope.product_data_expire_status = false;

});
}

$scope.expire_modal = function(){
    $scope.modal = {
        title : 'Product Expiration',
        save : 'Ok',
        close : 'Close'
    };

    ngDialog.openConfirm({
        template: 'ExpireModal',
        className: 'ngdialog-theme-plain dialogwidth600',
        scope: $scope,
        showClose: false
    })
    .then(function(value){
        return false;
    }, function(value){

        var promise = ProductFactory.edit_product_data_bc(datas);
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

$scope.logout = function(){
    var userData = $scope.user;
    var name = userData.first_name + ' ' + userData.last_name;
    var userType = userData.user_type == '1' ? 'ADMIN' : 'CASHIER';
    var action = userType + " LOGGED OUT";

    $.ajax('FUNCTIONS/Users/logout.php', {
        type: "POST",
        data: { name : name, action : action},
        success: function(data){
            var promise = SessionFactory.logout();
            promise.then(function(data){
                window.location = './login.html';
            });
        }
    });
}

    $scope.change_password = function(){
    /*console.log(v);*/

    $scope.modal = {
        title:'Change Password',
        save : 'Save',
        close : 'Close'

    };

    ngDialog.openConfirm({
        template: 'ChangePassword',
        className: 'ngdialog-theme-plain dialogwidth500',
        preCloseCallback: function(value) {
            var nestedConfirmDialog;
                    $scope.form.old_pass = md5.createHash($scope.modal.old_password);
                if ($scope.form.old_pass != $scope.user.password && ($scope.form.old_pass != $scope.user.temp_pass || $scope.user.is_temp_pass_valid != 1)) {
                    nestedConfirmDialog = ngDialog.openConfirm({
                        template:
                                '<p> Oops! you input a wrong old password </p>' +
                                '<div class="ngdialog-buttons">' +
                                    '<button type="button" class="ngdialog-button ngdialog-button-primary" data-ng-click="confirm(1)">Ok' +
                                '</button></div>',
                        plain: true,
                        className: 'ngdialog-theme-plain'
                    });
                    return false;
                }else if ($scope.modal.password1 != $scope.modal.password2) { 
                    nestedConfirmDialog = ngDialog.openConfirm({
                template:
                    '<p>Oops your new password did not match! </p>' +
                    '<div class="ngdialog-buttons">' +
                    '<button type="button" class="ngdialog-button ngdialog-button-primary" data-ng-click="confirm(1)">Ok' +
                                '</button></div>',
                    plain: true,
                    className: 'ngdialog-theme-plain custom-width'
                    });
                    return false;
                }else if ($scope.modal.password1 == null ||  $scope.modal.password2 == null || $scope.modal.password1 == '' ||  $scope.modal.password2 == '' || $scope.modal.password1 == undefined ||  $scope.modal.password2 == undefined) { 
                    nestedConfirmDialog = ngDialog.openConfirm({
                template:
                    '<p>Oops you did not input any new password </p>' +
                    '<div class="ngdialog-buttons">' +
                    '<button type="button" class="ngdialog-button ngdialog-button-primary" data-ng-click="confirm(1)">Ok' +
                                '</button></div>',
                    plain: true,
                    className: 'ngdialog-theme-plain custom-width'
                    });
                    return false;
                }else{
                    nestedConfirmDialog = ngDialog.openConfirm({
                template:
                    '<p>Are you sure you want to update your password?</p>' +
                    '<div class="ngdialog-buttons">' +
                    '<button type="button" class="ngdialog-button ngdialog-button-secondary" data-ng-click="closeThisDialog(0)">No' +
                    '<button type="button" class="ngdialog-button style="background-color: #ffbf00;" ngdialog-button-primary" data-ng-click="confirm(1)">Yes' +
                    '</button></div>',
                    plain: true,
                    className: 'ngdialog-theme-plain custom-width'
                    });
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
        var pass = md5.createHash($scope.modal.password1);
        $scope.pass = pass;

        var data = {
            pk: $scope.user.pk,
            user_id: $scope.user.user_id,
            new_password: $scope.pass
        };

        var promise = UserFactory.update_my_password(data);
        promise.then(function(data){

            var notify = $.notify('You have succesfully updated your password', { 'type': 'success', allow_dismiss: true });
            get_user();
            cfpLoadingBar.complete();
        })
        .then(null, function(data){
            var notify = $.notify('Oops there something wrong!', { 'type': 'danger', allow_dismiss: true });
            cfpLoadingBar.complete();
        });
    });
}


});

