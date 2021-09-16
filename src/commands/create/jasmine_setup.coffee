{ sh } = require '@ch1c0t/sh'

CreateJasmineSetup = ({ name, directory }) ->
  SpecDirectory = "#{directory}/spec"
  await IO.mkdir SpecDirectory
  
  await sh "cp -r #{ROOT}/spec/support #{SpecDirectory}/support"
  await CreateSomeSpec { name, directory: SpecDirectory }

CreateSomeSpec = ({ name, directory }) ->
  source = """
    { sh } = require '@ch1c0t/sh'

    describe 'Some', ->
      it 'prints the help', ->
        response = await sh './bin/#{name}'
        expect(response.stdout).toContain 'A CLI to make CLIs'
  """

  IO.write "#{directory}/some.spec.coffee", source

module.exports = { CreateJasmineSetup }
