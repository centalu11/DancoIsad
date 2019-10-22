app.controller('Login', function(
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
                                ){

  $scope.modal = {};
  $scope.forgot_password = function(){
    $scope.modal = {
      title:'Forgot Password',
      message: '',
      save : 'Send',
      close : 'Close'
    };

    ngDialog.openConfirm({
      template: 'forgot_password',
      className: 'ngdialog-theme-plain dialogwidth300',
      scope: $scope,
      showClose: false
    })
    .then(function(value){
      return false;
    },function(value){
        var promise = UserFactory.check_email($scope.modal);
        promise.then(function(data){
          var datas = {};
          datas.result = data.data.result[0];
          datas.status = true;
          datas.random_string = data.data.random_string;
          $scope.checkresult(datas); 
        })
        .then(null, function(data){
          var datas = {};
          datas.status = false;
          $scope.checkresult(datas); 
        });
    });
  }

  $scope.checkresult = function(datas){
  // console.log(datas);
  // return false;
   if (datas.status == true) {
      $scope.modal = {
        title:'Verify User',
        message: '',
        save : 'Verify',
        close : 'Close',
        status : datas.status,
        pk : datas.result.pk,
        user_id : datas.result.user_id,
        email : datas.result.email
      };
   }else{
      $scope.modal = {
        title:'Verify User',
        message: '',
        save : 'Verify',
        close : 'Close',
        status : datas.status
      };
   }
   

    ngDialog.openConfirm({
      template: 'checkresult',
      className: 'ngdialog-theme-plain dialogwidth400',
      preCloseCallback: function(value) {
            var nestedConfirmDialog;
            if ($scope.modal.code == undefined || $scope.modal.code == null || $scope.modal.code == '') {
              nestedConfirmDialog = ngDialog.openConfirm({
                  template:
                  '<p></p>' +
                  '<p>The code field is required!</p>' +
                  '<div class="ngdialog-buttons">' +
                  '<button type="button" class="ngdialog-button ngdialog-button-secondary" data-ng-click="closeThisDialog(0)">Ok' +
                  '</button></div>',
                  plain: true,
                  className: 'ngdialog-theme-plain custom-width'
              });
            }else if($scope.modal.code != datas.random_string){
               nestedConfirmDialog = ngDialog.openConfirm({
                  template:
                  '<p></p>' +
                  '<p>You inputted an wrong code please check and try again.</p>' +
                  '<div class="ngdialog-buttons">' +
                  '<button type="button" class="ngdialog-button ngdialog-button-secondary" data-ng-click="closeThisDialog(0)">Ok' +
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
    },function(value){
        var promise = UserFactory.new_password($scope.modal);
        promise.then(function(data){
          ngDialog.openConfirm({
              template:
              '<p></p>' +
              '<p>You have successfully verified your identity, A new Password has been sent to your email.</p>' +
              '<div class="ngdialog-buttons">' +
              '<button type="button" class="ngdialog-button ngdialog-button-secondary" data-ng-click="closeThisDialog(0)">Ok' +
              '</button></div>',
              plain: true,
              className: 'ngdialog-theme-plain custom-width'
          });
        })
        .then(null, function(data){
          ngDialog.openConfirm({
              template:
              '<p></p>' +
              '<p>An Error occured, please try again.</p>' +
              '<div class="ngdialog-buttons">' +
              '<button type="button" class="ngdialog-button ngdialog-button-secondary" data-ng-click="closeThisDialog(0)">Ok' +
              '</button></div>',
              plain: true,
              className: 'ngdialog-theme-plain custom-width'
          });
        });
    });
  }
});
