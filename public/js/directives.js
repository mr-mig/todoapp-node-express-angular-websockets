// Generated by CoffeeScript 2.0.0-beta7
angular.module('app').directive('controls', function () {
  return {
    restrict: 'E',
    templateUrl: 'tpls/directives/controls',
    link: function (scope, element, attrs) {
      scope.focusInput = function () {
        return element.find('input')[0].focus();
      };
      return this;
    }
  };
}).directive('edit', function (inputParser) {
  return {
    restrict: 'E',
    templateUrl: 'tpls/directives/edit-input',
    link: function (scope, element, attrs) {
      scope.decompose = inputParser.decompose;
      scope.input = scope.decompose(scope.todo);
      return element.find('input')[0].focus();
    }
  };
});

//# sourceMappingURL=directives.js.map
