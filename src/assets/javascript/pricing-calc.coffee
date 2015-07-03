

containerSlider = $('#container-slider')
diskSlider = $('#disk-slider')
domainSlider = $('#domain-slider')

colSettings = $('.col-settings')
panelPHI = $('.panel-phi')
panelFSC = $('.panel-compliance')

includedScale = $('.included')

changeAttr = (attribute, value) ->
  $(id).attr attribute, vakue
  return


# Scale the blue bars in the jQuery UI sliders
blueBar = (containers, disk, domains) ->


  containersBlueBarWidth = (containers - 1) * 10 + '%'
  diskBlueBarWidth = (disk - 1) * 10 + '%'
  domainsBlueBarWidth = (domains - 1) * 10 + '%'

  if !$('.bluebar').length
    # Create the bars if they don't already exist
    containerSlider.prepend '<div class="bluebar" style="width:' + containersBlueBarWidth + '"></div>'
    diskSlider.prepend '<div class="bluebar" style="width:' + diskBlueBarWidth + '"></div>'
    domainSlider.prepend '<div class="bluebar" style="width:' + domainsBlueBarWidth + '"></div>'
  else
    # Scale the sliders if they already exist
    containerSlider.find('.bluebar').width containersBlueBarWidth
    diskSlider.find('.bluebar').width diskBlueBarWidth
    domainSlider.find('.bluebar').width domainsBlueBarWidth

  return


# Only use this when the User is changing the slider manually, and on load
writeValAttr = (id, value) ->
  id.attr 'userval', value
  return

# Do this when the slider is being changed via other methods. Updates the key
moveSlider = (id, value) ->
  id.slider 'value', value
  updateKey id, value
  return

# This updates the key, triggered when changed manually and with moveSlider
updateKey = (id, value) ->
  key = id.prev('.key')
  key.find('li').removeClass 'selected-key'
  key.find('.key-' + value).addClass 'selected-key'
  return

# This is triggered when the PHI toggle changes
PHIchange = ->

  # Get values that have been set by the user
  containerSliderUserValue = containerSlider.attr('userval')
  diskSliderUserValue = diskSlider.attr('userval')
  domainSliderUserValue = domainSlider.attr('userval')


  if ($('.phi-checkbox').is(':checked'))

    ###
    AT LEAST A PLATFORM PLAN
    ###

    $.glob.plan = 'platform'
    $.glob.phi = true
    includedScale.removeClass 'hidden-alt'

    # Move the container slider
    if containerSlider.slider('option', 'value') < $.included.containers
      moveSlider containerSlider, $.included.containers
      $.sliderValue.containers = $.included.containers
    # Move the disk slider
    if diskSlider.slider('option', 'value') < $.included.disk
      moveSlider diskSlider, $.included.disk
      $.sliderValue.disk = $.included.disk
    # Move the domains slider
    if domainSlider.slider('option', 'value') < $.included.domains
      moveSlider domainSlider, $.included.domains
      $.sliderValue.domains = $.included.domains

    # Show FSC toggle
    showFSC()

  else

    ###
    DEVELOPMENT PLAN
    ---
    Everything is reverted to non phi, and the full service compliance
    panel is hidden. If the plan was a production one, then that is also
    reverted
    ###

    $.glob.phi = false

    includedScale.addClass 'hidden-alt'

    containerSliderCurrentValue = containerSlider.slider('option', 'value')
    diskSliderCurrentValue = diskSlider.slider('option', 'value')
    domainSliderCurrentValue = diskSlider.slider('option', 'value')

    if containerSliderUserValue < containerSliderCurrentValue
      moveSlider containerSlider, containerSliderUserValue
      $.sliderValue.containers = containerSliderUserValue

    if diskSliderUserValue < diskSliderCurrentValue
      moveSlider diskSlider, diskSliderUserValue
      $.sliderValue.disk = diskSliderUserValue

    if domainSliderUserValue < domainSliderCurrentValue
      moveSlider domainSlider, domainSliderUserValue
      $.sliderValue.domains = domainSliderUserValue

    if $('.compliance-checkbox').is(':checked')
      $('.compliance-checkbox').prop('checked', false)
      FSCchange()

    # set the plan name
    $.glob.plan = 'development'

  # Update Price
  updatePrice $.sliderValue.containers, $.sliderValue.disk, $.sliderValue.domains
  
  # Update Blue Bars
  blueBar $.sliderValue.containers, $.sliderValue.disk, $.sliderValue.domains

  return

