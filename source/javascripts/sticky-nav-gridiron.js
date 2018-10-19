function stickyNavGridiron() {
  var UPDATE_FREQUENCY = 500;

  $(function () {
    var currentlyActive = null;
    var stickyNavLinks = $('.sticky-nav a');

    // Get the current offset of each section
    var anchors = ['features', 'pricing', 'docs'];
    var anchorOffsets = [];
    for (var i = 0; i < anchors.length; i++) {
      anchorOffsets.push($('#' + anchors[i]).offset().top);
    }

    setInterval(function () {
      var scrollTop = $(window).scrollTop();
      var windowHeight = window.innerHeight;

      anchorOffsets = [];
      for (var i = 0; i < anchors.length; i++) {
        anchorOffsets.push($('#' + anchors[i]).offset().top);
      }

      // Determine which section we are in based on what's in the middle of
      // the screen
      var middlePosition = scrollTop + parseInt(windowHeight / 2);

      // Loop through each section from the bottom up. If we are in that
      // section, highlight it and return.
      for (var j = anchors.length - 1; j >= 0; j--) {
        if (middlePosition >= anchorOffsets[j]) {
          if (currentlyActive !== anchors[j]) {
            currentlyActive = anchors[j];
            stickyNavLinks.removeClass('active');
            $('a[href*="#' + anchors[j] + '"]').addClass('active');
          }
          return;
        }
      }

      // Otherwise we are not in a subnav section (ie, in the hero) and
      // therefore no menu item should be highlighted.
      if (currentlyActive !== null) {
        currentlyActive = null;
        stickyNavLinks.removeClass('active');
      }
    }, UPDATE_FREQUENCY);
  });
}
