module.exports.register = function (Handlebars, options) {

  Handlebars.registerHelper('env_config', function (key) {
    var env = options.env || 'development';
    if (options.data.config[key]) {
      return options.data.config[key][env];
    } else {
      return null;
    }
  });
};
