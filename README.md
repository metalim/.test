# .test
## Installation
```
yarn add metalim/.test
```
## Getting Started
[example.coffee](https://github.com/metalim/.test/blob/master/example.coffee)
```coffeescript
#!/usr/bin/env coffee
{test,expect,main} = require '-test'

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

  # compare i-th cell of an array
  expect.nth(1) 4, foo 2

  # or property of an object
  expect.nth('5') 6, foo 3

  # can be chained
  expect.nth('7').equal [8,9], foo 3

  # and used to print without failing a test
  expect.noThrow 'this was expected', 'but we got this'

  return

console.log 'before tests'

#
# call main to run all tests, and then continue with provided function
#
main -> # note there's no '='
  console.log 'after tests'
  return
```
