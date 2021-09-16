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
      build: "coffee --compile --output lib src"
      start: "coffee --watch --compile --output lib src"
      test: "jasmine"
    dependencies:
      "@ch1c0t/io": "^0.0.2"
      "@ch1c0t/sh": "^0.0.1"
    devDependencies:
      coffeescript: "^2.5.1"
      jasmine: "^3.9.0"

  await createPackageFile spec
  await createBin name
  await CreateSrc { name, directory: "#{DIR}/src" }
  await CreateJasmineSetup { name, directory: DIR }

  { sh } = require '@ch1c0t/sh'
  await sh 'npm install', cwd: DIR
  await sh 'npm run build', cwd: DIR

createPackageFile = (spec) ->
  source = JSON.stringify spec, null, 2
  IO.write "#{DIR}/package.json", source

createBin = (name) ->
  bin = "#{DIR}/bin"
  await IO.mkdir bin

  source = await IO.read "#{ROOT}/bin/makecli"

  file = "#{bin}/#{name}"
  await IO.write file, (source.replace 'makecli', name)

  fs.chmodSync file, '755'

