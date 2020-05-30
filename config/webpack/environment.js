const { environment } = require('@rails/webpacker')
webpacker + environment.loaders.delete('nodeModules')
module.exports = environment
