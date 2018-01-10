$ ->
  $('form.contact-sales').on 'submit', (event) ->
    $form = $(@)
    # Disable the demo product selection if the request demo checkbox isn't checked.
    $form.find('input[name=request-demo-of]').prop(
      'disabled', $form.find('input[type=checkbox]:checked').length is 0
    )
    analytics.track('Contact Sales Form Submitted', {}) if analytics
    true
