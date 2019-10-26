app.factory('ProductFactory', function($http, $location){
    var factory = {};
    
    factory.get_user = function(data){
        var promise = $http({
            url:'./FUNCTIONS/Users/get_user.php', 
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            transformRequest: function(obj) {
                var str = [];
                for(var p in obj)
                str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                return str.join("&");
            },
            data : data
        }) 

        return promise;
    };

    factory.exchange_item = function(data){
        var promise = $http({
            url:'./FUNCTIONS/Admin/exchange_item.php', 
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            transformRequest: function(obj) {
                var str = [];
                for(var p in obj)
                str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                return str.join("&");
            },
            data : data
        }) 

        return promise;
    };

    factory.get_barcode = function(data){
        var promise = $http({
            url:'./FUNCTIONS/Product/get_barcode.php', 
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            transformRequest: function(obj) {
                var str = [];
                for(var p in obj)
                str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                return str.join("&");
            },
            data : data
        }) 

        return promise;
    };

    factory.upload_inventory = function(data){
        var promise = $http({
            url:'./FUNCTIONS/Uploads/upload_inventory.php', 
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            transformRequest: function(obj) {
                var str = [];
                for(var p in obj)
                str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                return str.join("&");
            },
            data : data
        }) 

        return promise;
    };

    factory.tender_product_final_down_payment = function(data){
        var promise = $http({
            url:'./FUNCTIONS/Product/tender_product_final_down_payment.php', 
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            transformRequest: function(obj) {
                var str = [];
                for(var p in obj)
                str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                return str.join("&");
            },
            data : data
        }) 

        return promise;
    };

    factory.refund_item = function(data){
        var promise = $http({
            url:'./FUNCTIONS/Product/refund_item.php', 
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            transformRequest: function(obj) {
                var str = [];
                for(var p in obj)
                str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                return str.join("&");
            },
            data : data
        }) 

        return promise;
    };

    factory.get_customer_payment_filter = function(data){
        var promise = $http({
            url:'./FUNCTIONS/Customer/get_customer_payment_filter.php', 
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            transformRequest: function(obj) {
                var str = [];
                for(var p in obj)
                str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                return str.join("&");
            },
            data : data
        }) 

        return promise;
    };

    factory.payment = function(data){
        var promise = $http({
            url:'./FUNCTIONS/Customer/payment.php', 
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            transformRequest: function(obj) {
                var str = [];
                for(var p in obj)
                str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                return str.join("&");
            },
            data : data
        }) 

        return promise;
    };

    factory.get_customer_payment = function(data){
        var promise = $http({
            url:'./FUNCTIONS/Customer/get_customer_payment.php', 
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            transformRequest: function(obj) {
                var str = [];
                for(var p in obj)
                str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                return str.join("&");
            },
            data : data
        }) 

        return promise;
    };


    factory.update_pin = function(data){
        var promise = $http({
            url:'./FUNCTIONS/Users/update_pin.php', 
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            transformRequest: function(obj) {
                var str = [];
                for(var p in obj)
                str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                return str.join("&");
            },
            data : data
        }) 

        return promise;
    };

    factory.add_branch = function(data){
        var promise = $http({
            url:'./FUNCTIONS/Admin/add_branch.php', 
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            transformRequest: function(obj) {
                var str = [];
                for(var p in obj)
                str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                return str.join("&");
            },
            data : data
        }) 

        return promise;
    };
    
    factory.edit_article_data = function(data){
        var promise = $http({
            url:'./FUNCTIONS/Newsfeed/edit_article_data.php', 
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            transformRequest: function(obj) {
                var str = [];
                for(var p in obj)
                str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                return str.join("&");
            },
            data : data
        }) 

        return promise;
    };
       factory.get_news_flash = function(data){
        var promise = $http({
            url:'./FUNCTIONS/Newsfeed/get_news_flash.php', 
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            transformRequest: function(obj) {
                var str = [];
                for(var p in obj)
                str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                return str.join("&");
            },
            data : data
        }) 

        return promise;
    };
    factory.add_articles = function(data){
        var promise = $http({
            url:'./FUNCTIONS/Newsfeed/add_articles.php', 
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            transformRequest: function(obj) {
                var str = [];
                for(var p in obj)
                str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                return str.join("&");
            },
            data : data
        }) 

        return promise;
    };
        factory.edit_ads_data = function(data){
        var promise = $http({
            url:'./FUNCTIONS/Newsfeed/edit_ads_data.php', 
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            transformRequest: function(obj) {
                var str = [];
                for(var p in obj)
                str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                return str.join("&");
            },
            data : data
        }) 

        return promise;
    };
    
    factory.add_ads = function(data){
        var promise = $http({
            url:'./FUNCTIONS/Newsfeed/add_ads.php', 
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            transformRequest: function(obj) {
                var str = [];
                for(var p in obj)
                str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                return str.join("&");
            },
            data : data
        }) 

        return promise;
    };
    
    factory.delete_news_feed_data = function(data){
        var promise = $http({
            url:'./FUNCTIONS/Newsfeed/delete_news_feed_data.php', 
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            transformRequest: function(obj) {
                var str = [];
                for(var p in obj)
                str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                return str.join("&");
            },
            data : data
        }) 

        return promise;
    };

    factory.edit_news_feed_data = function(data){
        var promise = $http({
            url:'./FUNCTIONS/Newsfeed/edit_news_feed_data.php', 
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            transformRequest: function(obj) {
                var str = [];
                for(var p in obj)
                str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                return str.join("&");
            },
            data : data
        }) 

        return promise;
    };

    factory.get_news_feed = function(data){
        var promise = $http({
            url:'./FUNCTIONS/Newsfeed/get_news_feed.php', 
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            transformRequest: function(obj) {
                var str = [];
                for(var p in obj)
                str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                return str.join("&");
            },
            data : data
        }) 

        return promise;
    };

    factory.get_news_feed_ads = function(data){
        var promise = $http({
            url:'./FUNCTIONS/Newsfeed/get_news_feed_ads.php', 
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            transformRequest: function(obj) {
                var str = [];
                for(var p in obj)
                str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                return str.join("&");
            },
            data : data
        }) 

        return promise;
    };

    factory.get_news_feed_gif = function(data){
        var promise = $http({
            url:'./FUNCTIONS/Newsfeed/get_news_feed_gif.php', 
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            transformRequest: function(obj) {
                var str = [];
                for(var p in obj)
                str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                return str.join("&");
            },
            data : data
        }) 

        return promise;
    };
    
    factory.add_newsflash = function(data){
        var promise = $http({
            url:'./FUNCTIONS/Newsfeed/add_newsflash.php', 
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            transformRequest: function(obj) {
                var str = [];
                for(var p in obj)
                str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                return str.join("&");
            },
            data : data
        }) 

        return promise;
    };

    factory.update_this = function(data){
        var promise = $http({
            url:'./FUNCTIONS/Admin/update_this.php', 
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            transformRequest: function(obj) {
                var str = [];
                for(var p in obj)
                str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                return str.join("&");
            },
            data : data
        }) 

        return promise;
    };

    factory.edit_permission = function(data){
        var promise = $http({
            url:'./FUNCTIONS/Users/edit_permission.php', 
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            transformRequest: function(obj) {
                var str = [];
                for(var p in obj)
                str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                return str.join("&");
            },
            data : data
        }) 

        return promise;
    };

    factory.get_storage = function(data){
        var promise = $http({
            url:'./FUNCTIONS/Product/get_storage.php', 
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            transformRequest: function(obj) {
                var str = [];
                for(var p in obj)
                str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                return str.join("&");
            },
            data : data
        }) 

        return promise;
    };

    factory.get_aomos_discount_list = function(data){
        var promise = $http({
            url:'./FUNCTIONS/Discount/get_aomos_discount_list.php', 
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            transformRequest: function(obj) {
                var str = [];
                for(var p in obj)
                str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                return str.join("&");
            },
            data : data
        }) 

        return promise;
    };

    factory.get_aomos_payment_filter = function(data){
        var promise = $http({
            url:'./FUNCTIONS/Discount/get_aomos_payment_filter.php', 
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            transformRequest: function(obj) {
                var str = [];
                for(var p in obj)
                str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                return str.join("&");
            },
            data : data
        }) 

        return promise;
    };

    factory.edit_branch = function(data){
        var promise = $http({
            url:'./FUNCTIONS/Admin/edit_branch.php', 
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            transformRequest: function(obj) {
                var str = [];
                for(var p in obj)
                str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                return str.join("&");
            },
            data : data
        }) 

        return promise;
    };

    factory.delete_branch = function(data){
        var promise = $http({
            url:'./FUNCTIONS/Admin/delete_branch.php', 
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            transformRequest: function(obj) {
                var str = [];
                for(var p in obj)
                str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                return str.join("&");
            },
            data : data
        }) 

        return promise;
    };

    factory.add_customer = function(data){
        var promise = $http({
            url:'./FUNCTIONS/Admin/add_customer.php', 
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            transformRequest: function(obj) {
                var str = [];
                for(var p in obj)
                str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                return str.join("&");
            },
            data : data
        }) 

        return promise;
    };

    factory.get_branch_data = function(data){
        var promise = $http({
            url:'./FUNCTIONS/Admin/get_branch_data.php', 
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            transformRequest: function(obj) {
                var str = [];
                for(var p in obj)
                str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                return str.join("&");
            },
            data : data
        }) 

        return promise;
    };

    factory.edit_customer = function(data){
        var promise = $http({
            url:'./FUNCTIONS/Admin/edit_customer.php', 
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            transformRequest: function(obj) {
                var str = [];
                for(var p in obj)
                str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                return str.join("&");
            },
            data : data
        }) 

        return promise;
    };

    factory.get_customer_data = function(data){
        var promise = $http({
            url:'./FUNCTIONS/Admin/get_customer_data.php', 
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            transformRequest: function(obj) {
                var str = [];
                for(var p in obj)
                str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                return str.join("&");
            },
            data : data
        }) 

        return promise;
    };

    factory.delete_customer = function(data){
        var promise = $http({
            url:'./FUNCTIONS/Admin/delete_customer.php', 
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            transformRequest: function(obj) {
                var str = [];
                for(var p in obj)
                str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                return str.join("&");
            },
            data : data
        }) 

        return promise;
    };

    factory.get_product_data_search = function(data){
        var promise = $http({
            url:'./FUNCTIONS/Users/get_product_data_search.php', 
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            transformRequest: function(obj) {
                var str = [];
                for(var p in obj)
                str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                return str.join("&");
            },
            data : data
        }) 

        return promise;
    };

    factory.get_history_logs = function(data){
        var promise = $http({
            url:'./FUNCTIONS/Management/get_history_logs.php', 
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            transformRequest: function(obj) {
                var str = [];
                for(var p in obj)
                str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                return str.join("&");
            },
            data : data
        }) 

        return promise;
    };

    factory.get_accounts_logs = function(data){
        var promise = $http({
            url:'./FUNCTIONS/Management/get_accounts_logs.php', 
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            transformRequest: function(obj) {
                var str = [];
                for(var p in obj)
                str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                return str.join("&");
            },
            data : data
        }) 

        return promise;
    };

    factory.get_check_bar_code_item = function(data){
        var promise = $http({
            url:'./FUNCTIONS/Product/get_check_bar_code_item.php', 
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            transformRequest: function(obj) {
                var str = [];
                for(var p in obj)
                str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                return str.join("&");
            },
            data : data
        }) 

        return promise;
    };

    factory.get_po_data_search = function(data){
        var promise = $http({
            url:'./FUNCTIONS/Users/get_po_data_search.php', 
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            transformRequest: function(obj) {
                var str = [];
                for(var p in obj)
                str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                return str.join("&");
            },
            data : data
        }) 

        return promise;
    };

    factory.get_product_data_search_expire = function(data){
        var promise = $http({
            url:'./FUNCTIONS/Product/get_product_data_search_expire.php', 
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            transformRequest: function(obj) {
                var str = [];
                for(var p in obj)
                str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                return str.join("&");
            },
            data : data
        }) 

        return promise;
    };

    factory.get_product_data_checker = function(data){
        var promise = $http({
            url:'./FUNCTIONS/Product/get_product_data_checker.php', 
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            transformRequest: function(obj) {
                var str = [];
                for(var p in obj)
                str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                return str.join("&");
            },
            data : data
        }) 

        return promise;
    };

    factory.get_product_data_expire = function(data){
        var promise = $http({
            url:'./FUNCTIONS/Product/get_product_data_expire.php', 
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            transformRequest: function(obj) {
                var str = [];
                for(var p in obj)
                str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                return str.join("&");
            },
            data : data
        }) 

        return promise;
    };

    factory.get_data_or = function(data){
        var promise = $http({
            url:'./FUNCTIONS/Product/get_data_or.php', 
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            transformRequest: function(obj) {
                var str = [];
                for(var p in obj)
                str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                return str.join("&");
            },
            data : data
        }) 

        return promise;
    };

    factory.get_product_data_or = function(data){
        var promise = $http({
            url:'./FUNCTIONS/Product/get_product_data_or.php', 
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            transformRequest: function(obj) {
                var str = [];
                for(var p in obj)
                str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                return str.join("&");
            },
            data : data
        }) 

        return promise;
    };

    factory.get_check_item = function(data){
        var promise = $http({
            url:'./FUNCTIONS/Product/get_check_item.php', 
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            transformRequest: function(obj) {
                var str = [];
                for(var p in obj)
                str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                return str.join("&");
            },
            data : data
        }) 

        return promise;
    };

    factory.get_supplier_data_search = function(data){
        var promise = $http({
            url:'./FUNCTIONS/Users/get_supplier_data_search.php', 
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            transformRequest: function(obj) {
                var str = [];
                for(var p in obj)
                str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                return str.join("&");
            },
            data : data
        }) 

        return promise;
    };

    factory.get_rule_data = function(data){
        var promise = $http({
            url:'./FUNCTIONS/Users/get_rule_data.php', 
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            transformRequest: function(obj) {
                var str = [];
                for(var p in obj)
                str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                return str.join("&");
            },
            data : data
        }) 

        return promise;
    };

    factory.upload_picture = function(data){
        var promise = $http({
            url:'./FUNCTIONS/Users/upload_picture.php', 
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            transformRequest: function(obj) {
                var str = [];
                for(var p in obj)
                str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                return str.join("&");
            },
            data : data
        }) 
 
        return promise;
    };

    factory.add_rule = function(data){
        var promise = $http({
            url:'./FUNCTIONS/Users/add_rule.php', 
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            transformRequest: function(obj) {
                var str = [];
                for(var p in obj)
                str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                return str.join("&");
            },
            data : data
        }) 

        return promise;
    };

    factory.delete_rule = function(data){
        var promise = $http({
            url:'./FUNCTIONS/Users/delete_rule.php', 
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            transformRequest: function(obj) {
                var str = [];
                for(var p in obj)
                str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                return str.join("&");
            },
            data : data
        }) 

        return promise;
    };

    factory.edit_rule_data = function(data){
        var promise = $http({
            url:'./FUNCTIONS/Users/edit_rule_data.php', 
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            transformRequest: function(obj) {
                var str = [];
                for(var p in obj)
                str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                return str.join("&");
            },
            data : data
        }) 

        return promise;
    };


    factory.add_product = function(data){
        var promise = $http({
            url:'./FUNCTIONS/Product/add_product.php', 
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            transformRequest: function(obj) {
                var str = [];
                for(var p in obj)
                str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                return str.join("&");
            },
            data : data
        }) 

        return promise;
    };

    factory.send_remarks = function(data){
        var promise = $http({
            url:'./FUNCTIONS/Product/send_remarks.php', 
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            transformRequest: function(obj) {
                var str = [];
                for(var p in obj)
                str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                return str.join("&");
            },
            data : data
        }) 

        return promise;
    };

    factory.add_user = function(data){
        var promise = $http({
            url:'./FUNCTIONS/Users/add_user.php', 
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            transformRequest: function(obj) {
                var str = [];
                for(var p in obj)
                str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                return str.join("&");
            },
            data : data
        }) 

        return promise;
    };

    factory.edit_user = function(data){
        var promise = $http({
            url:'./FUNCTIONS/Users/edit_user.php', 
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            transformRequest: function(obj) {
                var str = [];
                for(var p in obj)
                str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                return str.join("&");
            },
            data : data
        }) 

        return promise;
    };


    factory.delete_user = function(data){
        var promise = $http({
            url:'./FUNCTIONS/Users/delete_user.php', 
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            transformRequest: function(obj) {
                var str = [];
                for(var p in obj)
                str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                return str.join("&");
            },
            data : data
        }) 

        return promise;
    };

    factory.get_added_user_data = function(data){
        var promise = $http({
            url:'./FUNCTIONS/Users/get_added_user_data.php', 
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            transformRequest: function(obj) {
                var str = [];
                for(var p in obj)
                str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                return str.join("&");
            },
            data : data
        }) 

        return promise;
    };

    factory.submit_toemail = function(data){
        var promise = $http({
            url:'./FUNCTIONS/Product/submit_toemail.php', 
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            transformRequest: function(obj) {
                var str = [];
                for(var p in obj)
                str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                return str.join("&");
            },
            data : data
        }) 

        return promise;
    };

    factory.update_stocks = function(data){
        var promise = $http({
            url:'./FUNCTIONS/Product/update_stocks.php', 
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            transformRequest: function(obj) {
                var str = [];
                for(var p in obj)
                str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                return str.join("&");
            },
            data : data
        }) 

        return promise;
    };

    factory.gift_certificate_data = function(data){
        var promise = $http({
            url:'./FUNCTIONS/Product/gift_certificate_data.php', 
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            transformRequest: function(obj) {
                var str = [];
                for(var p in obj)
                str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                return str.join("&");
            },
            data : data
        }) 

        return promise;
    };

    factory.add_supplier = function(data){
        var promise = $http({
            url:'./FUNCTIONS/Product/add_supplier.php', 
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            transformRequest: function(obj) {
                var str = [];
                for(var p in obj)
                str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                return str.join("&");
            },
            data : data
        }) 

        return promise;
    };

    factory.edit_product_data = function(data){
        var promise = $http({
            url:'./FUNCTIONS/Product/edit_product_data.php', 
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            transformRequest: function(obj) {
                var str = [];
                for(var p in obj)
                str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                return str.join("&");
            },
            data : data
        }) 

        return promise;
    };

    factory.edit_product_data_bc = function(data){
        var promise = $http({
            url:'./FUNCTIONS/Product/edit_product_data_bc.php', 
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            transformRequest: function(obj) {
                var str = [];
                for(var p in obj)
                str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                return str.join("&");
            },
            data : data
        }) 

        return promise;
    };

    factory.edit_supplier_data = function(data){
        var promise = $http({
            url:'./FUNCTIONS/Product/edit_supplier_data.php', 
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            transformRequest: function(obj) {
                var str = [];
                for(var p in obj)
                str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                return str.join("&");
            },
            data : data
        }) 

        return promise;
    };

    factory.delete_product_data = function(data){
        var promise = $http({
            url:'./FUNCTIONS/Product/delete_product_data.php', 
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            transformRequest: function(obj) {
                var str = [];
                for(var p in obj)
                str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                return str.join("&");
            },
            data : data
        }) 

        return promise;
    };

    factory.delete_supplier_data = function(data){
        var promise = $http({
            url:'./FUNCTIONS/Product/delete_supplier_data.php', 
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            transformRequest: function(obj) {
                var str = [];
                for(var p in obj)
                str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                return str.join("&");
            },
            data : data
        }) 

        return promise;
    };

    factory.request_product_order = function(data){
        var promise = $http({
            url:'./FUNCTIONS/Product/request_product_order.php', 
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            transformRequest: function(obj) {
                var str = [];
                for(var p in obj)
                str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                return str.join("&");
            },
            data : data
        }) 

        return promise;
    };

    factory.approve_order_request = function(data){
        var promise = $http({
            url:'./FUNCTIONS/Product/approve_order_request.php', 
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            transformRequest: function(obj) {
                var str = [];
                for(var p in obj)
                str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                return str.join("&");
            },
            data : data
        }) 

        return promise;
    };

    factory.disapprove_order_request = function(data){
        var promise = $http({
            url:'./FUNCTIONS/Product/disapprove_order_request.php', 
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            transformRequest: function(obj) {
                var str = [];
                for(var p in obj)
                str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                return str.join("&");
            },
            data : data
        }) 

        return promise;
    };

    factory.tender_product = function(data){
        var promise = $http({
            url:'./FUNCTIONS/Product/tender_product.php', 
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            transformRequest: function(obj) {
                var str = [];
                for(var p in obj)
                str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                return str.join("&");
            },
            data : data
        }) 

        return promise;
    };

    factory.submit_toemailreceipt = function(data){
        var promise = $http({
            url:'./FUNCTIONS/Product/submit_toemailreceipt.php', 
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            transformRequest: function(obj) {
                var str = [];
                for(var p in obj)
                str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                return str.join("&");
            },
            data : data
        }) 

        return promise;
    };

    factory.get_product_data = function(data){
        var promise = $http({
            url:'./FUNCTIONS/Product/get_product_data.php', 
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            transformRequest: function(obj) {
                var str = [];
                for(var p in obj)
                str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                return str.join("&");
            },
            data : data
        }) 

        return promise;
    };

    factory.get_receiptsback = function(data){
        var promise = $http({
            url:'./FUNCTIONS/Product/get_receiptsback.php', 
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            transformRequest: function(obj) {
                var str = [];
                for(var p in obj)
                str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                return str.join("&");
            },
            data : data
        }) 

        return promise;
    };

    factory.get_best_selling = function(data){
        var promise = $http({
            url:'./FUNCTIONS/Product/get_best_selling.php', 
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            transformRequest: function(obj) {
                var str = [];
                for(var p in obj)
                str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                return str.join("&");
            },
            data : data
        }) 

        return promise;
    };

    factory.get_receipts = function(data){
        var promise = $http({
            url:'./FUNCTIONS/Product/get_receipts.php', 
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            transformRequest: function(obj) {
                var str = [];
                for(var p in obj)
                str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                return str.join("&");
            },
            data : data
        }) 

        return promise;
    };

    factory.get_reports = function(data){
        var promise = $http({
            url:'./FUNCTIONS/Product/get_reports.php', 
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            transformRequest: function(obj) {
                var str = [];
                for(var p in obj)
                str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                return str.join("&");
            },
            data : data
        }) 

        return promise;
    };

    factory.get_request_order_data = function(data){
        var promise = $http({
            url:'./FUNCTIONS/Product/get_request_order_data.php', 
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            transformRequest: function(obj) {
                var str = [];
                for(var p in obj)
                str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                return str.join("&");
            },
            data : data
        }) 

        return promise;
    };

    factory.get_all_products = function(data){
        var promise = $http({
            url:'./FUNCTIONS/Product/get_all_products.php', 
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            transformRequest: function(obj) {
                var str = [];
                for(var p in obj)
                str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                return str.join("&");
            },
            data : data
        }) 

        return promise;
    };

    factory.get_supplier_data = function(data){
        var promise = $http({
            url:'./FUNCTIONS/Product/get_supplier_data.php', 
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            transformRequest: function(obj) {
                var str = [];
                for(var p in obj)
                str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                return str.join("&");
            },
            data : data
        }) 

        return promise;
    };


    return factory;
})
