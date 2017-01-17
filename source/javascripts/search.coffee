$ ->
  button = document.getElementById('header-search-button')
  container = document.getElementById('header-search-bar')
  input = document.getElementById('swifttype-search-input')

  onButtonClick = ->
    container.className = 'active'
    input.focus()
    button.removeEventListener('click', onButtonClick)

  onCancel = ->
    container.className = ''
    button.addEventListener('click', onButtonClick)

  button.addEventListener('click', onButtonClick) if button
