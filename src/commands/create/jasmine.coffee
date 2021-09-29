{ sh } = require '@ch1c0t/sh'

CreateJasmineSetup = ({ name, directory }) ->
  await IO.mkdir directory
  await sh "cp -r #{ROOT}/spec/support #{directory}/support"
  await CreateSomeSpec { name, directory }

CreateSomeSpec = ({ name, directory }) ->
  source = """
    { sh } = require '@ch1c0t/sh'

    describe 'help', ->
      it 'prints the help', ->
        response = await sh './bin/#{name}'
        expect(response.stdout).toContain 'A CLI to make CLIs'
  """

  await IO.mkdir "#{directory}/cli"
  IO.write "#{directory}/cli/help.spec.coffee", source

module.exports = { CreateJasmineSetup }
