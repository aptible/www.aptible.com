$ ->
  # Collapsable lists
  $lists = $ "ul[data-collapsable='true'], ol[data-collapsable='true']"
  $lists.on 'click', ->
    $list = $ @
    if $list.is "[data-is-collapsed='true']"
      $list.attr 'data-is-collapsed', false
    else
      $list.attr 'data-is-collapsed', true
    false
