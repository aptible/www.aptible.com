$ ->
  $doc = $ document
  $notification = $ '.notification'
  $notificationMessage = $ '.notification__message'

  notificationClose = (event) ->
    return unless $notification.attr('data-state') is 'open'
    if event?.keyCode?
      return unless event.keyCode is 27
    $notification.attr('data-state', 'closed');
    setTimeout (-> $notificationMessage.text('')), 2000

  # Close with X click
  $('.notification__close').on 'click', notificationClose
  # Close with ESC key
  $doc.on 'keyup', notificationClose

  $doc.on 'notify', (event, message) ->
    $('.notification__message').text(message)
    $notification.attr('data-state', 'open');

    # Close if not removed for 10 seconds
    setTimeout notificationClose, 10000

  # How we handle newsletter form submissions.
  # Check for a hidden input that labels the event
  loc = window.location
  if loc.search.indexOf('event=subscribed') > -1
    message = "Thank you for subscribing to our monthly security and compliance digest."
    $(document).trigger('notify', [message])
    window.history?.replaceState { }, '', loc.href.replace(loc.search, '')

  if loc.search.indexOf('event=gridiron-demo-request') > -1
    message = "We've received your request for a demo. We'll get back to you as quickly as possible."
    $(document).trigger('notify', [message])
    window.history?.replaceState { }, '', loc.href.replace(loc.search, '')

  if loc.search.indexOf('event=contact-sales') > -1
    message = "Thank you for contacting the Aptible sales team. We'll get back to you as quickly as possible."
    $(document).trigger('notify', [message])
    window.history?.replaceState { }, '', loc.href.replace(loc.search, '')
