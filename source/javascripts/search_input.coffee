$(document).on 'turbolinks:load', ->
  form = document.getElementById('search-form')
  field = form.getElementsByTagName('input')[0]
  return unless form && field

  onFormSubmit = (e) ->
    e.preventDefault()
    setTimeout (->
      document.location.href = "/support/search/#stq=#{field.value}&stp=1"
    ), 20

  form.addEventListener('submit', onFormSubmit)
