app.controller('AddCustomer', function( 
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
    $scope.customer_data = [];
    $scope.customer_data_status = false;
    $scope.currentPage_customerdata = 1;
    $scope.totalItems_customerdata = 0;

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
            get_customers();

        })
        .then(null, function(data){
            var promise = SessionFactory.logout();
            promise.then(function(data){
                window.location = './login.html';
            });
        });
    }

    function get_customers(){
        var promise = ProductFactory.get_customers();
        promise.then(function(data){
            $scope.customer_data = data.data.result;
            var a = 0;
            for (var i in $scope.customer_data) {
                $scope.customer_data[i].date_created = new Date($scope.customer_data[i].date_created);
                $scope.customer_data[i].date_created = moment($scope.customer_data[i].date_created).format('LLLL');
                $scope.customer_data[i].number = a += 1;
            };

            $scope.customer_data_status = true;
            $scope.totalItems_customerdata = $scope.customer_data.length;

        })
        .then(null, function(data){
            $scope.customer_data_status = false;
            cfpLoadingBar.complete();

        });
    }

    function reset_modal(){
        $scope.modal = {
            client_name: null,
            address: null,
            city: null,
            email: null,
            contact_number: null,
            tin_number : null
        }

        return;
    }

    $scope.add_customer = function() {
        $scope.modal = {
            title : 'Enter New Customer Details',
            save : 'Save',
            close : 'Cancel',
        }

        ngDialog.openConfirm({
            template: 'EditUser',
            className: 'ngdialog-theme-plain dialogwidth500',
            preCloseCallback: function(value) {
                var nestedConfirmDialog;
                if ($scope.modal.client_name == '' || $scope.modal.client_name == "" || $scope.modal.client_name == NaN || $scope.modal.client_name == null || $scope.modal.client_name == undefined || $scope.modal.client_name == 'NaN') {
                    var notify = $.notify('Customer Name is required!', {'type': 'danger' ,  allow_dismiss: true });
                    cfpLoadingBar.complete();
                    return false;
                }
                if ($scope.modal.address == '' || $scope.modal.address == "" || $scope.modal.address == NaN || $scope.modal.address == null || $scope.modal.address == undefined || $scope.modal.address == 'NaN') {
                    var notify = $.notify('Street Address is required', {'type': 'danger' ,  allow_dismiss: true });
                    cfpLoadingBar.complete();
                    return false;
                }
                if ($scope.modal.city == '' || $scope.modal.city == "" || $scope.modal.city == NaN || $scope.modal.city == null || $scope.modal.city == undefined || $scope.modal.city == 'NaN') {
                    var notify = $.notify('City Address is required!', {'type': 'danger' ,  allow_dismiss: true });
                    cfpLoadingBar.complete();
                    return false;
                }
                if ($scope.modal.email == '' || $scope.modal.email == "" || $scope.modal.email == NaN || $scope.modal.email == null || $scope.modal.email == undefined || $scope.modal.email == 'NaN') {
                    alert($scope.modal.email);
                    var notify = $.notify('Email is required!', {'type': 'danger' ,  allow_dismiss: true });
                    cfpLoadingBar.complete();
                    return false;
                }
                var regexEmail = /\S+@\S+\.\S+/;
                if (!regexEmail.test($scope.modal.email)) {
                    var notify = $.notify('Invalid Email!', {'type': 'danger' ,  allow_dismiss: true });
                    cfpLoadingBar.complete();
                    return false;
                }

                if ($scope.modal.contact_number == '' || $scope.modal.contact_number == "" || $scope.modal.contact_number == NaN || $scope.modal.contact_number == null || $scope.modal.contact_number == undefined || $scope.modal.contact_number == 'NaN') {
                    var notify = $.notify('Contact Number is required!', {'type': 'danger' ,  allow_dismiss: true });
                    cfpLoadingBar.complete();
                    return false;
                }
                if ($scope.modal.tin_number == '' || $scope.modal.tin_number == "" || $scope.modal.tin_number == NaN || $scope.modal.tin_number == null || $scope.modal.tin_number == undefined || $scope.modal.tin_number == 'NaN') {
                    var notify = $.notify('Tin Number is required!', {'type': 'danger' ,  allow_dismiss: true });
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
            var promise = ProductFactory.add_customer($scope.modal);
            promise.then(function(data){
                var notify = $.notify('You have succesfully added a new customer', { 'type': 'success', allow_dismiss: true });
                get_customers();
                cfpLoadingBar.complete();
                reset_modal();
                return true;
            })
            .then(null, function(data){
                var notify = $.notify('Oops something went wrong!', { 'type': 'danger', allow_dismiss: true });
                cfpLoadingBar.complete();
                return false;
            });
        });
    };

    $scope.edit_customer = function(v){
        var index = $scope.customer_data.indexOf(v);

        $scope.modal = {
            title : 'Update Customer',
            save : 'Update',
            close : 'Cancel',
            client_name: $scope.customer_data[index].client_name,
            address: $scope.customer_data[index].street,
            city: $scope.customer_data[index].city,
            email: $scope.customer_data[index].email,
            contact_number: $scope.customer_data[index].contact_number,
            tin_number : $scope.customer_data[index].tin,
            pk : $scope.customer_data[index].pk
        }     

        ngDialog.openConfirm({
            template: 'EditUser',
            className: 'ngdialog-theme-plain dialogwidth500',
            preCloseCallback: function(value) {
                var nestedConfirmDialog;
                if ($scope.modal.client_name == '' || $scope.modal.client_name == "" || $scope.modal.client_name == NaN || $scope.modal.client_name == null || $scope.modal.client_name == undefined || $scope.modal.client_name == 'NaN') {
                    var notify = $.notify('Customer Name is required!', {'type': 'danger' ,  allow_dismiss: true });
                    cfpLoadingBar.complete();
                    return false;
                }
                if ($scope.modal.address == '' || $scope.modal.address == "" || $scope.modal.address == NaN || $scope.modal.address == null || $scope.modal.address == undefined || $scope.modal.address == 'NaN') {
                    var notify = $.notify('Street Address is required', {'type': 'danger' ,  allow_dismiss: true });
                    cfpLoadingBar.complete();
                    return false;
                }
                if ($scope.modal.city == '' || $scope.modal.city == "" || $scope.modal.city == NaN || $scope.modal.city == null || $scope.modal.city == undefined || $scope.modal.city == 'NaN') {
                    var notify = $.notify('City Address is required!', {'type': 'danger' ,  allow_dismiss: true });
                    cfpLoadingBar.complete();
                    return false;
                }
                if ($scope.modal.email == '' || $scope.modal.email == "" || $scope.modal.email == NaN || $scope.modal.email == null || $scope.modal.email == undefined || $scope.modal.email == 'NaN') {
                    alert($scope.modal.email);
                    var notify = $.notify('Email is required!', {'type': 'danger' ,  allow_dismiss: true });
                    cfpLoadingBar.complete();
                    return false;
                }
                var regexEmail = /\S+@\S+\.\S+/;
                if (!regexEmail.test($scope.modal.email)) {
                    var notify = $.notify('Invalid Email!', {'type': 'danger' ,  allow_dismiss: true });
                    cfpLoadingBar.complete();
                    return false;
                }

                if ($scope.modal.contact_number == '' || $scope.modal.contact_number == "" || $scope.modal.contact_number == NaN || $scope.modal.contact_number == null || $scope.modal.contact_number == undefined || $scope.modal.contact_number == 'NaN') {
                    var notify = $.notify('Contact Number is required!', {'type': 'danger' ,  allow_dismiss: true });
                    cfpLoadingBar.complete();
                    return false;
                }
                if ($scope.modal.tin_number == '' || $scope.modal.tin_number == "" || $scope.modal.tin_number == NaN || $scope.modal.tin_number == null || $scope.modal.tin_number == undefined || $scope.modal.tin_number == 'NaN') {
                    var notify = $.notify('Tin Number is required!', {'type': 'danger' ,  allow_dismiss: true });
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
            var promise = ProductFactory.edit_customer($scope.modal);
            promise.then(function(data){
                var notify = $.notify('You have succesfully edited the customer', { 'type': 'success', allow_dismiss: true });
                get_customers();
                cfpLoadingBar.complete();
                reset_modal();
                return true;
            })
            .then(null, function(data){
                var notify = $.notify('Oops something went wrong!', { 'type': 'danger', allow_dismiss: true });
                cfpLoadingBar.complete();
                return false;
            });
        });
    };

    $scope.delete_customer = function(v){
        var index = $scope.customer_data.indexOf(v);
        
        $scope.modal = {
            title : 'Are you sure you want to delete this customer?',
            save : 'Delete',
            close : 'Cancel',
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
            $scope.modal.pk = $scope.customer_data[index].pk;
            var promise = ProductFactory.delete_customer($scope.modal);
            promise.then(function(data){
                var notify = $.notify('You have succesfully deleted the customer details', { 'type': 'success', allow_dismiss: true });
                get_customers();
                cfpLoadingBar.complete();
                return true;
            })
            .then(null, function(data){
                var notify = $.notify('Oops something went wrong!', { 'type': 'danger', allow_dismiss: true });
                cfpLoadingBar.complete();
                return false;
            });
        });
    };

    $scope.uppercaseWords = function(field) {
        var value = $scope.modal[field];
        var valueArray = [];
        valueArray = value.split(' ');

        for (var i = 0; i < valueArray.length; i++) {
            valueArray[i] = valueArray[i].charAt(0).toUpperCase() + valueArray[i].substring(1);
        }

        value = valueArray.join(' ');

        $scope.modal[field] = value;
    };
});

