$ ->
  $('a[target=_blank]').on 'click', (-> $(@).blur())

  $('.blog-post__share-link--hackernews').hnButton()
