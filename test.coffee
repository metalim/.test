_trace = require 'ololog'
_log = _trace.noLocate
ansi = require 'ansicolor'
StackTracey = require 'stacktracey'
StackTracey.isThirdParty.include (x)-> x in ['module.js', 'bootstrap_node.js' ]

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
# testAndRun ->
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
			_log "• test #{cur}/#{total}:", k
			fn()
			++ok
			_log.green '✓ passed'
		catch e
			_log.red ' ', if e instanceof Error
				e.message+'\n'+new StackTracey(e).clean.pretty.split('\n')[0].replace /\s\s+/g, '  '
			else e
			++failed
			_log.red '✗ failed:', k
	msg = ["Tests: #{total}"]
	msg.push ansi.green "✓ passed: #{ok}" if ok
	msg.push ansi.red "✗ failed: #{failed}" if failed
	_log.yellow msg.join ', '
	return

#
# testAndRun ->  # note there's no '='
#   some_code_here() # this is executed after all tests have completed
#
exports.testAndRun = testAndRun = ( fn )->
	try
		test()
		fn()
	catch e
		_trace.red.error e
	return
