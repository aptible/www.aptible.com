import * as analytics from './analytics.js';
import * as cookie from './cookie.js';
import cookieConsent from './cookie-consent.js';

document.addEventListener('DOMContentLoaded', () => {
  cookieConsent();
});

// Public interface (ex: `aptible.analytics.event('Lead Form Submitted')`)
export { analytics, cookie }
