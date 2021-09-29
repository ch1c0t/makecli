exports.CreateBin = ({ name }) ->
  bin = "#{DIR}/bin"
  await IO.mkdir bin

  source = await IO.read "#{ROOT}/bin/makecli"

  file = "#{bin}/#{name}"
  await IO.write file, (source.replace 'makecli', name)
  await IO.chmod file, '755'
