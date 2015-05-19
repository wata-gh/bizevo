'use strict';

angular.module('tea', ['ngAnimate', 'ngCookies', 'ngTouch', 'ngSanitize', 'ngResource', 'ui.router', 'mgcrea.ngStrap', 'infinite-scroll'])
  .config(function ($stateProvider, $urlRouterProvider) {
    $stateProvider
      .state('sample', {
        url: '/sample',
        templateUrl: 'app/main/main.html',
        controller: 'MainCtrl',
        title: 'Sample!!',
        description: 'さんぷる'
      })
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
;
