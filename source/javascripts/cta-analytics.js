$(function() {
  var createCtaEventHandler = function(eventName) {
    return function(e) {
      e.preventDefault();
      var form = $(this);

      var email = form.find('.aptible-email').val();
      if (email.length > 0 && window.aptible && window.aptible.analytics) {
        aptible.analytics.identify(email);
        aptible.analytics.event(aptible.analytics.events.EMAIL_COLLECTED);
        aptible.analytics.event(eventName);
        aptible.analytics.fireAllPixels();
      }

      setTimeout(function() {
        form.off();
        form.submit();
      }, 1000);
    }
  }

  $('.aptible-newsletter-form').on('submit', createCtaEventHandler(aptible.analytics.events.SIGNUP_NEWSLETTER));
  $('.aptible-enclave-form').on('submit', createCtaEventHandler(aptible.analytics.events.SIGNUP_ENCLAVE));
});
