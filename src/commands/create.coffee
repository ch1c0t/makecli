path = require 'path'
fs = require 'fs'

CWD = process.cwd()
DIR = "/tmp/makecli/path"
ROOT = path.dirname path.dirname __dirname

exports.create = (name) ->
  DIR = "#{CWD}/#{name}"

  if fs.existsSync DIR
    console.error "#{DIR} already exists."
    process.exit 1
  else
    fs.mkdirSync DIR

  spec =
    name: name
    version: '0.0.0'
    scripts:
      dev: "coffee --watch --compile --output lib src"
      test: "coffee ./test/all.coffee"
    devDependencies:
      coffeescript: "^2.5.1"

  createPackageFile spec
  createBin name
  createSrc()
  createTests()

createPackageFile = (spec) ->
  source = JSON.stringify spec, null, 2
  fs.writeFileSync "#{DIR}/package.json", source

createBin = (name) ->
  bin = "#{DIR}/bin"
  fs.mkdirSync bin

  source = fs.readFileSync "#{ROOT}/bin/makecli", 'utf-8'

  fs.writeFileSync "#{bin}/#{name}", (source.replace 'makecli', name)

createSrc = ->
  src = "#{DIR}/src"
  fs.mkdirSync src

  createCli src
  createCreateCommand src

createCli = (src) ->
  fs.copyFile "#{ROOT}/src/cli.coffee", "#{src}/cli.coffee", (error) ->
    throw error if error

createCreateCommand = (src) ->
  commands = "#{src}/commands"
  fs.mkdirSync commands

  fs.copyFile "#{ROOT}/src/commands/create.coffee", "#{commands}/create.coffee", (error) ->
    throw error if error

createTests = ->
  test = "#{DIR}/test"
  fs.mkdirSync test

  source = """
    console.log 'No tests yet.'
  """

  fs.writeFileSync "#{test}/all.coffee", source
