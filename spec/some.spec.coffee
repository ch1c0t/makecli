{ sh } = require '@ch1c0t/sh'

describe 'Zero', ->
  it 'prints the help', ->
    response = await sh './bin/makecli'

    expect(response.stdout).toContain 'A CLI to make CLIs'
