_log = require('ololog').noLocate
ansi = require 'ansicolor'

exports.expect = require './expect'

#
# test.any_name = ->
#   expect 1, some_func()
#
# test.some_other_name = ->
#   expect.equal [1,2], some_array
#   expect.nth(0) 1, [1,2]
#
# # don't have to call test() manually
#
# main ->
#   # executed after all test passed
#
exports.test = test = ->
	failed = 0
	ok = 0
	total = Object.keys(test).length
	cur = 0
	for k, fn of test
		++cur
		try
			fn()
			++ok
			_log "• test #{cur}/#{total}:", ansi.green k
		catch e
			_log.red e.message
			++failed
			_log "• test #{cur}/#{total}:", ansi.red "#{k} failed"
	return

#
# main ->  # note there's no '='
#   some_code_here() # this is executed after all tests have completed
#
exports.main = main = ( fn )->
	try
		test()
		fn()
	catch e
		_log.red.error e
	return
