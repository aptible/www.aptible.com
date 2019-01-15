const path = require('path');

module.exports = {
  entry: {
    'quiz': './src/index.js',
    'quiz-results': './src/results.js'
  },
  output: {
    filename: '[name].js',
    path: path.resolve(__dirname, '../source/javascripts'),
  },
  module: {
    rules: [
      {
        test: /\.js$/,
        exclude: /node_modules/,
        use: {
          loader: 'babel-loader'
        }
      }
    ]
  }
};
