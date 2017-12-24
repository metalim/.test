pipez = require 'pipez'
_trace = require 'ololog'
#_trace1 = _trace.configure locate:shift:1

expect = pipez
	select: ([ex,v], p)->
		if p.nth?
			v=v[p.nth]
		[ex,v]

	compare: ([ex,v], p)->
		ok = if p.equal
			JSON.stringify(ex) is JSON.stringify v
		else
			ex is v
		[ex,v,ok]

	report: ([ex,v,ok], p)->
		unless ok
			_trace.cyan '• expected', ex
			_trace.red  '•   actual', v
		ok

	throw: (ok, p)->
		unless ok
			throw new Error 'unexpected'
		return

get = ( fn )->
	enumerable: yes
	configurable: yes
	get: fn

expect.methods Object.defineProperties {},
	equal: get -> @configure compare:equal:yes
	noThrow: get -> @configure throw:no

expect.methods
	nth: (k)-> @configure select:nth:k

module.exports = expect
