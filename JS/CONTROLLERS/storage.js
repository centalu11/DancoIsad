app.controller('Storage', function(
                                    $scope,
                                    SessionFactory,
                                    UserFactory,
                                    ProductFactory,
                                    md5,
                                    $filter,
                                    ngDialog,
                                    cfpLoadingBar,
                                    $route,
                                    cfpLoadingBar
                                    ) 
                                {

    $scope.user = {};
    $scope.pk = null;
    $scope.storage = {};
    init();

    function init(){
        cfpLoadingBar.start();
        var promise = SessionFactory.getsession();
        promise.then(function(data){
            var _id = md5.createHash('pk');
            $scope.pk = data.data[_id];
            get_user();
            service_charts();
            get_service();
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
            get_storage();
        })
        .then(null, function(data){
            var promise = SessionFactory.logout();
            promise.then(function(data){
                window.location = './login.html';
            });
        });
    }

    function get_storage(){
        var promise = ProductFactory.get_storage();
        promise.then(function(data){
            $scope.storage = data.data.result[0];
            var Bunny_MB = 0;
            var Bunny_MBs = 0;
            var final_split = data.data.size.replace('/var/www/html/invento/',' '); // Repo Size

            final_split = parseInt(final_split); // Repo Size Parse INT
            final_times = final_split * 1024;
            $scope.db_size = $scope.storage.pg_database_size; // Database Size - invento_bunny

            var bytes = final_times + parseInt($scope.db_size);
            
            var gb = 10737418240; //10GB
            var total_space = gb - bytes;
            var sizeInMBGB = (total_space / (1024*1024)).toFixed(2);
            var sizeInByteGB = (bytes / (1024*1024)).toFixed(2);
            
            $scope.labels = ["Consumed (MB)", "Free Space (MB)"];
            $scope.data = [sizeInByteGB, sizeInMBGB];
        })
        .then(null, function(data){
        });
    }

    function service_charts(){
        Chart.pluginService.register({
            beforeRender: function (chart) {
                if (chart.config.options.showAllTooltips) {

                    chart.pluginTooltips = [];
                    chart.config.data.datasets.forEach(function (dataset, i) {
                        chart.getDatasetMeta(i).data.forEach(function (sector, j) {
                            chart.pluginTooltips.push(new Chart.Tooltip({
                                _chart: chart.chart,
                                _chartInstance: chart,
                                _data: chart.data,
                                _options: chart.options.tooltips,
                                _active: [sector]
                            }, chart));
                        });
                    });


                    chart.options.tooltips.enabled = false;
                }
            },
            afterDraw: function (chart, easing) {
                if (chart.config.options.showAllTooltips) {

                    if (!chart.allTooltipsOnce) {
                        if (easing !== 1)
                            return;
                        chart.allTooltipsOnce = true;
                    }


                    chart.options.tooltips.enabled = true;
                    Chart.helpers.each(chart.pluginTooltips, function (tooltip) {
                        tooltip.initialize();
                        tooltip.update();

                        tooltip.pivot();
                        tooltip.transition(easing).draw();
                    });
                    chart.options.tooltips.enabled = false;
                }
            }
        })
    }

    function get_service(){
        $scope.options_data_req = { 
            legend: { display: true },
            tooltips: {
                enabled: true,  
                backgroundColor:'#36A2EB',
                cornerRadius: 0,
                callbacks: {
                    title: function(tooltipItems, data) {
                        return '';
                    },
                    label: function(tooltipItem, data) {
                        var datasetLabel = '';
                        var label = data.labels[tooltipItem.index];
                        return data.datasets[tooltipItem.datasetIndex].data[tooltipItem.index];
                    }
                }  
            },
            showAllTooltips: true
        };
        $scope.colors = ['#BF3FBF', '#BF3FBF'];
        $scope.override = { borderColor: ['rgba(247,70,74,1)', 'rgba(247,70,74,1)'] };
        
    }
});

