$ ->
  $('.newsletter-form').on 'submit', ->
    message = "Thank you for subscribing to our monthly security and compliance digest."
    $(document).trigger('notify', [message])