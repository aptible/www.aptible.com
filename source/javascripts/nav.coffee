$ ->
  $('.nav-toggle').on 'click', ->
    $parent = $ $(@).parent()
    if $parent.attr('data-state') is 'open'
      $parent.attr 'data-state', ''
      return false
    $parent.attr 'data-state', 'open'
    false
