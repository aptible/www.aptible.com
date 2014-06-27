$(document).ready ->
  $.fn.extend
    contactForm: () ->
      @.each () ->
        form = $(this)
        name = form.find('input[name="name"]')
        email = form.find('input[name="email"]')
        message = form.find('textarea[name="message"]')
        action = form.find('input[name="action"]').val()
        messageContainer = form.find('.alert').hide()
        alertText = messageContainer.find('.text')

        form.on 'submit', (e) ->
          e.preventDefault()

          if name.val() && email.val() && message.val()
            messageContainer.attr('class', 'alert').hide()

            analytics.track(action, {
              name: name.val(),
              email: email.val()
              message: message.val()
            })

            messageContainer.addClass('alert-success').show()
            alertText.text('Thanks for your message!')

          else
            messageContainer.addClass('alert-danger').show()
            alertText.text('Name, Email, and Message are all required fields.')

  $('.contact-form form').contactForm()
