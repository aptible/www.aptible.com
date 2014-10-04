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

          nameVal = name.val()
          emailVal = email.val()
          messageVal = message.val()

          if nameVal && emailVal && messageVal
            messageContainer.attr('class', 'alert').hide()

            # Trigger Customer.io tracking...
            analytics.page()

            identified = typeof analytics.user().id == 'function' && analytics.user().id()

            unless identified
              analytics.identify emailVal, name: nameVal, email: emailVal
            analytics.track action, { name: nameVal, email: emailVal, message: messageVal }

            messageContainer.addClass('alert-success').show()
            alertText.text('Thanks for your message!')
            name.val ''
            email.val ''
            message.val ''

          else
            messageContainer.addClass('alert-danger').show()
            alertText.text('Name, Email, and Message are all required fields.')

  $('.contact-form form').contactForm()
