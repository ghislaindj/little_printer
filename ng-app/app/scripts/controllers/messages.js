'use strict';

/**
 * @ngdoc function
 * @name littlePrinterApp.controller:MessagesCtrl
 * @description
 * # MessagesCtrl
 * Controller of the littlePrinterApp
 */
angular.module('littlePrinterApp')
  .controller('MessagesCtrl', function ($scope, Restangular) {
    var baseMessages = Restangular.all('messages');
    baseMessages.getList().then(function(messages) {
      $scope.messages = messages;
    });
  });
