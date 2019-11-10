app.controller('Sales', function( 
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
    $scope.cashier_name = {};
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

    var filtered = {};

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
            get_reports();

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

    function get_reports(){
    cfpLoadingBar.start();
    var filter = {
        name : 'All',
        date_from : '2018-01-01',
        date_to : '2018-12-31'
    }; 

    var promise = ProductFactory.get_reports(filter);
    promise.then(function(data){
        $scope.tender_data = data.data.result;

        var a = 0;
        for (var i in $scope.tender_data) {
            $scope.tender_data[i].date_created = new Date($scope.tender_data[i].date_created);
            $scope.tender_data[i].date_created = moment($scope.tender_data[i].date_created).format('MMMM');
            $scope.tender_data[i].number = a += 1;
        };

        var b = 0;
        var c = 0;
        var p = 0;
        var k = 0;
        var januaryx = 0;
        var februaryx = 0;
        var marchx = 0;
        var aprilx = 0;
        var mayx = 0;
        var junex = 0;
        var julyx = 0;
        var augustx = 0;
        var septemberx = 0;
        var octoberx = 0;
        var novemberx = 0;
        var decemberx = 0;
        for (var i in $scope.tender_data) {
            c = $scope.tender_data[i].product_quantity;
            p = $scope.tender_data[i].product_retail_price;
            k = parseFloat(c) * parseFloat(p);
            $scope.tender_data[i].tempo_total = k;
        };

        $scope.form.totaaal = 0;
        for (var k in $scope.tender_data) {
            $scope.form.totaaal += parseFloat($scope.tender_data[k].tempo_total);
            $scope.form.final_totaal = $scope.form.totaaal.toFixed(2);
        };


        var chartdata1 = [];

        for(var j in $scope.tender_data){
            if ($scope.tender_data[j].date_created == "January") {
            c = $scope.tender_data[j].product_quantity;
            p = $scope.tender_data[j].product_retail_price;
            k = parseFloat(c) * parseFloat(p);
            januaryx += k;
        
            };

            if ($scope.tender_data[j].date_created == "February") {
            c = $scope.tender_data[j].product_quantity;
            p = $scope.tender_data[j].product_retail_price;
            k = parseFloat(c) * parseFloat(p);
            februaryx += k;
        
            };

            if ($scope.tender_data[j].date_created == "March") {
            c = $scope.tender_data[j].product_quantity;
            p = $scope.tender_data[j].product_retail_price;
            k = parseFloat(c) * parseFloat(p);
            marchx += k;
        
            };

            if ($scope.tender_data[j].date_created == "April") {
            c = $scope.tender_data[j].product_quantity;
            p = $scope.tender_data[j].product_retail_price;
            k = parseFloat(c) * parseFloat(p);
            aprilx += k;
        
            };

            if ($scope.tender_data[j].date_created == "May") {
            c = $scope.tender_data[j].product_quantity;
            p = $scope.tender_data[j].product_retail_price;
            k = parseFloat(c) * parseFloat(p);
            mayx += k;
        
            };

            if ($scope.tender_data[j].date_created == "June") {
            c = $scope.tender_data[j].product_quantity;
            p = $scope.tender_data[j].product_retail_price;
            k = parseFloat(c) * parseFloat(p);
            junex += k;
            };

            if ($scope.tender_data[j].date_created == "July") {
            c = $scope.tender_data[j].product_quantity;
            p = $scope.tender_data[j].product_retail_price;
            k = parseFloat(c) * parseFloat(p);
            julyx += k;
        
            };

            if ($scope.tender_data[j].date_created == "August") {
            c = $scope.tender_data[j].product_quantity;
            p = $scope.tender_data[j].product_retail_price;
            k = parseFloat(c) * parseFloat(p);
            augustx += k;
        
            };

            if ($scope.tender_data[j].date_created == "September") {
            c = $scope.tender_data[j].product_quantity;
            p = $scope.tender_data[j].product_retail_price;
            k = parseFloat(c) * parseFloat(p);
            septemberx += k;
        
            };

            if ($scope.tender_data[j].date_created == "October") {
            c = $scope.tender_data[j].product_quantity;
            p = $scope.tender_data[j].product_retail_price;
            k = parseFloat(c) * parseFloat(p);
            octoberx += k;
        
            };

            if ($scope.tender_data[j].date_created == "November") {
            c = $scope.tender_data[j].product_quantity;
            p = $scope.tender_data[j].product_retail_price;
            k = parseFloat(c) * parseFloat(p);
            novemberx += k;
        
            };

            if ($scope.tender_data[j].date_created == "December") {
            c = $scope.tender_data[j].product_quantity;
            p = $scope.tender_data[j].product_retail_price;
            k = parseFloat(c) * parseFloat(p);
            decemberx += k;
        
            };
        }
        chartdata1.push({   
               "month": "January",
                "sales": januaryx
            });
        chartdata1.push({   
               "month": "February",
                "sales": februaryx
            });
        chartdata1.push({   
               "month": "March",
                "sales": marchx
            });
        chartdata1.push({   
               "month": "April",
                "sales": aprilx
            });
        chartdata1.push({   
               "month": "May",
                "sales": mayx
            });
        chartdata1.push({   
               "month": "June",
                "sales": junex
            });
        chartdata1.push({   
               "month": "July",
                "sales": julyx
            });
        chartdata1.push({   
               "month": "August",
                "sales": augustx
            });
        chartdata1.push({   
               "month": "September",
                "sales": septemberx
            });
        chartdata1.push({   
               "month": "October",
                "sales": octoberx
            });
        chartdata1.push({   
               "month": "November",
                "sales": novemberx
            });
        chartdata1.push({   
               "month": "December",
                "sales": decemberx
            });
        

        var chart = AmCharts.makeChart( "chartdiv", {
            "type": "serial",
            "theme": "light",
            "dataProvider": chartdata1,
            "valueAxes": [ {
                "gridColor": "#FFFFFF",
                "gridAlpha": 0.2,
                "dashLength": 0
            } ],
            "gridAboveGraphs": true,
            "startDuration": 1,
            "graphs": [ {
                "balloonText": "[[category]]: <b>[[value]]</b>",
                "fillAlphas": 0.8,
                "lineAlpha": 0.2,
                "type": "column",
                "valueField": "sales"
            } ],
            "chartCursor": {
                "categoryBalloonEnabled": false,
                "cursorAlpha": 0,
                "zoomable": false
            },
            "categoryField": "month",
            "categoryAxis": {
                "gridPosition": "start",
                "gridAlpha": 0,
                "tickPosition": "start",
                "tickLength": 20
            },
            "export": {
                "enabled": true
            }

        } );

})
.then(null, function(data){
    cfpLoadingBar.complete();

});
}

$scope.get_reports = function(){
    cfpLoadingBar.start();
    $scope.form.date1 = moment($scope.form.date1).format('YYYY');
    var filter = {
        name : 'All',
        date_from : $scope.form.date1+'/01/01/',
        date_to : $scope.form.date1+'/12/31/'
    }; 


    var promise = ProductFactory.get_reports(filter);
    promise.then(function(data){
        $scope.tender_data = data.data.result;

        var a = 0;
        for (var i in $scope.tender_data) {
            $scope.tender_data[i].date_created = new Date($scope.tender_data[i].date_created);
            $scope.tender_data[i].date_created = moment($scope.tender_data[i].date_created).format('MMMM');
            $scope.tender_data[i].number = a += 1;
        };

        var b = 0;
        var c = 0;
        var p = 0;
        var k = 0;
        var januaryx = 0;
        var februaryx = 0;
        var marchx = 0;
        var aprilx = 0;
        var mayx = 0;
        var junex = 0;
        var julyx = 0;
        var augustx = 0;
        var septemberx = 0;
        var octoberx = 0;
        var novemberx = 0;
        var decemberx = 0;
        for (var i in $scope.tender_data) {
            c = $scope.tender_data[i].product_quantity;
            p = $scope.tender_data[i].product_retail_price;
            k = parseFloat(c) * parseFloat(p);
            $scope.tender_data[i].tempo_total = k;
        };

        $scope.form.totaaal = 0;
        for (var k in $scope.tender_data) {
            $scope.form.totaaal += parseFloat($scope.tender_data[k].tempo_total);
            $scope.form.final_totaal = $scope.form.totaaal.toFixed(2);
        };


        var chartdata1 = [];

        for(var j in $scope.tender_data){
            if ($scope.tender_data[j].date_created == "January") {
            c = $scope.tender_data[j].product_quantity;
            p = $scope.tender_data[j].product_retail_price;
            k = parseFloat(c) * parseFloat(p);
            januaryx += k;
        
            };

            if ($scope.tender_data[j].date_created == "February") {
            c = $scope.tender_data[j].product_quantity;
            p = $scope.tender_data[j].product_retail_price;
            k = parseFloat(c) * parseFloat(p);
            februaryx += k;
        
            };

            if ($scope.tender_data[j].date_created == "March") {
            c = $scope.tender_data[j].product_quantity;
            p = $scope.tender_data[j].product_retail_price;
            k = parseFloat(c) * parseFloat(p);
            marchx += k;
        
            };

            if ($scope.tender_data[j].date_created == "April") {
            c = $scope.tender_data[j].product_quantity;
            p = $scope.tender_data[j].product_retail_price;
            k = parseFloat(c) * parseFloat(p);
            aprilx += k;
        
            };

            if ($scope.tender_data[j].date_created == "May") {
            c = $scope.tender_data[j].product_quantity;
            p = $scope.tender_data[j].product_retail_price;
            k = parseFloat(c) * parseFloat(p);
            mayx += k;
        
            };

            if ($scope.tender_data[j].date_created == "June") {
            c = $scope.tender_data[j].product_quantity;
            p = $scope.tender_data[j].product_retail_price;
            k = parseFloat(c) * parseFloat(p);
            junex += k;
            };

            if ($scope.tender_data[j].date_created == "July") {
            c = $scope.tender_data[j].product_quantity;
            p = $scope.tender_data[j].product_retail_price;
            k = parseFloat(c) * parseFloat(p);
            julyx += k;
        
            };

            if ($scope.tender_data[j].date_created == "August") {
            c = $scope.tender_data[j].product_quantity;
            p = $scope.tender_data[j].product_retail_price;
            k = parseFloat(c) * parseFloat(p);
            augustx += k;
        
            };

            if ($scope.tender_data[j].date_created == "September") {
            c = $scope.tender_data[j].product_quantity;
            p = $scope.tender_data[j].product_retail_price;
            k = parseFloat(c) * parseFloat(p);
            septemberx += k;
        
            };

            if ($scope.tender_data[j].date_created == "October") {
            c = $scope.tender_data[j].product_quantity;
            p = $scope.tender_data[j].product_retail_price;
            k = parseFloat(c) * parseFloat(p);
            octoberx += k;
        
            };

            if ($scope.tender_data[j].date_created == "November") {
            c = $scope.tender_data[j].product_quantity;
            p = $scope.tender_data[j].product_retail_price;
            k = parseFloat(c) * parseFloat(p);
            novemberx += k;
        
            };

            if ($scope.tender_data[j].date_created == "December") {
            c = $scope.tender_data[j].product_quantity;
            p = $scope.tender_data[j].product_retail_price;
            k = parseFloat(c) * parseFloat(p);
            decemberx += k;
        
            };
        }
        chartdata1.push({   
               "month": "January",
                "sales": januaryx
            });
        chartdata1.push({   
               "month": "February",
                "sales": februaryx
            });
        chartdata1.push({   
               "month": "March",
                "sales": marchx
            });
        chartdata1.push({   
               "month": "April",
                "sales": aprilx
            });
        chartdata1.push({   
               "month": "May",
                "sales": mayx
            });
        chartdata1.push({   
               "month": "June",
                "sales": junex
            });
        chartdata1.push({   
               "month": "July",
                "sales": julyx
            });
        chartdata1.push({   
               "month": "August",
                "sales": augustx
            });
        chartdata1.push({   
               "month": "September",
                "sales": septemberx
            });
        chartdata1.push({   
               "month": "October",
                "sales": octoberx
            });
        chartdata1.push({   
               "month": "November",
                "sales": novemberx
            });
        chartdata1.push({   
               "month": "December",
                "sales": decemberx
            });
        

        var chart = AmCharts.makeChart( "chartdiv", {
            "type": "serial",
            "theme": "light",
            "dataProvider": chartdata1,
            "valueAxes": [ {
                "gridColor": "#FFFFFF",
                "gridAlpha": 0.2,
                "dashLength": 0
            } ],
            "gridAboveGraphs": true,
            "startDuration": 1,
            "graphs": [ {
                "balloonText": "[[category]]: <b>[[value]]</b>",
                "fillAlphas": 0.8,
                "lineAlpha": 0.2,
                "type": "column",
                "valueField": "sales"
            } ],
            "chartCursor": {
                "categoryBalloonEnabled": false,
                "cursorAlpha": 0,
                "zoomable": false
            },
            "categoryField": "month",
            "categoryAxis": {
                "gridPosition": "start",
                "gridAlpha": 0,
                "tickPosition": "start",
                "tickLength": 20
            },
            "export": {
                "enabled": true
            }

        } );

})
.then(null, function(data){
    cfpLoadingBar.complete();

});
}

});