{ sh } = require '@ch1c0t/sh'

CreateSrc = ({ name, directory }) ->
  await sh "cp -r #{ROOT}/src #{directory}"

module.exports = { CreateSrc }
