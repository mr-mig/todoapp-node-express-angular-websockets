pattern = /(\d+)*([dwmy])?.*?(\d+)*$/
MS_IN_DAY = 1000 * 60 * 60 * 24

inputParser = {
	parse: (input)->
		#tomorrow = (new Date).setDate(new Date().getDate() + 1)
		result =
			title : input
			date: (new Date).getTime()
			priority: 0

		tokens = input.split('  ').filter((it)-> it isnt '  ')
		if tokens.length > 1
			result.title = tokens.shift()
			opts = tokens.join ''
			match = opts.match pattern

			if match?.length > 0
				while match.length < 4
					match.push null
				[nothing, date, mod, prior] = match

				if !mod and !prior
					# this case stands for empty date+mod pattern
					prior = date || 0

				result.priority = Math.min(parseInt(prior), 10) if prior > 0
				result.priority = Math.max(0, parseInt(prior)) if prior < 0

				todoDate = new Date(result.date)

				switch mod
					when 'd' then todoDate.setDate(todoDate.getDate() + parseInt(date))
					when 'w' then todoDate.setDate(todoDate.getDate() + 7 * parseInt(date))
					when 'm' then todoDate.setMonth(todoDate.getMonth() + parseInt(date))
					when 'y' then todoDate.setYear(todoDate.getFullYear() + parseInt(date))

				result.date = todoDate.getTime()

		result

	decompose: (todo)->
		days = Math.round((todo.date - (new Date).getTime()) / MS_IN_DAY)
		mod = 'd'
		if days > 0 and days % 7 is 0 and days < 31
			mod = 'w'
			days = days / 7

		date = days + mod
		todo.title + '  ' + date + ' ' + todo.priority
}

if module?.exports?
	module.exports = inputParser
else
	angular.module('app').service('inputParser', ->
		inputParser
	)