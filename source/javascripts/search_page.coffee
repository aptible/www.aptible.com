$ ->
  # This adds / removes transitions in order to keep the swiftype drop down
  # the correct width
  $navSearch = $('.search-nav__input')
  if $navSearch.length > 0
    updateTransitionClass = ->
      if $navSearch.val() is ''
        $navSearch.addClass('search-nav__input--with-transition');
      else
        $navSearch.removeClass('search-nav__input--with-transition');

    $navSearch.on 'blur', updateTransitionClass
    updateTransitionClass()
