$(document).ready ->
  $.fn.extend
    newsletterForm: () ->
      @.each () ->
        form = $(this)
        fields = form.find('.form-fields')
        email = form.find('input[name="email"]')
        submit = form.find('input[tyep="submit"]')
        success = form.find('.message.success')
        error = form.find('.message.danger')

        form.on 'submit', (e) ->
          e.preventDefault()
          emailVal = email.val()
          submit.attr 'disabled', 'disabled'
          error.hide()
          success.hide()

          if emailVal
            analytics.identify email: emailVal, newsletter_subscribed: true
            analytics.track 'subscribed_to_newsletter', { email: emailVal }
            success.show()
            fields.hide()

          else
            error.show()
            submit.removeAttr('disabled')

  $('.newsletter-signup').newsletterForm()
