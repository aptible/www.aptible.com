$(document).on 'turbolinks:load', ->
  $sideNav = $ '.grid-aside--left .grid-aside'
  $win = $ window
  $footer = $('.resources-footer')
  $footer = $('.aptible-footer') unless $footer.length > 0
  $htmlBody = $('html, body')

  if $sideNav.length > 0
    sideNavHeight = $sideNav.outerHeight()
    sideNavTop = $sideNav.position().top
    footerTop = $footer.position().top
    fixedNavBoundary = $('header.aptible-header').outerHeight();

    update = ->
      currentScrollTop = $win.scrollTop()
      viewportWidth = $win.width()

      if currentScrollTop > fixedNavBoundary && viewportWidth > 768
        $sideNav.addClass 'side-nav--fixed'
      else
        $sideNav.removeClass 'side-nav--fixed'

      if (currentScrollTop + sideNavHeight + 50) > footerTop && viewportWidth > 768
        $sideNav.removeClass 'side-nav--fixed'
        $sideNav.addClass 'side-nav--stuck'
        $sideNav.css 'top', sideNavTop
      else
        sideNavTop = $sideNav.offset().top - 50
        $sideNav.removeClass 'side-nav--stuck'
        $sideNav.css 'top', ''

      requestAnimationFrame(update)

    update()

    #
    # Attempt some smooooth scrolling
    # Don't scroll if a scroll animation is already in progress or they'll
    # get backed up and super janky.
    #
    $('.side-nav__to-top').on 'click', ->
      unless $htmlBody.is(':animated')
        $htmlBody.animate({
          scrollTop: 0
        }, 1000)
        return false;

    $('a.side-nav__item[href*="#"]').on 'click', ->
      $target = $ @hash
      if ($target.length && !$htmlBody.is(':animated'))
        $htmlBody.animate({
          scrollTop: $target.offset().top - 50
        }, 1000)
        return false;
