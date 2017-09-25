const environment = require('./environment');
const testConfig = require('./test');
const merge = require('webpack-merge');

module.exports = {
  resolve: {
    alias: {
      applicationStyles: 'app/javascript/packs/fibs.scss',
      FibIndex: 'app/javascript/packs/fib_index.jsx'
    },
    extensions: ['', '.js', '.jsx']
  }
}

module.exports = merge(environment.toWebpackConfig(), testConfig);