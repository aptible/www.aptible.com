$ ->
  if $('.faq').length > 0
    $viewport = $ 'html, body'
    $("a[href^='#']").on 'click', ->
      $viewport.animate(
        { scrollTop: $($(@).attr('href')).offset().top },
        750, 'swing')
      false
