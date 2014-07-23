var gravatar = require('gravatar'),
  _ = require('lodash');

module.exports.register = function (Handlebars, options) {
  'use strict';

  Handlebars.registerHelper('gravatar', function (email, size) {
    size = size || 'sm';

    var sizes = { xs: 16, sm: 24, md: 40, lg: 64, xl: 100, xxl: 280 },
      gravatar_url = gravatar.url(email, { r: 'G', s: sizes[size] }, true),
      html = _.template('<div class="gravatar <%= size %>"><img src="<%= gravatar_url %>" /></div>')({ size: size, gravatar_url: gravatar_url});

      return new Handlebars.SafeString(html);
  });
};