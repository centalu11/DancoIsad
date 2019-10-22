app.controller('EmailAndText', function(
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
    $scope.externalContacts = [];
    $scope.allPeopleList = [];
    $scope.form = {};
    $scope.count1 = 10000;
    $scope.pk = null;
    init();

    function init(){
        cfpLoadingBar.start();
        var promise = SessionFactory.getsession();
        promise.then(function(data){
            var _id = md5.createHash('pk');
            $scope.pk = data.data[_id];
            get_user();
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
            get_all_emails();

        })
        .then(null, function(data){

        });
    }

    function get_all_emails (){
        var promise = UserFactory.get_all_emails();
        promise.then(function(data){
            var a = data.data.result;
            var z = 0;
            for (var i in a){
                z += 1;
                $scope.allPeopleList.push({
                    name: a[i].email,
                    id: z
                });
            }
        })
    }

    $scope.searchPeople = function(term) {
        $scope.$watch('externalContacts', function(newVal) {
            for(var z in $scope.externalContacts){
                $scope.count1 += 1;
                if ($scope.externalContacts[z].id == undefined || $scope.externalContacts[z].id == null) {
                    $scope.externalContacts[z].id = $scope.count1;
                };
            }
        }, true);
        // console.log($scope.externalContacts);
        var search_term = term.toUpperCase();
        $scope.people = [];

        angular.forEach($scope.allPeopleList, function(item) {
            if (item.name.toUpperCase().indexOf(search_term) >= 0){
                $scope.people.push(item);
            }
        });

        return $scope.people;
    };

    $scope.send_email_sender = function(){
        cfpLoadingBar.start();
        var data = {
            datas : JSON.stringify($scope.externalContacts),
            message : $scope.form.message,
            subject_line :  $scope.form.subject_line
        }
        var notify = $.notify('Please wait sending email', { 'type': 'warning', allow_dismiss: true });
        var promise = UserFactory.send_email_sender(data);
        promise.then(function(data){
            var notify = $.notify('Email Sent!', { 'type': 'success', allow_dismiss: true });
            cfpLoadingBar.complete();
        })
        .then(null, function(data){
            var notify = $.notify('Oops there something wrong!', { 'type': 'danger', allow_dismiss: true });
            cfpLoadingBar.complete();
        });
    }
});

