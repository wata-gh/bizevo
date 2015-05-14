'use strict';

angular.module('tea', ['ngAnimate', 'ngCookies', 'ngTouch', 'ngSanitize', 'ngResource', 'ui.router', 'mgcrea.ngStrap'])
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
      });
    $urlRouterProvider.otherwise('/');
  })
;
