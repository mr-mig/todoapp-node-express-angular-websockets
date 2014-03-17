angular.module('app').directive('controls',()->
	restrict : 'E'
	templateUrl : 'tpls/directives/controls',
	link : (scope, element, attrs)->
		scope.focusInput = ()->
			element.find('input')[0].focus()
		this
).directive('edit', (inputParser)->
	restrict : 'E'
	templateUrl : 'tpls/directives/edit-input'
	link : (scope, element, attrs) ->
		scope.decompose = inputParser.decompose

		scope.input = scope.decompose(scope.todo)
		element.find('input')[0].focus()

)