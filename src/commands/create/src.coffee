CreateSrc = ({ name, directory }) ->
  await IO.mkdir directory

  await IO.copy "#{ROOT}/src/cli.coffee", "#{directory}/cli.coffee"

  await IO.mkdir "#{directory}/commands"
  await IO.mkdir "#{directory}/commands/create"
  await IO.copy "#{ROOT}/src/commands/create.coffee",
                "#{directory}/commands/create.coffee"
  await IO.copy "#{ROOT}/src/commands/create/src.coffee",
                "#{directory}/commands/create/src.coffee"
  await IO.copy "#{ROOT}/src/commands/create/jasmine_setup.coffee",
                "#{directory}/commands/create/jasmine_setup.coffee"

module.exports = { CreateSrc }
