export function event(name) {
  if (window.analytics) {
    window.analytics.track(name);
  }
}

export function identify(email) {
  if (window.analytics) {
    window.analytics.identify(email, {
      email: email
    });
  }
}
