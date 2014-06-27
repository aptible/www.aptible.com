module.exports.register = function (Handlebars, options) {
  'use strict';

  Handlebars.registerHelper('author_path', function (page) {
    return '/blog/authors/' + page.author_id + '.html';
  });
};
