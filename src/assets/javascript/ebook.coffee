validateEmail = (email) ->
  re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
  re.test(email)

$ ->
  $.fn.extend
    eBookForm: () ->
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

            traits =
              email: emailVal,
              name: "#{fname.val()} #{lname.val()}",
              company_name: company.val()

            if _this.identified()
              # Update traits for this identified user
              analytics.identify analytics.user().id(), traits
            else
              # Create a new user with the submitted traits
              analytics.identify emailVal, traits

            success.show()
            _this.trackEBook(form.data('ebook'), traits) if form.data('ebook')
          else
            error.show()
            submit.removeAttr('disabled')

    identified: () ->
      typeof analytics.user().id == 'function' && analytics.user().id()

    trackEBook: (path, traits = {}) ->
      book = path.split('/').reverse()[0]
      traits.book = book
      analytics.track 'Downloaded eBook', traits
      window.location.href = path

    eBookDownload: () ->
      @.each () =>
        $(@).on 'click', (e) =>
          e.preventDefault()
          analytics.identify analytics.user().id() if @identified()
          @trackEBook($(@).attr('href'))

  $('.ebook-form').eBookForm()

  if window.location.pathname.indexOf('ebooks') > -1
    $("a[href$='.pdf']").eBookDownload()
