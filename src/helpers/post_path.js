module.exports.register = function (Handlebars, options) {
  'use strict';

  Handlebars.registerHelper('post_path', function (post) {
    return post.dest.replace(/dist/ig, '');
  });

  Handlebars.registerHelper('blog_asset_path', function (filename) {
    return options.data.config.blog_assets + filename;
  });

  Handlebars.registerHelper('legal_asset_path', function (filename) {
    return options.data.config.legal_assets + filename;
  });

  Handlebars.registerHelper('page_asset_path', function (filename) {
    return options.data.config.page_assets + filename;
  });

};
