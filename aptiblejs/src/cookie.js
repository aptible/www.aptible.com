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
  let cookieString = `${name}=${value}; expires=${expiresAt.toUTCString()};`;
  cookieString += `domain=.${window.location.hostname.replace('www.', '')}; path=/`;
  
  document.cookie = cookieString;
}
