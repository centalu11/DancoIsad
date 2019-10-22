app.controller('Newsfeed', function(
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
    $scope.modal = {};
    $scope.form = {};

    $scope.ads_image = {};
    $scope.ads_image.queue = {};

    $scope.ads_article = {};
    $scope.ads_article.queue = {};

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
            get_news_feed();
            get_news_flash();
            get_news_feed_ads();
            get_news_feed_gif();
            

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


    function get_news_feed(){
        cfpLoadingBar.start();
        var promise = ProductFactory.get_news_feed();
        promise.then(function(data){
            $scope.news_feed_data = data.data.result;
            var a = 0;
            for (var i in $scope.news_feed_data) {
                $scope.news_feed_data[i].date_created = new Date($scope.news_feed_data[i].date_created);
                $scope.news_feed_data[i].number = a += 1;
            };

            for (var k in $scope.news_feed_data) {
                if ($scope.news_feed_data[k].link == null || $scope.news_feed_data[k].link == 'null' || $scope.news_feed_data[k].link == "") {
                    $scope.news_feed_data[k].link = "None";
                };
            };

            for (var z in $scope.news_feed_data) {
                if ($scope.news_feed_data[z].name == null || $scope.news_feed_data[z].name == 'null' || $scope.news_feed_data[z].name == "") {
                    $scope.news_feed_data[z].name = "None";
                };
            };

            for (var t in $scope.news_feed_data) {
                if ($scope.news_feed_data[t].description == null || $scope.news_feed_data[t].description == 'null' || $scope.news_feed_data[t].description == "" || $scope.news_feed_data[t].description == "undefined") {
                    $scope.news_feed_data[t].description = "None";
                };
            };

        })
        .then(null, function(data){

            cfpLoadingBar.complete();

        });
    }

    function get_news_feed_ads(){
        cfpLoadingBar.start();
        var promise = ProductFactory.get_news_feed_ads();
        promise.then(function(data){
            $scope.news_feed_ads = data.data.result;
        })
        .then(null, function(data){

            cfpLoadingBar.complete();

        });
    }

    function get_news_feed_gif(){
        cfpLoadingBar.start();
        var promise = ProductFactory.get_news_feed_gif();
        promise.then(function(data){
            $scope.news_feed_gif = data.data.result;
            console.log($scope.news_feed_gif);

        })
        .then(null, function(data){

            cfpLoadingBar.complete();

        });
    }

    function get_news_flash(){
        cfpLoadingBar.start();
        var promise = ProductFactory.get_news_flash();
        promise.then(function(data){
            $scope.news_flash_data = data.data.result;

            var a = 0;
            for (var i in $scope.news_flash_data) {
                $scope.news_flash_data[i].date_created = new Date($scope.news_flash_data[i].date_created);
                $scope.news_flash_data[i].number = a += 1;
            };

        })
        .then(null, function(data){

            cfpLoadingBar.complete();

        });
    }

    $scope.add_newsflash = function(){


        $scope.modal = {
            title : 'Add News Flash',
            save : 'Add',
            close : 'Cancel'
        }     

        ngDialog.openConfirm({
            template: 'AddNF',
            className: 'ngdialog-theme-plain dialogwidth500',
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
            $scope.modal.user_id = $scope.user.user_id;
            $scope.modal.type = 'NewsFlash';
            var promise = ProductFactory.add_newsflash($scope.modal);
            promise.then(function(data){
                var notify = $.notify('You have succesfully added a new news flash', { 'type': 'success', allow_dismiss: true });
                $route.reload();
                cfpLoadingBar.complete();
            })
            .then(null, function(data){
                var notify = $.notify('Oops there is something wrong!', { 'type': 'danger', allow_dismiss: true });
                cfpLoadingBar.complete();
            });
        });
    }

    $scope.add_ads = function(){


        $scope.modal = {
            title : 'Add Advertisement',
            save : 'Add',
            close : 'Cancel'
        }     

        ngDialog.openConfirm({
            template: 'AddAds',
            className: 'ngdialog-theme-plain dialogwidth500',
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
            $scope.modal.user_id = $scope.user.user_id;
            $scope.modal.image_source = $scope.modal.image_source;
            $scope.modal.type = 'Advertisement';
            var promise = ProductFactory.add_ads($scope.modal);
            promise.then(function(data){
                var notify = $.notify('You have succesfully added a new news flash', { 'type': 'success', allow_dismiss: true });
                $route.reload();
                cfpLoadingBar.complete();
            })
            .then(null, function(data){
                var notify = $.notify('Oops there is something wrong!', { 'type': 'danger', allow_dismiss: true });
                cfpLoadingBar.complete();
            });
        });
    }

    var ads_image = $scope.ads_image = new FileUploader({
        url: 'FUNCTIONS/Uploads/upload_register.php'
    });

    ads_image.filters.push({
        'name': 'enforceMaxFileSize',
        'fn': function (item) {
            return item.size <= 10485760; 
        }
    });

    ads_image.onWhenAddingFileFailed = function(item /*{File|FileLikeObject}*/, filter, options) {
//console.info('onWhenAddingFileFailed', item, filter, options);
};
ads_image.onAfterAddingFile = function(fileItem) {
//console.info('onAfterAddingFile', fileItem);
};
ads_image.onAfterAddingAll = function(addedFileItems) {
//console.info('onAfterAddingAll', addedFileItems);
};
ads_image.onBeforeUploadItem = function(item) {
//console.info('onBeforeUploadItem', item);
};
ads_image.onProgressItem = function(fileItem, progress) {
//console.info('onProgressItem', fileItem, progress);
};
ads_image.onProgressAll = function(progress) {
//console.info('onProgressAll', progress);
};
ads_image.onSuccessItem = function(fileItem, response, status, headers) {
//console.info('onSuccessItem', fileItem, response, status, headers);
};
ads_image.onErrorItem = function(fileItem, response, status, headers) {
//console.info('onErrorItem', fileItem, response, status, headers);
};
ads_image.onCancelItem = function(fileItem, response, status, headers) {
//console.info('onCancelItem', fileItem, response, status, headers);
};
ads_image.onCompleteItem = function(fileItem, response, status, headers) {
// console.log('onCompleteItem', fileItem, respsonse, status, headers);
//$scope.data.quotationmodal.attachment = response.file;
$scope.modal.image_source = response.file;
console.log($scope.modal.image_source);


};
ads_image.onCompleteAll = function() {

};

    $scope.add_gif = function(){


        $scope.modal = {
            title : 'Add Articles',
            save : 'Add',
            close : 'Cancel'
        }     

        ngDialog.openConfirm({
            template: 'AddArticles',
            className: 'ngdialog-theme-plain dialogwidth500',
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
            $scope.modal.user_id = $scope.user.user_id;
            $scope.modal.alink = 'None';
            $scope.form.image_source = $scope.form.image_source;
            $scope.modal.type = 'GIF';
            var promise = ProductFactory.add_articles($scope.modal);
            promise.then(function(data){
                var notify = $.notify('You have succesfully added a new article', { 'type': 'success', allow_dismiss: true });
                $route.reload();
                cfpLoadingBar.complete();
            })
            .then(null, function(data){
                var notify = $.notify('Oops there is something wrong!', { 'type': 'danger', allow_dismiss: true });
                cfpLoadingBar.complete();
            });
        });
    }

    

var ads_article = $scope.ads_article = new FileUploader({
    url: 'FUNCTIONS/Uploads/upload_register.php'
});

ads_article.filters.push({
    'name': 'enforceMaxFileSize',
    'fn': function (item) {
        return item.size <= 104857600000; 
    }
});

ads_article.onWhenAddingFileFailed = function(item /*{File|FileLikeObject}*/, filter, options) {
//console.info('onWhenAddingFileFailed', item, filter, options);
};
ads_article.onAfterAddingFile = function(fileItem) {
//console.info('onAfterAddingFile', fileItem);
};
ads_article.onAfterAddingAll = function(addedFileItems) {
//console.info('onAfterAddingAll', addedFileItems);
};
ads_article.onBeforeUploadItem = function(item) {
//console.info('onBeforeUploadItem', item);
};
ads_article.onProgressItem = function(fileItem, progress) {
//console.info('onProgressItem', fileItem, progress);
};
ads_article.onProgressAll = function(progress) {
//console.info('onProgressAll', progress);
};
ads_article.onSuccessItem = function(fileItem, response, status, headers) {
//console.info('onSuccessItem', fileItem, response, status, headers);
};
ads_article.onErrorItem = function(fileItem, response, status, headers) {
//console.info('onErrorItem', fileItem, response, status, headers);
};
ads_article.onCancelItem = function(fileItem, response, status, headers) {
//console.info('onCancelItem', fileItem, response, status, headers);
};
ads_article.onCompleteItem = function(fileItem, response, status, headers) {
// console.log('onCompleteItem', fileItem, respsonse, status, headers);
//$scope.data.quotationmodal.attachment = response.file;
$scope.modal.image_source = response.file;
console.log($scope.modal.image_source);


};
ads_article.onCompleteAll = function() {

};

$scope.check_edit_news_feed_data = function(v){
    var index = $scope.news_feed_data.indexOf(v);
    if ($scope.news_feed_data[index].type == "NewsFlash") {
        $scope.edit_news_feed_data(v);
    };
    if ($scope.news_feed_data[index].type == "Advertisement") {
        $scope.edit_ads_data(v);
    };

    if ($scope.news_feed_data[index].type == "GIF") {
        $scope.edit_gif_data(v);
    };
} 

$scope.edit_ads_data = function(v){
    var index = $scope.news_feed_data.indexOf(v);

    $scope.modal = {
        title : 'Edit Ads',
        save : 'Update',
        close : 'Cancel',
        image_source : $scope.news_feed_data[index].description
    }     

    ngDialog.openConfirm({
        template: 'EditAds',
        className: 'ngdialog-theme-plain dialogwidth500',
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
        $scope.modal.pk = $scope.news_feed_data[index].pk;
        $scope.modal.user_id = $scope.user.user_id;
        $scope.modal.image_source = $scope.modal.image_source;
        $scope.modal.type = 'Advertisement';
        var promise = ProductFactory.edit_ads_data($scope.modal);
        promise.then(function(data){
            var notify = $.notify('You have succesfully updated a new news flash', { 'type': 'success', allow_dismiss: true });
            get_news_feed();
            cfpLoadingBar.complete();
        })
        .then(null, function(data){
            var notify = $.notify('Oops there is something wrong!', { 'type': 'danger', allow_dismiss: true });
            cfpLoadingBar.complete();
        });
    });
}

$scope.edit_gif_data = function(v){
    var index = $scope.news_feed_data.indexOf(v);

    $scope.modal = {
        title : 'Edit GIF',
        save : 'Update',
        close : 'Cancel',
        image_source : $scope.news_feed_data[index].description,
        aname : $scope.news_feed_data[index].name,
        alink : $scope.news_feed_data[index].link
    }     

    ngDialog.openConfirm({
        template: 'EditArticle',
        className: 'ngdialog-theme-plain dialogwidth500',
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
        $scope.modal.pk = $scope.news_feed_data[index].pk;
        $scope.modal.user_id = $scope.user.user_id;
        $scope.modal.image_source = $scope.modal.image_source;
        $scope.modal.alink = 'None';
        $scope.modal.type = 'GIF';
        var promise = ProductFactory.edit_article_data($scope.modal);
        promise.then(function(data){
            var notify = $.notify('You have succesfully updated a new news flash', { 'type': 'success', allow_dismiss: true });
            get_news_feed();
            cfpLoadingBar.complete();
        })
        .then(null, function(data){
            var notify = $.notify('Oops there is something wrong!', { 'type': 'danger', allow_dismiss: true });
            cfpLoadingBar.complete();
        });
    });
}

$scope.edit_news_feed_data = function(v){
    var index = $scope.news_feed_data.indexOf(v);

    $scope.modal = {
        title : 'Edit News Flash',
        save : 'Update',
        close : 'Cancel',
        news_flash : $scope.news_feed_data[index].description
    }     

    ngDialog.openConfirm({
        template: 'EditNewsFlash',
        className: 'ngdialog-theme-plain dialogwidth500',
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
        $scope.modal.pk = $scope.news_feed_data[index].pk;
        $scope.modal.user_id = $scope.user.user_id;
        $scope.modal.type = 'NewsFlash';
        var promise = ProductFactory.edit_news_feed_data($scope.modal);
        promise.then(function(data){
            var notify = $.notify('You have succesfully updated a new news flash', { 'type': 'success', allow_dismiss: true });
            get_news_feed();
            cfpLoadingBar.complete();
        })
        .then(null, function(data){
            var notify = $.notify('Oops there is something wrong!', { 'type': 'danger', allow_dismiss: true });
            cfpLoadingBar.complete();
        });
    });
}

$scope.delete_news_feed_data = function(v){
    var index = $scope.news_feed_data.indexOf(v);

    cfpLoadingBar.start();
    $scope.modal.pk = $scope.news_feed_data[index].pk;
    var promise = ProductFactory.delete_news_feed_data($scope.modal);
    promise.then(function(data){
        var notify = $.notify('You have succesfully deleted a new news flash', { 'type': 'success', allow_dismiss: true });
        get_news_feed();
        cfpLoadingBar.complete();
    })
    .then(null, function(data){
        var notify = $.notify('Oops there is something wrong!', { 'type': 'danger', allow_dismiss: true });
        cfpLoadingBar.complete();
    });
}



});