# this is triggered when the Full Service Compliance toggle changes
hideFSC = ->
  totalHeight = colSettings.find('.pricing-title').outerHeight()
  panelPHIHeight = panelPHI.outerHeight()
  panelFSCHeight = panelFSC.outerHeight()
  newTotalHeight = panelPHIHeight + totalHeight + 2;
    
  panelFSC.animate {
    'opacity': 0
  }, 500
  window.setTimeout (->
      colSettings.first('.panel').animate {
        'height': newTotalHeight
      }, 500
      panelFSC.addClass 'hidden-alt'
      window.setTimeout (->
          colSettings.first('.panel').css {
            'height': ''
          }, 500
          return
        ), 500
      return
    ), 500

  return


showFSC = ->
  totalHeight = colSettings.find('.pricing-title').outerHeight()
  panelPHIHeight = panelPHI.outerHeight()
  initialPanelHeight = $('.col-settings > .panel').outerHeight()

  colSettings.first('panel').height initialPanelHeight

  panelFSC.css {
    'opacity': 0
  }
  panelFSC.removeClass 'hidden-alt'

  panelFSCHeight = panelFSC.outerHeight()
  newTotalHeight = panelPHIHeight + panelFSCHeight + totalHeight;
  colSettings.first('.panel').animate {
    'height': newTotalHeight
  }, 500
  
  window.setTimeout (->
      panelFSC.animate {
        'opacity' : 1
      }, 500
      colSettings.first('.panel').css {
        'height': ''
      }, 500
      return
    ), 500
  return

scaleIncluded = ->
  $('#container-inc-scale').width ($.included.containers - 1.2) * 10 + '%'
  $('#disk-inc-scale').width ($.included.disk - 1.2) * 10 + '%'
  $('#domain-inc-scale').width ($.included.domains - 1.2) * 10 + '%'
  return

needmore = (type) ->
  totalWrap = $('.total-wrap')
  if !type and !totalWrap.hasClass('hidden-alt-total-wrap')
    # do nothing

  else if !type and $('.total-wrap').hasClass('hidden-alt-total-wrap')

    # NEED MORE to NORMAL
    needmoreslidersshow false

    origH = $('.total-wrap').outerHeight()
    totalWrap.height('').css 'position': 'absolute'
    newH = totalWrap.outerHeight()
    totalWrap.height(origH).css 'position': ''
    totalWrap.animate { 'height': newH }, 500
    window.setTimeout (->
      $('.total-wrap').animate { 'opacity': 1 }, 500
      return
    ), 500
    $('.total-wrap').removeClass 'hidden-alt-total-wrap'

  else if !$('.total-wrap').hasClass('hidden-alt-total-wrap')

    # NORMAL TO NEED MORE
    needmoreslidersshow true
    origH = totalWrap.outerHeight()
    totalWrap.height('').css 'position': 'absolute'
    newH = totalWrap.outerHeight()
    totalWrap.height(origH).css 'position': ''
    totalWrap.animate { 'opacity': 0 }, 500
    window.setTimeout (->
      totalWrap.animate { 'height': '1px' }, 500
      return
    ), 500
    totalWrap.addClass 'hidden-alt-total-wrap'

  return

