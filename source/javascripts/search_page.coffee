$(document).on 'turbolinks:load', ->
  results = document.getElementById('st-results-large-container')
  return unless results

  onHashChange = (e) ->
    display = if window.location.hash.match(/stq=/) then 'block' else 'none'
    results.style.display = display

  window.addEventListener('hashchange', onHashChange)
  onHashChange()

document.addEventListener 'DOMContentLoaded', ->
  form = document.getElementById('large-search-form')
  field = document.getElementById('swifttype-search-input-large')

  return unless form && field

  onFormSubmit = (e) ->
    e.preventDefault()
    document.location.href = "/support/search/#stq=#{field.value}&stp=1"

  form.addEventListener('submit', onFormSubmit)
