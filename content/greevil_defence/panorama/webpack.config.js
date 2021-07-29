const path = require('path');
const { PanoramaTargetPlugin } = require('webpack-panorama');
/** @type {import('webpack').Configuration} */
module.exports = {
  entry: {
    build: './scripts/custom_game/index.js',
  },

  mode: 'development',
  context: path.resolve(__dirname, '.'),
  output: {
    path: path.resolve(__dirname, 'scripts/custom_game'),
  },

  resolve: {
    // Required because of reverse symlinking
    symlinks: false,
  },

  plugins: [new PanoramaTargetPlugin()],
};