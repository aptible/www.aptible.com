function all() {
  let cookies = {};
  const cookieStrings = document.cookie.split(';');

  for (let cookie of cookieStrings) {
    const pieces = cookie.split('=');
    if (pieces.length !== 2) {
      continue;
    }

    cookies[pieces[0].trim()] = pieces[1].trim();
  }

  return cookies;
}

export function get(name) {
  return all()[name];
}

export function write(name, value, expiresAt) {
  let domain = window.location.hostname;
  if (domain.indexOf('www.') !== -1) {
    domain = domain.replace('www.', '');
  }

  let cookieString = `${name}=${value}; expires=${expiresAt.toUTCString()};`;
  cookieString += `domain=.${domain}; path=/`;
  
  document.cookie = cookieString;
}
