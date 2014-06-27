module.exports.register = function (Handlebars, options) {
  'use strict';

  Handlebars.registerHelper('fa', function (icon) {
    icon = icon || '';
    var html = '<i class="fa fa-'+icon+'"></i>';
    return new Handlebars.SafeString(html);
  });
};