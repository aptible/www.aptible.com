function stickyNav() {
  var UPDATE_FREQUENCY = 100;

  $(function() {
    var stickyNavElement = $('.sticky-nav');

    if (stickyNavElement.length === 1) {
      var offsetTop = stickyNavElement.offset().top;
      var stuck = false;

      setInterval(function () {
        var scrollTop = $(window).scrollTop();
        if (stuck === false && scrollTop >= offsetTop) {
          stuck = true;
          stickyNavElement.addClass('stuck');
        } else if (stuck && scrollTop < offsetTop) {
          stuck = false;
          stickyNavElement.removeClass('stuck');
        }
      }, UPDATE_FREQUENCY);
    }
  });
}
