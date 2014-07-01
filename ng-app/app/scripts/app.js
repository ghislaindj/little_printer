'use strict';

/**
 * @ngdoc overview
 * @name littlePrinterApp
 * @description
 * # littlePrinterApp
 *
 * Main module of the application.
 */
angular
  .module('littlePrinterApp', [
    'ngAnimate',
    'ngCookies',
    'ngResource',
    'ngRoute',
    'ngSanitize',
    'ngTouch',
    'restangular'
  ])
  .config(function ($routeProvider) {
    $routeProvider
      .when('/', {
        templateUrl: 'views/messages.html',
        controller: 'MessagesCtrl'
      })
      .otherwise({
        redirectTo: '/'
      });
  })
  .config(function(RestangularProvider) {
    RestangularProvider.setBaseUrl('/api');
    RestangularProvider.setRequestSuffix('.json');
  });
