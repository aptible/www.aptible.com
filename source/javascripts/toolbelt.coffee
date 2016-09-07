$(document).on 'turbolinks:load', ->
  buttons = $('.os-panels a.category-box')
  panels = $('.download-panels .download-panel')
  download_buttons = $('.download-button')

  download_buttons.each (index, button) =>
    button = $(button)
    button.on 'click', (e) =>
      panel = button.parents('.download-panel')
      pre = panel.find('pre')
      path = button.attr('href').split('/')
      path = decodeURIComponent(path[path.length-1])

      instruction = "sudo dpkg -i #{path}"
      pre.text(instruction)

  buttons.each (index, button) =>
    button = $(button)
    button.on 'click', (e) =>
      return false if button.hasClass('active')

      targetAnchor = button.attr('href')
      window.location.hash = 'download-' + targetAnchor.replace('#', '')
      target = $(targetAnchor)

      buttons.removeClass('active')
      panels.removeClass('active')

      button.addClass('active')
      target.addClass('active')

      e.preventDefault()

  # On page load, check if there is an existing hash in the URL.  If so, click
  # the associated button
  if /download\-/.test(window.location.hash)
    target = window.location.hash.replace('download-', '')
    targetButton = $('[href="'+target+'"]')

    targetButton.click()
