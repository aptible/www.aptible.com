adjustContentHeight = ->
  sibling_height = 0;
  wrapper = $('.main')

  # wrapper.siblings().each () ->
  #   height = $(this).outerHeight(true)

  wrapper.css 'min-height', $(window).height() - (200 + 43 + 356)

$(document).ready ->
  adjustContentHeight()

$(window).resize ->
  adjustContentHeight()