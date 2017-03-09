$ ->
  $('.nav-toggle').on 'click', ->
    $parent = $('.nav-list--right')
    if $parent.attr('data-state') is 'open'
      $parent.attr 'data-state', ''
      $(@).attr 'data-state', ''
      return false
    $parent.attr 'data-state', 'open'
    $(@).attr 'data-state', 'open'
    false
