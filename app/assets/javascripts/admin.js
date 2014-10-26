//= require angular
//= require angular-route

/*jslint browser: true*/ /*global  angular, $scope, $http */

var moduleUrl = '/assets/';

var app = angular.module('admin_panel', ['ngRoute'])
    .config(function ($routeProvider){
        $routeProvider
        .when('/', {
            redirectTo: '/dashboard',
        })
        .when('/dashboard', {
            templateUrl: moduleUrl + '/templates/dashboard.html',
            controller: 'DashboardCtrl'
        })
        .otherwise({
            redirectTo: '/'
        });
    })
    .run(function($http, $rootScope, $window) {
        $http.defaults.headers.common['Accept'] = 'application/json';
        $http.defaults.headers.common['Content-Type'] = 'application/json';
        $rootScope.logout = function(){
            $http.delete('/users/sign_out').success(function(){
                $window.location = $window.siteUrl;
            });
        };
    });

app.controller('DashboardCtrl', function($scope, $http) {
    $http.get('/user').success(function(data){
        $scope.user = data.data.user;
    });
});
