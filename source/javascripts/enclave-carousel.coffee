$.fn.extend enclaveCarousel: (_options) ->
  SCENES = ['deploy', 'database', 'configure', 'expose', 'logging']
  AUTOPLAY_DURATION = 5000

  $(@).each ->
    $this = $(@)
    $links = $this.find '.enclave-carousel__nav-item'

    interval = null

    advanceScene = ->
      scene = $this.attr('data-scene')
      nextIndex = SCENES.indexOf(scene) + 1
      nextIndex = 0 if nextIndex >= SCENES.length

      $this.attr('data-scene', SCENES[nextIndex])

    runCarousel = ->
      interval = setInterval advanceScene, AUTOPLAY_DURATION

    $links.on 'click', (event)->
      hrefVal = $(event.target).attr('href')
      scene = switch
        when hrefVal is '#enclave-carousel--database' then 'database'
        when hrefVal is '#enclave-carousel--configure' then 'configure'
        when hrefVal is '#enclave-carousel--expose' then 'expose'
        when hrefVal is '#enclave-carousel--logging' then 'logging'
        else 'deploy'
      clearInterval interval
      $this.attr('data-scene', SCENES[SCENES.indexOf(scene)])
      runCarousel()
      false

    runCarousel()
    return

  return

$ -> $('.enclave-carousel').enclaveCarousel()
