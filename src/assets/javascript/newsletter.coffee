validateEmail = (email) ->
  re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
  re.test(email)

$ ->
  $.fn.extend
    newsletterForm: () ->
      _this = @
      @.each () ->
        form = $(this)
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

            traits = email: emailVal

            if _this.identified()
              analytics.identify analytics.user().id(), newsletter_subscribed: true
            else
              traits =
                email: emailVal,
                newsletter_subscribed: true,
                name: "#{fname.val()} #{lname.val()}",
                company_name: company.val()
              analytics.identify emailVal, traits

            analytics.track 'Subscribed To Newsletter', traits
            success.show()
            _this.trackEBook(form.data('ebook'), traits) if form.data('ebook')

          else
            error.show()
            submit.removeAttr('disabled')

    identified: () ->
      typeof analytics.user().id == 'function' && analytics.user().id()

    trackEBook: (path, traits = {}) ->
      debugger
      book = path.split('/').reverse()[0]
      traits.book = book
      console.log traits
      analytics.identify analytics.user().id() if @identified()
      analytics.track 'Downloaded eBook', traits
      window.location.href = path

    eBookDownload: () ->
      @.each () =>
        $(@).on 'click', (e) =>
          e.preventDefault()
          @trackEBook($(@).attr('href'))

  $('.newsletter-signup').newsletterForm()

  console.log window.location
  if window.location.pathname.indexOf('ebooks') > -1
    $("a[href$='.pdf']").eBookDownload()
