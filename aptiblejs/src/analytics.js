export const utmVars = ['utm_source', 'utm_medium', 'utm_campaign', 'utm_content'];

export const events = {
  EMAIL_COLLECTED: 'Email Collected',
  SIGNUP_GRIDIRON: 'Gridiron Signup Started',
  SIGNUP_ENCLAVE: 'Enclave Signup Started',
  SIGNUP_NEWSLETTER: 'Newsletter Signup',
  SIGNUP_DRIFT: 'Drift Email Collected',
  COOKIE_CONSENT: 'Cookie Consent Dismissed'
};

export function allParams() {
  const params = {};

  const queryString = (window.location.search[0] === '?' ? window.location.search.substr(1) : window.location.search);
  if (queryString.length < 1) {
    return params;
  }

  const pairs = queryString.split('&');
  for (let i = 0; i < pairs.length; i++) {
    let pair = pairs[i].split('=');
    params[decodeURIComponent(pair[0])] = decodeURIComponent(pair[1] || '');
  }

  return params;
}

export function getParam(key) {
  return allParams()[key];
}

export function allUtmVars() {
  let utms = {};

  const params = allParams();
  for (let key in params) {
    if (utmVars.indexOf(key) !== -1) {
      utms[key] = params[key];
    }
  }

  return utms;
}

export function currentURL() {
  return `${window.location.origin}${window.location.pathname}`;
}

export function event(name, payload={}) {
  if (window.analytics) {
    payload = Object.assign({}, payload, allUtmVars());
    payload['url'] = currentURL();

    window.analytics.track(name, payload);
  }
}

export function identify(email) {
  if (window.analytics) {
    window.analytics.identify(email, {
      email: email,
      url: currentURL()
    });
  }
}

export function fireAllPixels() {
  firePixel('quora');
}

export function firePixel(service) {
  try {
    switch (service) {
      case 'twitter':
        if (window.twttr) {
          twttr.conversion.trackPid('nz8pr', { tw_sale_amount: 0, tw_order_quantity: 0 });
        }
        break;
      case 'quora':
        if (window.qp) {
          window.qp('track', 'Generic');
        }
        break;
    }
  } catch(e) {
    // Prevent analytics from throwing exceptions
    console.warn(e);
  }
}
