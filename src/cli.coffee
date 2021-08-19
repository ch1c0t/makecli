{ create } = require './commands/create'

exports.run = ->
  [_node, _program, command] = process.argv

  switch command
    when 'new'
      name = process.argv[3]
      create name
    when 'help'
      printHelp()
    else
      printHelp()

printHelp = ->
  console.log """
    A CLI app for making CLI apps.

      new NAME            Create the directory named NAME and a new project inside of it.
      help                Show this message.
  """
