$ ->
  $transcript = $ '.resource-article #transcript'
  $firstParagraph = $transcript.find '+ p'
  $firstParagraph
        .addClass('transcript__preview')
        .nextUntil(':not(p)')
        .wrapAll('<div class="transcript__more" />')

  $firstParagraph.on 'click', ->
    if $firstParagraph.attr('data-state') is 'open'
      $firstParagraph.removeAttr('data-state')
    else
      $firstParagraph.attr('data-state', 'open')
