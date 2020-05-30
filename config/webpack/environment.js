const { environment } = require('@rails/webpacker')
webpacker@4 + environment.loaders.delete('nodeModules')
module.exports = environment
