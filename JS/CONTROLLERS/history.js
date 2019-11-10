app.controller('History', function(
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

    $scope.viewby_history_data = 10;
    $scope.currentPage_history_data = 4;
    $scope.itemsPerPage_history_data = $scope.viewby_history_data;
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
            get_history();

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


function get_history(){
    cfpLoadingBar.start();

    var promise = ProductFactory.get_accounts_logs(filters);
    promise.then(function(data){
        $scope.history_data = data.data.result;
        var a = 0;
        for (var i in $scope.history_data) {
            $scope.history_data[i].datetime = moment($scope.history_data[i].datetime).format('LLLL');
            $scope.history_data[i].number = a += 1;
        };

        $scope.history_data_status = true;

        $scope.totalItems_history_data = $scope.history_data.length;
    })
.then(null, function(data){
$scope.history_data_status = false;
cfpLoadingBar.complete();
});
}


});