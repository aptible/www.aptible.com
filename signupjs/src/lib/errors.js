export function errorClass(errors, fieldName) {
  const classList = ['errorable'];

  if (errors && errors.indexOf(fieldName) !== -1) {
    classList.push('error');
  }

  return classList.join(' ');
}