needmoreslidersshow = (show) ->
  if show
    # get need more height
    $('.need-more').css
      'opacity': 0
      'position': 'absolute'
      'width': $('.domains-panel').width()
    $('.col-summary').find('.panel').removeClass('focus-panel').css 'opacity': 0.5
    $('.col-config').find('.panel').addClass 'focus-panel'
    conH = $('.disk-panel').outerHeight()
    disH = $('.disk-panel').outerHeight()
    domH = $('.domains-panel').outerHeight()
    neeH = $('.need-more').outerHeight()
    panH = $('.col-config').find('.panel-cont').outerHeight()
    # RESET need more
    $('.need-more').css
      'opacity': ''
      'position': ''
      'width': ''
    if `$.sliderValue.containers === 11`
      newPanH = neeH + conH
      # SET CURRENT PANEL HEIGHT
      $('.col-config').find('.panel-cont').css 'height': panH
      # PREP NEED MORE FOR INTRO
      $('.need-more').removeClass('hidden-alt').css 'opacity': 0
      # HIDE OTHER SLIDERS
      $('.disk-panel, .domains-panel').animate({ 'opacity': 0 }, 500).addClass 'hidden-alt-slider'
      # CHANGE THE HEIGHT
      window.setTimeout (->
        `var newPanH`
        $('.disk-panel, .domains-panel').css 'display': 'none'
        $('.col-config').find('.panel-cont').animate 'height': newPanH
        window.setTimeout (->
          $('.need-more').animate 'opacity': 1
          return
        ), 500
        return
      ), 500
    else if `$.sliderValue.disk === 11`
      newPanH = conH + disH + neeH
      # DISABLE PREVIOUS SLIDERS
      $('#container-slider').slider 'option', 'disabled', true
      # SET CURRENT PANEL HEIGHT
      $('.col-config').find('.panel-cont').css 'height': panH
      # PREP NEED MORE FOR INTRO
      $('.need-more').removeClass('hidden-alt').css 'opacity': 0
      # HIDE OTHER SLIDERS
      $('.domains-panel').animate({ 'opacity': 0 }, 500).addClass 'hidden-alt-slider'
      # CHANGE THE HEIGHT
      window.setTimeout (->
        `var newPanH`
        $('.domains-panel').css 'display': 'none'
        $('.col-config').find('.panel-cont').animate 'height': newPanH
        window.setTimeout (->
          $('.need-more').animate 'opacity': 1
          return
        ), 500
        return
      ), 500
    else if `$.sliderValue.domains === 11`
      newPanH = conH + disH + domH + neeH
      # DISABLE PREVIOUS SLIDERS
      $('#container-slider, #disk-slider').slider 'option', 'disabled', true
      # SET CURRENT PANEL HEIGHT
      $('.col-config').find('.panel-cont').css 'height': panH
      # PREP NEED MORE FOR INTRO
      $('.need-more').removeClass('hidden-alt').css 'opacity': 0
      # CHANGE THE HEIGHT
      window.setTimeout (->
        $('.col-config').find('.panel-cont').animate 'height': newPanH
        window.setTimeout (->
          $('.need-more').animate 'opacity': 1
          return
        ), 500
        return
      ), 500
    else
  else
    $('.col-summary').find('.panel').addClass('focus-panel').css 'opacity': 1
    $('.col-config').find('.panel').removeClass 'focus-panel'
    # GET hidden-alt PANELS
    $('.hidden-alt-panel').css
      'opacity': 0
      'position': 'absolute'
      'width': $('.domains-panel').width()
    # GET NEW HEIGHT
    origPanH2 = $('.col-config').find('.panel-cont').outerHeight()
    newPanH2 = 0
    $('.slider-section').each ->
      newPanH2 += $(this).outerHeight()
      return
    # RE-ENABLE SLIDERS
    # DISABLE PREVIOUS SLIDERS
    $('#container-slider, #disk-slider, #domain-slider').slider 'option', 'disabled', false
    # RESET hidden-alt PANELS {
    $('.hidden-alt-panel').css
      'opacity': ''
      'position': ''
      'width': ''
    # SET INIT HEIGHT FOR ANIMATION
    $('.col-config').find('.panel-cont').height origPanH2
    # FADE OUT NEED MORE
    $('.need-more').animate { 'opacity': 0 }, 500
    # SCALE THE COLUMN
    window.setTimeout (->
      $('.need-more').addClass 'hidden-alt'
      $('.col-config').find('.panel-cont').animate { 'height': newPanH2 }, 500
      # FADE IN SLIDERS
      window.setTimeout (->
        $('.hidden-alt-slider').animate({ 'opacity': 1 }, 500).css(
          'position': ''
          'display': ''
          'width': '').removeClass 'hidden-alt-panel'
        return
      ), 500
      return
    ), 500
  window.setTimeout (->
    $('.col-config').find('.panel-cont').height ''
    return
  ), 1010
  return






