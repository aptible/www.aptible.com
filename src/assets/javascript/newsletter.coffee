validateEmail = (email) ->
  re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
  re.test(email)

$ ->
  $.fn.extend
    newsletterForm: () ->
      @.each () ->
        form = $(this)
        fields = form.find('.form-fields')
        email = form.find('input[name="email"]')
        submit = form.find('input[type="submit"]')
        fname = form.find('input[name="fname"]')
        lname = form.find('input[name="lname"]')
        company = form.find('input[name="company"]')
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

            identified = typeof analytics.user().id == 'function' && analytics.user().id()

            if identified
              analytics.identify analytics.user().id(), newsletter_subscribed: true
            else
              traits =
                email: evamilVal,
                newsletter_subscribed: true,
                name: "#{fname.val()} #{lname.val()}",
                company_name: company.val()
              analytics.identify emailVal, traits

            analytics.track 'Subscribed To Newsletter', { email: emailVal }
            success.show()
            fields.hide()
            window.location ?= form.data('success')

          else
            error.show()
            submit.removeAttr('disabled')

  $('.newsletter-signup').newsletterForm()
