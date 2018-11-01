$(function() {
  // If Drift collects an email address, record the conversion
  setTimeout(() => {
    if (window.drift && window.aptible && window.aptible.analytics) {
      window.drift.on('emailCapture', function(e) {
        aptible.analytics.identify(e.data.email);
        aptible.analytics.event(aptible.analytics.events.EMAIL_COLLECTED);
        aptible.analytics.event(aptible.analytics.events.SIGNUP_DRIFT);
        aptible.analytics.fireAllPixels();
      });
    }
  }, 3000);
});