updatePrice = (containers, disk, domains) ->

  doesPriceExist = true

  # SET UPDATED AMOUNTS
  $('.containers-val').text(containers)
  $('.disk-val').text(disk / 5 + 'TB')
  $('.domain-val').text(domains)

  baseCost = 0

  containersBilled = containers
  diskBilled = disk
  domainsBilled = domains

  # IF PHI ON, SUBTRACT INCLUDED FROM VALUE. MINIMUM VAL ZERO
  if $.glob.phi
    baseCost = 499
    containersBilled = Math.max(containers - $.included.containers, 0)
    diskBilled = Math.max(disk - $.included.disk, 0)
    domainsBilled = Math.max(domains - $.included.domains, 0)

  # SET CONTAINER COST
  if (containers < 11) and (containers > 0)
    containersCost = parseFloat(containersBilled * $.price.container).toFixed(2)
    $('.cont-extra').text ' @ $' + containersCost
    $('.cont-price').text '$' + containersCost
  else if containers == 0
    containersCost = 0
    $('.cont-extra').text ''
    $('.cont-price').text '$0.00'
  else
    containersCost = null
    needmore containers
    $('.cont-extra').text ''
    $('.cont-price').text 'Contact us'
    $('.containers-val').text 'I need more'
    containers = 'more'
    doesPriceExist = false


  # SET DISK COST
  if (disk < 11) and (disk > 0)
    diskCost = parseFloat(diskBilled * $.price.disk).toFixed(2)
    $('.dis-extra').text ' @ $' + diskCost
    $('.dis-price').text '$' + diskCost
  else if disk == 0
    diskCost = 0
    $('.dis-extra').text ''
    $('.dis-price').text '$0.00'
  else
    diskCost = null
    needmore disk
    $('.dis-extra').text ''
    $('.dis-price').text 'Contact us'
    $('.disk-val').text 'I need more'
    disk = 'more'
    doesPriceExist = false

  # SET DOMAIN COST
  if (domains < 11) and (domains > 0)
    domainsCost = parseFloat(domainsBilled * $.price.domain).toFixed(2)
    $('.dom-extra').text ' @ $' + domainsCost
    $('.dom-price').text '$' + domainsCost
  else if disk == 0
    domainsCost = 0
    $('.dis-extra').text ''
    $('.dom-price').text '$0.00'
  else
    domiansCost = null
    needmore domains
    $('.dom-extra, .dom-price').text ''
    $('.dom-price').text 'Contact us'
    $('.domain-val').text 'I need more'
    domains = 'more'
    doesPriceExist = false

  #SET TOTAL PRICE
  if doesPriceExist
    needmore()
    totPrice = (parseFloat(baseCost) + parseFloat(domainsCost) + parseFloat(diskCost) + parseFloat(containersCost)).toFixed(2)
    $('.tot-price-number').text '$' + totPrice
  else
    totPrice = 'Unknown'

  #SET URL TO PASS DETAILS TO SIGN UP PAGE
  ctaurl = $('.dev-plat-but').attr('href')
  ctaurl = ctaurl.split('?')[0]
  ctaurl = ctaurl + '?plan=' + $.glob.plan + '&containers=' + containers + '&disk=' + disk  + '&domains=' + domains + '&val=' + totPrice
  $('.dev-plat-but').attr('href', ctaurl)
  return

updatePlan = ->
  `var prS`
  `var deS`

  developmentSummary = $('Development-summary')
  platformSummary = $('.Platform-summary')
  productionSummary = $('.Production-summary')
  keyOverview = $('.key-overview')
  # Unhide hidden-alt summaries to get heights
  deS = developmentSummary.outerHeight()
  prS = platformSummary.outerHeight()

  if developmentSummary.hasClass('hidden-alt')
    developmentSummary.css
      'opacity': 0
      'position': 'absolute'
      'display': 'inline-block'
    deS = developmentSummary.outerHeight()
    developmentSummary.css
      'opacity': 1
      'position': ''
      'display': ''

  if platformSummary.hasClass('hidden-alt')
    platformSummary.css
      'opacity': 0
      'position': 'absolute'
      'display': 'inline-block'
    prS = platformSummary.outerHeight()
    platformSummary.css
      'opacity': 1
      'position': ''
      'display': ''

  # IF ONLY PHI IS CHECKED
  if $.glob.phi and !$.glob.fsc
    keyOverview.animate { 'opacity': 0 },
      duration: 300
      easing: 'swing'
    platformSummary.css 'height': deS
    window.setTimeout (->
      $('.key-overview h3').text 'Platform Account'
      developmentSummary.addClass 'hidden-alt'
      platformSummary.removeClass('hidden-alt').animate { 'height': prS }, 500
      productionSummary.addClass 'hidden-alt'
      $('.pricing-calc').removeClass 'production-account'
      keyOverview.animate { 'opacity': 1 }, 500
      return
    ), 500
    $('.plan-price-tot').text '$499'
    # Animate
    showFSC()
  else if $.glob.phi and $.glob.fsc
    $('.key-overview').animate { 'opacity': 0 },
      duration: 300
      easing: 'swing'
    window.setTimeout (->
      keyOverview.find('h3').text 'Production Account'
      developmentSummary.addClass 'hidden-alt'
      platformSummary.addClass 'hidden-alt'
      productionSummary.removeClass 'hidden-alt'
      $('.pricing-calc').addClass 'production-account'
      keyOverview.animate { 'opacity': 1 },
        duration: 500
        easing: 'swing'
      return
    ), 500
    $('.plan-price-tot').text '$499'
  else
    keyOverview.animate { 'opacity': 0 },
      duration: 300
      easing: 'swing'
    window.setTimeout (->
      $('.plan-price-tot').text '$0'
      keyOverview.find('h3').text 'Development Account'
      developmentSummary.removeClass 'hidden-alt'
      platformSummary.addClass 'hidden-alt'
      productionSummary.addClass 'hidden-alt'
      $('.pricing-calc').removeClass 'production-account'
      keyOverview.animate { 'opacity': 1 },
        duration: 500
        easing: 'swing'
      return
    ), 500
    hideFSC()
  return

