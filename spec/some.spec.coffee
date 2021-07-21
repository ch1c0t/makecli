{ exec } = require 'child_process'

sh = (command) ->
  new Promise (resolve) ->
    exec command, (error, stdout, stderr) ->
      resolve { error, stdout, stderr }

describe 'Zero', ->
  it 'works', ->
    expect(0).toEqual 0

  it 'works 2', ->
    response = await sh 'ls spec'

    expect(response.stdout).toContain 'support'
