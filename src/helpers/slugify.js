module.exports.register = function (Handlebars, options) {
  'use strict';

  Handlebars.registerHelper('slugify', function (str) {
    return str ? str.toLowerCase().replace(/ /g,'-').replace(/[^\w-]+/g,'') : '';
  });
};