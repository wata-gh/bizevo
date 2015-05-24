'use strict';

angular.module('tea', ['ngAnimate', 'ngCookies', 'ngTouch', 'ngSanitize', 'ngResource', 'ui.router', 'mgcrea.ngStrap', 'infinite-scroll'])
  .config(function ($stateProvider, $urlRouterProvider) {
    $stateProvider
      .state('top', {
        url: '/',
        templateUrl: 'app/top/top.html',
        controller: 'TopCtrl',
        title: 'ようこそ!!'
      })
      .state('info', {
        url: '/info',
        templateUrl: 'app/info/info.html',
        controller: 'InfoCtrl',
        title: 'お知らせ'
      })
      .state('list', {
        url: '/list',
        templateUrl: 'app/list/list.html',
        controller: 'ListCtrl',
        title: '一覧'
      })
      .state('detail', {
        url: '/detail/{id:int}',
        templateUrl: 'app/detail/detail.html',
        controller: 'DetailCtrl',
        title: '詳細'
      })
      ;
    $urlRouterProvider.otherwise('/');
  })
  .config(function($httpProvider) {
    $httpProvider.interceptors.push(function($q, $injector) {
      var loadingService = null;
      var getService = function() {
        if (!loadingService) {
          loadingService = $injector.get('loadingService');
        }
        return loadingService;
      };
      var interceptor =  {
        request: function(config) {
          getService().start();
          return config;
        },
        requestError: function(rejection) {
          getService().end().then(function(){
            return getService().error(rejection.status);
          });
          return $q.reject(rejection);
        },
        response: function(response) {
          getService().end();
          return response;
        },
        responseError: function(rejection) {
          getService().end().then(function(){
            return getService().error(rejection.status);
          });
          return $q.reject(rejection);
        },
      };
      return interceptor;
    });
  });