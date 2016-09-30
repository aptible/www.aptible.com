$(document).on 'turbolinks:load', ->
  results = document.getElementById('st-results-large-container')
  return unless results

  onHashChange = (e) ->
    display = if window.location.hash.match(/stq=/) then 'block' else 'none'
    results.style.display = display

  window.addEventListener('hashchange', onHashChange)
  onHashChange()

  $('#st-results-large-container').delegate '.st-result', 'click', (e) ->
    window.location.href = $(@).find('h3 a').attr('href')

  form = document.getElementById('search-form')
  field = document.getElementById('st-default-search-input')

  return unless form && field

  $(form).on 'submit', (e) ->
    e.preventDefault()
    document.location.href = "/support/search/#stq=#{field.value}&stp=1"

  # TODO: know when swiftype loads content
  # debugger;
  # $('a.st-prev').each ->
  #   $(@).addClass('.arrow-link--left').text('Previous')
  #
  # $('a.st-next').each ->
  #   $(@).addClass('.arrow-link--right').text('Next')
