{ create } = require './commands/create'

exports.run = ->
  [_node, _agn, command] = process.argv

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

      new project_name    Create the directory named "project_name" and a new project inside of it.
      help                Show this message.
  """
