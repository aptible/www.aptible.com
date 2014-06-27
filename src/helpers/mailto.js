module.exports.register = function (Handlebars, options) {
  'use strict';

  Handlebars.registerHelper('mailto', function (email, className) {
    className = className || '';
    var html = '<a href="mailto:'+email+'" class="'+className+'">'+email+'</a>';
    return new Handlebars.SafeString(html);
  });
};