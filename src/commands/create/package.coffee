exports.CreatePackageFile = ({ name }) ->
  spec =
    name: name
    bin: "./bin/#{name}"
    version: '0.0.0'
    scripts:
      build: "coffee --compile --output lib src"
      start: "coffee --watch --compile --output lib src"
      test: "jasmine"
    dependencies:
      "@ch1c0t/io": "^0.0.3"
      "@ch1c0t/sh": "^0.0.1"
    devDependencies:
      coffeescript: "^2.5.1"
      jasmine: "^3.9.0"

  source = JSON.stringify spec, null, 2
  IO.write "#{DIR}/package.json", source

