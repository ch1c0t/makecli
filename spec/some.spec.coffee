{ exec } = require 'child_process'

sh = (command) ->
  new Promise (resolve) ->
    exec command, (error, stdout, stderr) ->
      resolve { error, stdout, stderr }

describe 'Zero', ->
  it 'prints the help', ->
    response = await sh './bin/makecli'

    expect(response.stdout).toContain 'A CLI to make CLIs'
