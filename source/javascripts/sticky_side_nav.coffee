$(document).on 'turbolinks:load', ->
  $sideNav = $ '.grid-aside--left .grid-aside'
  ticking = false
  $win = $ window
  lastScrollTop = $win.scrollTop()
  $footer = $('.resources-footer')
  $footer = $('.aptible-footer') unless $footer.length > 0

  if $sideNav.length > 0
    sideNavHeight = $sideNav.outerHeight()
    sideNavTop = $sideNav.position().top
    footerTop = $footer.position().top
    fixedNavBoundary = $('header.aptible-header').outerHeight();
    bottomBoundary = footerTop - sideNavHeight;

    console.log sideNavHeight, footerTop

    onScroll = ->
      lastScrollTop = $win.scrollTop()
      requestTick()

    $win.on 'scroll', onScroll

    update = ->
      currentScrollTop = lastScrollTop
      ticking = false
      viewportWidth = $win.widt()

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

    requestTick = ->
      requestAnimationFrame(update) unless ticking
      ticking = true

    update()
    requestAnimationFrame(update)

    $('.side-nav__to-top').on 'click', ->
      $('html, body').animate({
        scrollTop: 0
      }, 1000)
      return false;

    $('a[href*="#"]').on 'click', ->
      requestTick()
      $target = $(this.hash)
      if ($target.length)
        $('html, body').animate({
          scrollTop: $target.offset().top - 50
        }, 1000)
        return false;
