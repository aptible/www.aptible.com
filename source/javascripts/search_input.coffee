$(document).on 'turbolinks:load', ->
  $form = $('#search-form')
  $field = $form.find('input') if $form.length > 0
  return unless $field

  onFormSubmit = (e) ->
    e.preventDefault()
    setTimeout (->
      document.location.href = "/support/search/#stq=#{$field.val()}&stp=1"
    ), 20

  $form.on 'submit', onFormSubmit
