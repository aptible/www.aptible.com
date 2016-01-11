analyticsReady = ->
  # Only do this once.
  return if $(document).data 'analyticsCalled'
  $(document).data 'analyticsCalled', true

  # Is there a notice to display?
  $notice = $ '.notice'
  $noticeClose = $notice.find '.notice__close'
  $noticeMessage = $notice.find '.notice__message'

  # Has the notice been visited or dimissed?
  try
    newNotice = analytics.user().traits().header_banner_notice != $noticeMessage.attr('href')
  catch
    newNotice = true

  unless location.pathname == '/' && $notice.length > 0 && newNotice
    $notice.remove();
  else
    # Make sure the notice is hidden accurately if it happens to be multiple lines
    hideMargin = "-#{$notice.outerHeight()}px"
    $notice.css
      marginTop: hideMargin
      display: 'block'
    setTimeout (-> $notice.removeClass('no-animation')), 100

    # Update state when the notice is visited
    $noticeMessage.on 'click', ->
      # Attempt to save that this notice has been visited
      try
        analytics.identify header_banner_notice: $noticeMessage.attr('href')

    # Update state when the notice is dismissed
    $noticeClose.on 'click', ->
      $noticeClose.hide();
      $notice.css 'marginTop', hideMargin
      setTimeout (-> $notice.css 'display', 'none'), 3000
      # Attempt to save that this notice has been dismissed
      try
        analytics.identify header_banner_notice: $noticeMessage.attr('href')
      false

    # Slow-slide-reveal the notice...
    setTimeout (-> $notice.css 'margin-top', 0), 1000

$(document).ready ->
  $('.alert').alert()

  analytics.ready analyticsReady
  # Fallback in case analytics is blocked
  setTimeout analyticsReady, 1000
