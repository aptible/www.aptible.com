$ ->
  # nav-burger
  $('.nav-toggle').on 'click', ->
    $parent = $(@).closest('.nav--header')
    if $parent.attr('data-state') is 'open'
      $parent.attr 'data-state', ''
      $(@).attr 'data-state', ''
      return false
    $parent.attr 'data-state', 'open'
    $(@).attr 'data-state', 'open'
    false

  # statuspage.io summary
  sp = new StatusPage.page({ page: 'fmwgqnbnbc4r' });
  sp.status
    success: (data) ->
      $('.system-status').each (index, link) ->
        $(link)
          .attr('data-value', data.status.indicator)
          .closest('a').attr('title', data.status.description)
