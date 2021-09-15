CreateJasmineSetup = ({ name, directory }) ->
  SpecDirectory = "#{directory}/spec"
  await IO.mkdir SpecDirectory
  
  SupportDirectory = "#{SpecDirectory}/support"
  await IO.mkdir SupportDirectory

  await IO.copy "#{ROOT}/spec/support/jasmine.json",
                "#{SupportDirectory}/jasmine.json"

  await IO.copy "#{ROOT}/spec/support/coffee.js",
                "#{SupportDirectory}/coffee.js"

  await CreateSomeSpec { name, directory: SpecDirectory }

CreateSomeSpec = ({ name, directory }) ->
  source = """
    { exec } = require 'child_process'

    sh = (command) ->
      new Promise (resolve) ->
        exec command, (error, stdout, stderr) ->
          resolve { error, stdout, stderr }

    describe 'Some', ->
      it 'prints the help', ->
        response = await sh './bin/#{name}'
        expect(response.stdout).toContain 'A CLI to make CLIs'
  """

  IO.write "#{directory}/some.spec.coffee", source

module.exports = { CreateJasmineSetup }
