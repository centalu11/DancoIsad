app.controller('Custpayment', function(
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
    $scope.form = {};
    $scope.uploader = {};
    $scope.uploader.queue = {};
    $scope.ProductName ={};
    $scope.uploaded_picture = {};
    $scope.customer_payment_data_status = false;

    $scope.viewby_customer_data = 4;
    $scope.currentPage_customer_data = 4;
    $scope.itemsPerPage_customer_data = $scope.viewby_customer_data;
    $scope.maxSize = 2;

    $scope.viewby_payment_data = 5;
    $scope.currentPage_payment_data = 5;
    $scope.itemsPerPage_payment_data = $scope.viewby_payment_data;
    $scope.maxSize = 5;



    $scope.vm = {};
    $scope.vm.options = {format: 'YYYY/MM/DD HH:mm', showClear: true};
    var filter = {};
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
            get_customer_payment();
            get_payment_data();
            DEFAULTDATES();
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


        $scope.form.date1 = new Date();
        $scope.form.date2 = new Date();
        $scope.form.date3 = new Date();
        $scope.form.date4 = new Date();
    /*$scope.datass.product_expiration = today;
    $scope.filter.date3 = getMonday(new Date());
    $scope.filter.date4 = today;
    $scope.filter.po1 = getMonday(new Date());
    $scope.filter.po2 = today;*/
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

function get_customer_payment(){

    var promise = ProductFactory.get_customer_payment();
    promise.then(function(data){
        $scope.customer_payment_data = data.data.result;

        var a = 0;
        for (var i in $scope.customer_payment_data) {
            $scope.customer_payment_data[i].date_created = new Date($scope.customer_payment_data[i].date_created);
            $scope.customer_payment_data[i].number = a += 1;
        };

        for (var k in $scope.customer_payment_data) {
            $scope.customer_payment_data[k].result = parseInt($scope.customer_payment_data[k].total) - parseInt($scope.customer_payment_data[k].down_payment_amount);
        };

        for (var z in $scope.customer_payment_data) {

            if ($scope.customer_payment_data[z].result != 0) {
                $scope.customer_payment_data[z].show_me = true;
            }else{
                $scope.customer_payment_data[z].show_me = false;
            };

        };

    })
    .then(null, function(data){

    });
}
$scope.setPage_customer_data = function (pageNo) {
    $scope.currentPage_customer_data = pageNo;
};

$scope.pageChanged_customer_data = function() {
    console.log('Page changed to: ' + $scope.currentPage_customer_data);
};

$scope.setItemsPerPage_customer_data = function(num) {
    $scope.itemsPerPage_customer_data = num;
$scope.currentPage_customer_data = 1; //reset to first paghe
}

$scope.get_customer_payment_filter = function(){

 filter = {
    date_from : $filter('date')($scope.form.date3._d, "yyyy-MM-dd"),
    date_to : $filter('date')($scope.form.date4._d, "yyyy-MM-dd")
}
var promise = ProductFactory.get_customer_payment_filter(filter);
promise.then(function(data){
    $scope.customer_payment_data = data.data.result;
    $scope.customer_payment_data_status = true;

    var a = 0;
    for (var i in $scope.customer_payment_data) {
        $scope.customer_payment_data[i].date_created = new Date($scope.customer_payment_data[i].date_created);
        $scope.customer_payment_data[i].number = a += 1;
    };

    for (var k in $scope.customer_payment_data) {
        $scope.customer_payment_data[k].result = parseInt($scope.customer_payment_data[k].total) - parseInt($scope.customer_payment_data[k].down_payment_amount);
    };

    for (var z in $scope.customer_payment_data) {

        if ($scope.customer_payment_data[z].result != 0) {
            $scope.customer_payment_data[z].show_me = true;
        }else{
            $scope.customer_payment_data[z].show_me = false;
        };

    };

})
.then(null, function(data){
$scope.customer_payment_data_status = false;
});
}
$scope.setPage_customer_data = function (pageNo) {
    $scope.currentPage_customer_data = pageNo;
};

$scope.pageChanged_customer_data = function() {
    console.log('Page changed to: ' + $scope.currentPage_customer_data);
};

$scope.setItemsPerPage_customer_data = function(num) {
    $scope.itemsPerPage_customer_data = num;
$scope.currentPage_customer_data = 1; //reset to first paghe
}

$scope.payment = function(v){

    var index = $scope.customer_payment_data.indexOf(v);

    console.log($scope.customer_payment_data[index]);
    return false;

    $scope.modal = {
        title : 'Please input the amount of payment',
        save : 'Pay',
        close : 'Cancel'
    }     
    ngDialog.openConfirm({
        template: 'PaymentModal',
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
        $scope.customer_payment_data[index].new_balance = parseInt($scope.customer_payment_data[index].result) - parseInt($scope.modal.amount);
        $scope.customer_payment_data[index].down_payment_amount_new = parseInt($scope.customer_payment_data[index].down_payment_amount) + parseInt($scope.modal.amount);
        var datas = {
            pk : $scope.customer_payment_data[index].pk,
            new_balance : $scope.customer_payment_data[index].new_balance,
            down_payment_amount_new : $scope.customer_payment_data[index].down_payment_amount_new
        }

        var promise = ProductFactory.payment(datas);
        promise.then(function(data){
            var notify = $.notify('You have succesfully added the payment', { 'type': 'success', allow_dismiss: true });
            get_customer_payment();
            cfpLoadingBar.complete();
        })
        .then(null, function(data){
            var notify = $.notify('Oops there something wrong!', { 'type': 'danger', allow_dismiss: true });
            cfpLoadingBar.complete();
        });

    });
}

$scope.add_customer_payment = function(v){

    var index = $scope.customer_payment_data.indexOf(v);

    cfpLoadingBar.start();

    var datas = {
        pk : $scope.customer_payment_data[index].pk,
        customer_name : $scope.customer_payment_data[index].customer_name
    }
    var promise = ProductFactory.add_customer_payment(datas);
    promise.then(function(data){
        var notify = $.notify('You have succesfully added the customer', { 'type': 'success', allow_dismiss: true });
        get_customer_payment();
        cfpLoadingBar.complete();
    })
    .then(null, function(data){
        var notify = $.notify('Oops there something wrong!', { 'type': 'danger', allow_dismiss: true });
        cfpLoadingBar.complete();
    });
}


$scope.add_payment= function(){



    $scope.modal = {
        title : 'Add Record Petty Cash Out',
        save : 'Save',
        close : 'Cancel'
    }     

    ngDialog.openConfirm({
        template: 'OpenModal',
        className: 'ngdialog-theme-plain dialogwidth500',
        preCloseCallback: function(value) {
            var nestedConfirmDialog;
            if ($scope.modal.ProductName == '' || $scope.modal.ProductName == "" || $scope.modal.ProductName == NaN || $scope.modal.ProductName == null || $scope.modal.ProductName == undefined || $scope.modal.ProductName == 'NaN') {
                var notify = $.notify('Oops there something wrong with the Product Name!', {'type': 'danger' ,  allow_dismiss: true });
                cfpLoadingBar.complete();
                return false;
            }
            if ($scope.modal.Productamount == '' || $scope.modal.Productamount == "" || $scope.modal.Productamount == NaN || $scope.modal.Productamount == null || $scope.modal.Productamount == undefined || $scope.modal.Productamount == 'NaN') {
                var notify = $.notify('Oops there something wrong with the Product Amount!', {'type': 'danger' ,  allow_dismiss: true });
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
        var promise = UserFactory.add_payment($scope.modal);
        promise.then(function(data){
            var notify = $.notify('You have succesfully added the payment', { 'type': 'success', allow_dismiss: true });
            get_payment_data();
            cfpLoadingBar.complete();
        })
        .then(null, function(data){
            var notify = $.notify('Oops there something wrong!', { 'type': 'danger', allow_dismiss: true });
            cfpLoadingBar.complete();
        });

    });
}

function get_payment_data(){

    var promise = UserFactory.get_payment_data();
    promise.then(function(data){
        $scope.payment_data = data.data.result;
        console.log($scope.payment_data);

        var a = 0;
        for (var i in $scope.payment_data) {
            $scope.payment_data[i].date_created = new Date($scope.payment_data[i].date_created);
            $scope.payment_data[i].number = a += 1;
        };

        $scope.totalItems_payment_data = $scope.payment_data.length;

    })
    .then(null, function(data){

    });
}
$scope.setPage_payment_data = function (pageNo) {
    $scope.currentPage_payment_data = pageNo;
};

$scope.pageChanged_payment_data = function() {
    console.log('Page changed to: ' + $scope.currentPage_payment_data);
};

$scope.setItemsPerPage_payment_data = function(num) {
    $scope.itemsPerPage_payment_data = num;
$scope.currentPage_payment_data = 1; //reset to first paghe
}

$scope.edit_payment = function(v){

    var index = $scope.payment_data.indexOf(v);
    console.log($scope.payment_data[v]);

    $scope.modal = {
       title : 'Edit Record Petty Cash Out',
       message: '',
       save : 'Edit',
       close : 'Cancel',
       ProductName:$scope.payment_data[index].productname,
       Productamount:$scope.payment_data[index].productamount,
       pk:$scope.payment_data[index].pk
   };

   ngDialog.openConfirm({
       template: 'EditModal',
       className: 'ngdialog-theme-plain dialogwidth500',
       preCloseCallback: function(value) {
        var nestedConfirmDialog;
        if ($scope.modal.ProductName == '' || $scope.modal.ProductName == "" || $scope.modal.ProductName == NaN || $scope.modal.ProductName == null || $scope.modal.ProductName == undefined || $scope.modal.ProductName == 'NaN') {
            var notify = $.notify('Oops there something wrong with the Product Name!', {'type': 'danger' ,  allow_dismiss: true });
            cfpLoadingBar.complete();
            return false;
        }
        if ($scope.modal.Productamount == '' || $scope.modal.Productamount == "" || $scope.modal.Productamount == NaN || $scope.modal.Productamount == null || $scope.modal.Productamount == undefined || $scope.modal.Productamount == 'NaN') {
            var notify = $.notify('Oops there something wrong with the Product Amount!', {'type': 'danger' ,  allow_dismiss: true });
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
    console.log(v);

    var promise = UserFactory.edit_payment($scope.modal);
    promise.then(function(data){
        get_payment_data();
    })
    .then(null, function(data){

    });

});
}

$scope.delete_payment = function(v){
    var index = $scope.payment_data.indexOf(v);
    console.log(v);
    var pk = {
        pk:$scope.payment_data[index].pk
    }

    var promise = UserFactory.delete_payment(pk);
    promise.then(function(data){
     var notify = $.notify('You have succesfully deleted the Payment details', { 'type': 'success', allow_dismiss: true });
     get_payment_data();
     cfpLoadingBar.complete();
 })
    .then(null, function(data){
     var notify = $.notify('Oops there is something wrong!', { 'type': 'danger', allow_dismiss: true });
     cfpLoadingBar.complete();
 });
}


$scope.get_payment_filter = function(){

    filter = {
        date_from : $filter('date')($scope.form.date1._d, "yyyy-MM-dd"),
        date_to : $filter('date')($scope.form.date2._d, "yyyy-MM-dd")
    }
    var promise = ProductFactory.get_payment_filter(filter);
    promise.then(function(data){
        $scope.payment_data = data.data.result;

        var a = 0;
        for (var i in $scope.payment_data) {
            $scope.payment_data[i].date_created = new Date($scope.payment_data[i].date_created);
            $scope.payment_data[i].number = a += 1;
        };

        for (var k in $scope.payment_data) {
            $scope.payment_data[k].result = parseInt($scope.payment_data[k].total) - parseInt($scope.payment_data[k].down_payment_amount);
        };

        for (var z in $scope.payment_data) {

            if ($scope.payment_data[z].result != 0) {
                $scope.payment_data[z].show_me = true;
            }else{
                $scope.payment_data[z].show_me = false;
            };

        };

    })
    .then(null, function(data){

    });
}
$scope.setPage_payment_data = function (pageNo) {
    $scope.currentPage_payment_data = pageNo;
};

$scope.pageChanged_payment_data = function() {
    console.log('Page changed to: ' + $scope.currentPage_payment_data);
};

$scope.setItemsPerPage_payment_data = function(num) {
    $scope.itemsPerPage_payment_data = num;
$scope.currentPage_payment_data = 1; //reset to first paghe
}


$scope.print_pdf_custpay = function(){
    if (filter.date_from == undefined || filter.date_from == 'undefined' || filter.date_to == undefined || filter.date_to == 'undefined') {
    
    filter = {
        date_from : $filter('date')(new Date(new Date().getFullYear(), new Date().getMonth(), 1), "yyyy-MM-dd"),
        date_to : $filter('date')(new Date(new Date().getFullYear(), new Date().getMonth() + 1, 0), "yyyy-MM-dd")    
    };

}
    window.open('./FUNCTIONS/Customer/print_pdf_custpay.php?date_from='+filter.date_from+'&date_to='+filter.date_to);
}
$scope.print_pdf_payment = function(){
 if (filter.date_from == undefined || filter.date_from == 'undefined' || filter.date_to == undefined || filter.date_to == 'undefined') {
    
    filter = {
        date_from : $filter('date')(new Date(new Date().getFullYear(), new Date().getMonth(), 1), "yyyy-MM-dd"),
        date_to : $filter('date')(new Date(new Date().getFullYear(), new Date().getMonth() + 1, 0), "yyyy-MM-dd")    
    };

}
window.open('./FUNCTIONS/Customer/print_pdf_payment.php?date_from='+filter.date_from+'&date_to='+filter.date_to);

}


$scope.print_csvs_payment = function(){
if (filter.date_from == undefined || filter.date_from == 'undefined' || filter.date_to == undefined || filter.date_to == 'undefined') {
    
    filter = {
        date_from : $filter('date')(new Date(new Date().getFullYear(), new Date().getMonth(), 1), "yyyy-MM-dd"),
        date_to : $filter('date')(new Date(new Date().getFullYear(), new Date().getMonth() + 1, 0), "yyyy-MM-dd")    
    };
     
}
 window.open('./FUNCTIONS/Customer/print_csvs_payment.php?date_from='+filter.date_from+'&date_to='+filter.date_to);
}
$scope.print_pdf_custpay_csv = function(){
if (filter.date_from == undefined || filter.date_from == 'undefined' || filter.date_to == undefined || filter.date_to == 'undefined') {
    
    filter = {
        date_from : $filter('date')(new Date(new Date().getFullYear(), new Date().getMonth(), 1), "yyyy-MM-dd"),
        date_to : $filter('date')(new Date(new Date().getFullYear(), new Date().getMonth() + 1, 0), "yyyy-MM-dd")    
    };
     
}
 window.open('./FUNCTIONS/Customer/print_pdf_custpay_csv.php?date_from='+filter.date_from+'&date_to='+filter.date_to);
}

});

