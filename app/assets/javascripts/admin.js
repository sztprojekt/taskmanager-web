//= require angular
//= require angular-route

/*jslint browser: true*/ /*global  angular, $scope, $http */

var moduleUrl = '/assets/';

var app = angular.module('admin_panel', ['ngRoute'])
    .config(['$routeProvider', function ($routeProvider){
        $routeProvider
        .when('/', {
            redirectTo: '/dashboard'
        })
        .when('/dashboard', {
            templateUrl: moduleUrl + '/templates/dashboard.html',
            controller: 'DashboardCtrl'
        }).when('/tasks', {
           templateUrl: moduleUrl + '/templates/Tasks.html',
           controller: 'TasksCtrl'
        }).when('/tasks/manage',{
            templateUrl: moduleUrl + '/templates/TasksManage.html',
            controller: 'TasksManageCtrl'
        })
        .otherwise({
            redirectTo: '/'
        });
    }])
    .run(['$http', '$rootScope', '$window', function($http, $rootScope, $window) {
        $http.defaults.headers.common['Accept'] = 'application/json';
        $http.defaults.headers.common['Content-Type'] = 'application/json';
        $rootScope.logout = function(){
            $http.delete('/users/sign_out').success(function(){
                $window.location = $window.siteUrl;
            });
        };
    }]);

app.controller('DashboardCtrl', ['$scope', '$http', function($scope, $http) {
    $http.get('/user').success(function(data){
        $scope.user = data.data.user;
        console.log(data);
    });
}]);

app.controller('TasksManageCtrl', ['$scope', '$http','$location', function($scope, $http,$location) {
    $scope.save = function(task, user) {
        console.log(task);
        $location.path("/tasks");
    };
}]);

app.controller('TasksCtrl', ['$scope', '$http', function($scope, $http) {
    $scope.tasks = [{
        name: "Task1",
        user: "Barnika",
        assigned_at: "Okt 11",
        completed_at: "Okt 22"
    }];
}]);