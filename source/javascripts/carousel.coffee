$ ->
  $('.feature-carousel__btn').on 'click', ->
    $this = $(@);
    item = $this.attr('href').replace('#', '.feature-carousel--');

    unless $this.is('.active')
      $('.feature-carousel.active, .feature-carousel__btn').removeClass('active');
      $this.addClass('active');
      $(item).addClass('active');

    false
