$(document).on 'turbolinks:load', ->
  $navSearch = $('.search-nav__input')
  if $navSearch.length > 0
    $navSearch.data 'query', $navSearch.val()

    updateTransitionClass = ->
      $navSearch.val ''
      if $navSearch.data('query') is ''
        $navSearch.addClass('search-nav__input--with-transition');
      else
        $navSearch.removeClass('search-nav__input--with-transition');

    $navSearch.on 'change', ->
      console.log $navSearch.val()
      $navSearch.data 'query', $navSearch.val()

    $navSearch.on 'focus', ->
      $navSearch.val $navSearch.data('query')

    $navSearch.on 'blur', updateTransitionClass
    updateTransitionClass()
