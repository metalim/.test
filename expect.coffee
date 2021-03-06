pipez = require 'pipez'
_trace = require 'ololog'
_trace2 = _trace.configure locate:shift:2

expect = pipez
	exec: (ar, p)->
		if p.error
			[f,msg]=ar
			if typeof f isnt 'function'
				[(->),f,'not a function']
			else
				try
					f()
					['should throw','missed exception',msg]
				catch e
					[1,1,msg]
		else
			ar

	select: ([ex,v,msg], p)->
		if p.nth?
			v=v[p.nth]
		[ex,v,msg]

	compare: ([ex,v,msg], p)->
		ok = switch
			when p.similar
				do ->
					return no if Object.keys(ex).length isnt Object.keys(v).length
					for k,ev of ex when ev isnt v[k]
						return no
					yes
			when p.equal
				JSON.stringify(ex) is JSON.stringify v
			else
				ex is v
		[ex,v,ok,msg]

	report: ([ex,v,ok,msg], p)->
		unless ok
			_trace2.cyan '⇒ expected:', ex
			_trace2.red  '⇐   actual:', v
		[ok,msg]

	throw: ([ok,msg], p)->
		unless ok
			throw new Error msg ? 'unexpected'
		return

get = ( fn )->
	enumerable: yes
	configurable: yes
	get: fn

expect.methods Object.defineProperties {},
	equal: get -> @configure compare:equal:yes
	similar: get -> @configure compare:similar:yes
	error: get -> @configure exec:error:yes
	noThrow: get -> @before 'throw'

	#deprecated
	exception: get -> @configure exec:exception:yes
	soft: get -> @before 'throw'

expect.methods
	nth: (k)-> @configure select:nth:k

module.exports = expect
