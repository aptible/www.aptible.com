$(document).on 'turbolinks:load', ->
  $('.nav-toggle').on 'click', ->
    $parent = $ $(@).parent();
    if $parent.attr('data-state') is 'open'
      return $parent.attr 'data-state', ''
    $parent.attr 'data-state', 'open'
