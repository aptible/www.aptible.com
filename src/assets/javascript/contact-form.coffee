$(document).ready ->
  $.fn.extend
    contactForm: () ->
      @.each () ->
        form = $(this)
        name = form.find('input[name="name"]')
        email = form.find('input[name="email"]')
        message = form.find('textarea[name="description"]')
        messageContainer = form.find('.alert').hide()
        alertText = messageContainer.find('.text')

        form.on 'submit', (e) ->
          nameVal = name.val()
          emailVal = email.val()
          messageVal = message.val()

          if nameVal && emailVal && messageVal
            messageContainer.attr('class', 'alert').hide()
            messageContainer.addClass('alert-success').show()
            alertText.text('Thanks for your message!')
            setTimeout (->
              name.val ''
              email.val ''
              message.val ''
            ), 50
            true

          else
            messageContainer.addClass('alert-danger').show()
            alertText.text('Name, Email, and Message are all required fields.')
            false

  $('.contact-form form').contactForm()