FSCchange = ->
  if $('.compliance-checkbox').is(':checked')
    $.glob.fsc = true
    $('.col-config').css
      'opacity': 0
      'display': 'none'
    $('.col-summary').addClass 'large-summary'
    window.setTimeout (->
      $('.production-btn').css 'display': 'inline-block'
      $('.production-btn').animate { 'opacity': 1 }, 500
      return
    ), 500
  else
    $.glob.fsc = false
    $('.compliance-checkbox').prop('checked', false)
    $('.production-btn').animate { 'opacity': 0 }, 500
    window.setTimeout (->
      $('.main-content').width $('.main-content').width()
      $('.col-summary').removeClass 'large-summary'
      $('.production-btn').css 'display': ''
      window.setTimeout (->
        $('.main-content').width $('.main-content').width('')
        $('.col-config').css 'display': ''
        $('.col-config').animate { 'opacity': 1 }, 500
        return
      ), 500
      return
    ), 500
    updatePrice $.sliderValue.containers, $.sliderValue.disk, $.sliderValue.domains

  return

$.glob = new Object
# An object to define internal stuff for the plugin:
$.price = new Object
$.price.container = parseFloat 58.40
$.price.disk = parseFloat 37
$.price.domain = parseFloat 18.25
$.price.base = parseFloat 499
# Platform account included
$.included = new Object
$.included.containers = 4
$.included.disk = 6
$.included.domains = 4
# defaults
$.sliderValue = new Object
$.sliderValue.containers = 2
$.sliderValue.disk = 2
$.sliderValue.domains = 2
$.glob.phi = false
$.glob.plan = 'development'
# First of all, lets generate the sliders

$(document).ready ->

  ###
  INITIALIZE SLIDERS
  ###
  $('#container-slider').slider
    min: 1
    max: 11
    value: $.sliderValue.containers
    step: 1
    animate: 'slow'
    slide: (event, ui) ->
      $.sliderValue.containers = ui.value
      updateKey containerSlider, ui.value
      writeValAttr containerSlider, ui.value
      updatePrice ui.value, $.sliderValue.disk, $.sliderValue.domains
      blueBar ui.value, $.sliderValue.disk, $.sliderValue.domains
      return
  $('#disk-slider').slider
    min: 1
    max: 11
    value: $.sliderValue.disk
    step: 1
    animate: 'slow'
    slide: (event, ui) ->
      $.sliderValue.disk = ui.value
      updateKey diskSlider, ui.value
      writeValAttr diskSlider, ui.value
      updatePrice $.sliderValue.containers, ui.value, $.sliderValue.domains
      blueBar $.sliderValue.containers, ui.value, $.sliderValue.domains
      return
  $('#domain-slider').slider
    min: 1
    max: 11
    value: $.sliderValue.domains
    step: 1
    animate: 'slow'
    slide: (event, ui) ->
      $.sliderValue.domains = ui.value
      updateKey domainSlider, ui.value
      writeValAttr domainSlider, ui.value
      updatePrice $.sliderValue.containers, $.sliderValue.disk, ui.value
      blueBar $.sliderValue.containers, $.sliderValue.disk, ui.value
      return


  scaleIncluded()

  ###
  SET INITIAL VALUES
  ###

  # initial user values
  writeValAttr containerSlider, $.sliderValue.containers
  writeValAttr domainSlider, $.sliderValue.domains
  writeValAttr diskSlider, $.sliderValue.disk

  # keys
  updateKey containerSlider, $.sliderValue.containers
  updateKey domainSlider, $.sliderValue.domains
  updateKey diskSlider, $.sliderValue.disk

  # price
  updatePrice $.sliderValue.containers, $.sliderValue.disk, $.sliderValue.domains

  # hide full service compliance
  hideFSC

  # Start listening for toggle changes
  $('#PHIcheck input').change ->
    PHIchange()
    updatePlan()
    return
  $('#FSCcheck input').change ->
    FSCchange()
    updatePlan()
    return

  # update the blue bar
  blueBar $.sliderValue.containers, $.sliderValue.disk, $.sliderValue.domains
  return