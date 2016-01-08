$(document).ready ->
  $('.alert').alert()
  $notice = $('.notice')
  if location.pathname == '/' && $notice.length > 0
    $notice.css 'margin-top', "-{$notice.outherHeight()}px"
    console.log "-{$notice.outherHeight()}px"
  setTimeout (-> $notice.css 'margin-top', 0), 1500
