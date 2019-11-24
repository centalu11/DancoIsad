app.factory('UserFactory', function($http, $location){
    var factory = {};

    factory.forgot_password = function(data){
        var promise = $http({
            url:'./FUNCTIONS/Users/forgot_password.php', 
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
    }
    
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
    
    factory.edit_payment = function(data){
        var promise = $http({
            url:'./FUNCTIONS/Users/edit_payment.php', 
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
     factory.delete_payment = function(data){
        var promise = $http({
            url:'./FUNCTIONS/Users/delete_payment.php', 
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

    factory.add_payment = function(data){
        var promise = $http({
            url:'./FUNCTIONS/Users/add_payment.php', 
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

    factory.get_payment_data = function(data){
        var promise = $http({
            url:'./FUNCTIONS/Users/get_payment_data.php', 
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

    factory.send_email_sender = function(data){
        var promise = $http({
            url:'./FUNCTIONS/Users/send_email_sender.php', 
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

    factory.get_all_emails = function(data){
        var promise = $http({
            url:'./FUNCTIONS/Users/get_all_emails.php', 
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

    factory.update_my_password = function(data){
        var promise = $http({
            url:'./FUNCTIONS/Users/update_my_password.php', 
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

    factory.get_cashier = function(data){
        var promise = $http({
            url:'./FUNCTIONS/Users/get_cashier.php', 
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

    factory.get_uploaded_picture = function(data){
        var promise = $http({
            url:'./FUNCTIONS/Users/get_uploaded_picture.php', 
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
