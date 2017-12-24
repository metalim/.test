#!/usr/bin/env coffee
{test,expect,main} = require './test'

f = (i)->
	[5,11,[1,22]][i]

test.hello = ->
	expect 11, f 1
	expect.nth(1) 22, f 2
	return

test.world = ->
	expect.equal [1,22], f 2
	return

console.log 'before tests.'

main ->
	console.log 'ho-ho-ho!'
	return
