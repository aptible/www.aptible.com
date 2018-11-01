$(function() {
  var createCtaEventHandler = function(eventName) {
    return function(e) {
      e.preventDefault();

      var email = $(this).find('.aptible-email').val();
      if (email.length > 0 && window.aptible && window.aptible.analytics) {
        aptible.analytics.identify(email);
        aptible.analytics.event(aptible.analytics.events.EMAIL_COLLECTED);
        aptible.analytics.event(eventName);
        aptible.analytics.fireAllPixels();
      }

      setTimeout(() => {
        $(this).off();
        $(this).submit();
      }, 500);
    }
  }

  $('.aptible-newsletter-form').on('submit', createCtaEventHandler(aptible.analytics.events.SIGNUP_NEWSLETTER));
  $('.aptible-enclave-form').on('submit', createCtaEventHandler(aptible.analytics.events.SIGNUP_ENCLAVE));
});
