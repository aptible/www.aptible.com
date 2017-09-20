$('.custom-select__link').click ->
  $('.custom-select__menu').toggleClass 'active'
  return

$('.custom-select__item').click ->
  $('.custom-select__link').text $(this).text()
  $('.custom-select__menu').toggleClass 'active'
  return

$('.custom-select__item').click ->
  $('.custom-select__link').val $(this).html()
  return

$('.custom-select__link').keyup (demo) ->
  $('.custom-select__menu').toggleClass 'active'
  if code == 13
    e.preventDefault()
    return false
  return
return