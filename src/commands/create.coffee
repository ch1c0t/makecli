path = require 'path'
fs = require 'fs'

{ CreateSrc } = require './create/src'
{ CreateJasmineSetup } = require './create/jasmine_setup'

CWD = process.cwd()
DIR = "/tmp/makecli/path"
global.ROOT = path.dirname path.dirname __dirname

exports.create = (name) ->
  DIR = "#{CWD}/#{name}"

  if fs.existsSync DIR
    console.error "#{DIR} already exists."
    process.exit 1
  else
    fs.mkdirSync DIR

  spec =
    name: name
    bin: "./bin/#{name}"
    version: '0.0.0'
    scripts:
      dev: "coffee --watch --compile --output lib src"
      test: "jasmine"
    dependencies:
      "@ch1c0t/io": "^0.0.2"
    devDependencies:
      coffeescript: "^2.5.1"
      jasmine: "^3.9.0"

  createPackageFile spec
  createBin name
  await CreateSrc { name, directory: "#{DIR}/src" }
  await CreateJasmineSetup { name, directory: DIR }

  { exec } = require 'child_process'
  exec 'npm install', cwd: DIR

createPackageFile = (spec) ->
  source = JSON.stringify spec, null, 2
  fs.writeFileSync "#{DIR}/package.json", source

createBin = (name) ->
  bin = "#{DIR}/bin"
  fs.mkdirSync bin

  source = fs.readFileSync "#{ROOT}/bin/makecli", 'utf-8'

  fs.writeFileSync "#{bin}/#{name}", (source.replace 'makecli', name)
