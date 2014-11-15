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
        }).when('/tasks/manage/:taskID?',{
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


app.factory('TaskService', ['$http',function($http) {
    return {
        get: function(taskID) {
            return $http.get((taskID > 0) ? "/task/" + taskID : "/tasks");
        },
        create: function(task) {
            return $http.post("/task", task);
        },
        update: function(task) {
            return $http.put("/task",task);
        },
        deleteTask: function(taskID) {
            return $http.delete("/task/" + taskID);
        }
    };
}]);

app.controller('DashboardCtrl', ['$scope', '$http', function($scope, $http) {
    $http.get('/user').success(function(data){
        $scope.user = data.data.user;
        console.log(data);
    });
}]);


app.controller('TasksManageCtrl', ['$scope', '$location','$routeParams', 'TaskService', function($scope,$location,$routeParams,TaskService) {
    var taskID  = $routeParams.taskID;

    if(taskID)
        TaskService.get(taskID).success(function(response) {
            $scope.task = response.data.task;
        });

    $scope.save = function(task) {
        if (taskID > 0)
            TaskService.update(task).success(function(response){
                $location.path("/tasks");
            });
        else
            TaskService.create(task).success(function(response){
                $location.path("/tasks");
            });
    };
}]);

app.controller('TasksCtrl', ['$scope','TaskService','$route', function($scope,TaskService,$route) {
    TaskService.get(null).success(function(response) {
        $scope.tasks = response.data.tasks;
    });

    $scope.delete = function(taskID) {
        TaskService.deleteTask(taskID).success(function(response) {
            $route.reload();
        });
    };
}]);