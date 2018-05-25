import * as cookie from './cookie.js';
import * as analytics from './analytics.js';
import template from './cookie-consent.html';
import './cookie-consent.css';

const CONSENT_COOKIE_NAME = 'cookie_consent';
const CONSENT_LENGTH_DAYS = 365;
const CONSENT_ANALYTICS_EVENT = 'Cookie Consent Dismissed';

export default function() {
  if (!cookie.get(CONSENT_COOKIE_NAME)) {
    showConsentForm();
  }
}

function showConsentForm() {
  document.body.insertAdjacentHTML('afterbegin', template);
  document.getElementById('cookie-consent__dismiss').onclick = agreeAndClose;
}

function agreeAndClose() {
  let expiresAt = new Date();
  expiresAt.setDate(expiresAt.getDate() + CONSENT_LENGTH_DAYS);

  cookie.write(CONSENT_COOKIE_NAME, 'yes', expiresAt);
  analytics.event(CONSENT_ANALYTICS_EVENT);

  hideConsentForm();
}

function hideConsentForm() {
  var consentPlaceholder = document.getElementById('cookie-consent__placeholder');
  consentPlaceholder.parentNode.removeChild(consentPlaceholder);

  var consent = document.getElementById('cookie-consent');
  consent.parentNode.removeChild(consent);
}
