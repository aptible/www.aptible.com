compliance_steps = ['risk', 'policies', 'training', 'security', 'incidents']

$(document).ready ->

  compliance_steps_el = $('.compliance-cycle-steps')
  compliance_carousel = $('.compliance-carousel').slick
    fade: true
    autoplay: true
    pauseOnHover: true

  compliance_carousel.on 'beforeChange', (e, slick, currentSlide, nextSlide) ->
    currentSlide = if currentSlide is (compliance_steps.length-1) then 0 else currentSlide+1
    step = compliance_steps[currentSlide]
    compliance_steps_el.attr('class', "#{step} compliance-cycle-steps")

  compliance_steps_el.addClass('risk')

  $('.tools-carousel, .carousel').slick
    autoplay: true
    autoplaySpeed: 4000
    arrows: false

  $('.testimonials').slick
    autoplay: true
    autoplaySpeed: 5000
    arrows: true


