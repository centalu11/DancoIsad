var app = angular.module('onload', [
								'ngRoute',
								'ngCookies',
								'angular-md5',
								'ngDialog',
								'angularFileUpload',
								'ui-notification',
								'ui.bootstrap',
								'ae-datetimepicker',
								'angucomplete-alt',
								'angular-loading-bar'
								]);


app.config(function($routeProvider) {             
	$routeProvider
	.when('/',             
	{                 
		controller: 'Product',
		templateUrl: 'TEMPLATE/HOME/sales.html'                
	})
	.when('/CustPayment',             
	{                 
		controller: 'Custpayment',
		templateUrl: 'TEMPLATE/HOME/customerpayment.html'             
	})
	.when('/Payment',             
	{                 
		controller: 'Custpayment',
		templateUrl: 'TEMPLATE/HOME/payment.html'             
	})
	.when('/Salesanalytics',             
	{                 
		controller: 'Sales',
		templateUrl: 'TEMPLATE/HOME/salesanalytics.html'             
	})
	.when('/Exchange',             
	{                 
		controller: 'Admin',
		templateUrl: 'TEMPLATE/HOME/refund.html'             
	})
	.when('/AddBranches',             
	{                 
		controller: 'Admin',
		templateUrl: 'TEMPLATE/HOME/addbranches.html'             
	})
	.when('/Wealth',             
	{                 
		templateUrl: 'TEMPLATE/HOME/wealth.html'             
	})    
	.when('/Storage',             
	{                 
		controller: 'Storage',
		templateUrl: 'TEMPLATE/HOME/storage.html'             
	})  
	.when('/Unicorn',             
	{                 
		templateUrl: 'TEMPLATE/HOME/unicorn.html'             
	})
	.when('/Sales',             
	{                 
		controller: 'Product',
		templateUrl: 'TEMPLATE/HOME/sales.html'             
	})
	.when('/Discount',             
	{                 
		controller: 'Discount',
		templateUrl: 'TEMPLATE/HOME/aomosdiscount.html'             
	})
	.when('/AddCustomer',             
	{                 
		controller: 'AddCustomer',
		templateUrl: 'TEMPLATE/HOME/addcustomer.html'             
	})
	.when('/Activity',             
	{                 
		controller: 'Activity',
		templateUrl: 'TEMPLATE/HOME/activitylog.html'             
	})
	.when('/History',             
	{                 
		controller: 'History',
		templateUrl: 'TEMPLATE/HOME/historylog.html'             
	})
	.when('/EditInvent',             
	{                 
		controller: 'Product',
		templateUrl: 'TEMPLATE/HOME/edit_inventory.html'             
	})
	.when('/ProductExprd',             
	{                 
		controller: 'Product',
		templateUrl: 'TEMPLATE/HOME/productexpiration.html'             
	})
	.when('/PriceList',             
	{                 
		controller: 'Product',
		templateUrl: 'TEMPLATE/HOME/pricelist.html'             
	})
	.when('/User',             
	{                 
		controller: 'Product',
		templateUrl: 'TEMPLATE/HOME/usermanagement.html'             
	})
	.when('/PO',             
	{                 
		controller: 'Product',
		templateUrl: 'TEMPLATE/HOME/purchase_order.html'             
	})
	.when('/Supplier',             
	{                 
		controller: 'Product',
		templateUrl: 'TEMPLATE/HOME/supplier.html'             
	})
	.when('/Admin',             
	{                 
		controller: 'Product',
		templateUrl: 'TEMPLATE/HOME/admin.html'             
	})
	.when('/Barcode',             
	{                 
		controller: 'Admin',
		templateUrl: 'TEMPLATE/HOME/barcode_check.html'             
	})
	.when('/Rules',              
	{                 
		controller: 'Product',
		templateUrl: 'TEMPLATE/HOME/rules.html'             
	})
	.when('/Report',             
	{                 
		controller: 'Reports',
		templateUrl: 'TEMPLATE/HOME/report.html'             
	})
	.when('/BestSelling',             
	{                 
		controller: 'Reports',
		templateUrl: 'TEMPLATE/HOME/bestselling.html'             
	})
	.when('/ReceiptBackup',             
	{                 
		controller: 'Reports',
		templateUrl: 'TEMPLATE/HOME/receiptbackup.html'             
	})
	.when('/ORList',             
	{                 
		controller: 'Reports',
		templateUrl: 'TEMPLATE/HOME/orlist.html'             
	})
	.when('/AskHelp',             
	{                 
		controller: 'EmailAndText',
		templateUrl: 'TEMPLATE/HOME/eblast.html'             
	})
	.when('/bucket/pictures',             
	{                 
		controller: 'BucketController',
		templateUrl: 'TEMPLATE/BUCKET/pictures.html'             
	})
	.when('/NFAdmin',             
	{                 
		controller: 'Newsfeed',
		templateUrl: 'TEMPLATE/HOME/newsfeedadmin.html'             
	})                              
	.otherwise({ redirectTo:'/'});         
}); 
