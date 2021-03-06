#!/usr/bin/env coffee
{test,expect,testAndRun} = require './test'

foo = (i)->
  [1,2,[3,4],{5:6,7:[8,9]}][i]

#
# tests are defined by setting properties of the test object.
#

test.basic = ->
  # expect <expected value>, <actual object>
  expect 1, foo 0
  expect 2, foo 1
  return

test.fancy = ->

  # compare content of the objects
  expect.equal [3,4], foo 2

  # ignore order of properties
  expect.similar {a:1,b:2}, {b:2,a:1}

  # compare i-th cell of an array
  expect.nth(1) 4, foo 2

  # or property of an object
  expect.nth('5') 6, foo 3

  # can be chained
  expect.nth('7').equal [8,9], foo 3


test.expect_throw = ->

  # expect functions to fail
  expect.error -> throw new Error


test.report_without_throw = ->
  # and used to print without failing a test
  expect.noThrow 'this was expected', 'but we got this'


test.demo_throw = ->

  # add message to Error thrown
  expect 1, 2, "This message is thrown"


console.log 'before tests'

#
# call testAndRun to run all tests, and then continue with provided function
#
testAndRun -> # note there's no '='
  console.log 'after tests'
  return
