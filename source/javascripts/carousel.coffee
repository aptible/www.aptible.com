$ ->
  $carousel = $('.carousel')

  # page has carousel?
  return if $carousel.length is 0

  $dots = $carousel.find('.carousel__position-dot')
  $cards = $carousel.find('.carousel__cards')
  autoPlayDuration = 5000
  autoCarousel = null

  rotateCarousel = ->
    return false if $cards.children().length > $dots.length

    $last = $carousel.find('.carousel__card:last-of-type')
    $clone = $last.clone()

    $last.addClass('carousel__card--swap')
    setTimeout (-> $last.remove()), 350
    $current = $carousel.find('.carousel__position-dot--current')

    $next = $current.next()
    unless $next.length
      $next = $carousel.find('.carousel__position-dot:first-of-type')

    $cards.prepend $clone
    $current.removeClass 'carousel__position-dot--current'
    $next.addClass 'carousel__position-dot--current'
    false

  resetAutoplay = ->
    autoCarousel = setInterval rotateCarousel, autoPlayDuration

  $cards.on 'click', '.carousel__card', ->
    clearInterval autoCarousel
    rotateCarousel()
    resetAutoplay()

  resetAutoplay()
