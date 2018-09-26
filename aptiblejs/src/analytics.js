export const utmVars = ['utm_source', 'utm_medium', 'utm_campaign', 'utm_content'];

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

export function event(name) {
  if (window.analytics) {
    let payload = allUtmVars();
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

  if (window.drift) {
    window.drift.identify(email, {
      email: email
    });
  }
}

export function firePixel(service) {
  switch (service) {
    case 'twitter':
      if (window.twttr) {
        twttr.conversion.trackPid('nz8pr', { tw_sale_amount: 0, tw_order_quantity: 0 });
      }
      break;
  }
}
