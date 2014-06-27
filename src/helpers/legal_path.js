module.exports.register = function (Handlebars, options) {
  'use strict';

  Handlebars.registerHelper('legal_path', function (post) {
    return post.dest.replace(/dist/ig, '');
  });

};
