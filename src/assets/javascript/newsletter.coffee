validateEmail = (email) ->
  re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
  re.test(email)

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

          if emailVal && validateEmail(emailVal)
            # Trigger Customer.io tracking...
            analytics.page()

            analytics.identify email: emailVal, newsletter_subscribed: true
            analytics.track 'Subscribed To Newsletter', { email: emailVal }
            success.show()
            fields.hide()

          else
            error.show()
            submit.removeAttr('disabled')

  $('.newsletter-signup').newsletterForm()
