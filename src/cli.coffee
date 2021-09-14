{ create } = require './commands/create'

exports.run = ->
  [_node, _program, command] = process.argv

  switch command
    when 'new'
      name = process.argv[3]
      create name
    when 'version'
      { version } = require '../package.json'
      console.log version
    when 'help'
      printHelp()
    else
      printHelp()

printHelp = ->
  console.log """
    A CLI to make CLIs(with Node.js and CoffeeScript).

      new NAME            Create the directory named NAME and a new project inside of it.
      version             Print the version.
      help                Show this message.
  """
