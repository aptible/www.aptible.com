# An object to define utility functions and global variables on:

blueBar = (con, dis, dom) ->
  contBlueWid = (con - 1) * 10 + '%'
  disBlueWid = (dis - 1) * 10 + '%'
  domBlueWid = (dom - 1) * 10 + '%'
  if !$('.bluebar').length
    $('.container-slider').prepend '<div class="bluebar" style="width:' + contBlueWid + '"></div>'
    $('.disk-slider').prepend '<div class="bluebar" style="width:' + disBlueWid + '"></div>'
    $('.domain-slider').prepend '<div class="bluebar" style="width:' + domBlueWid + '"></div>'
  else
    $('.container-slider .bluebar').width contBlueWid
    $('.disk-slider .bluebar').width disBlueWid
    $('.domain-slider .bluebar').width domBlueWid
  return

# Write the value of the slider as an attribute, only on
# USER change. This means we can revert in certain
# situations.

writeValAttr = (id, val) ->
  $(id).attr 'userval', val
  return

# Trigger things when
# PHI is changed

PHIchange = ->
  `var ctaurl`
  if $('.phi-checkbox').is(':checked')

    $.glob.plan = 'platform'
    $.glob.phi = true
    $('.included').removeClass 'hidden-alt'
    # Move the container slider
    if $('#container-slider').slider('option', 'value') < $.glob.inc.con
      $('#container-slider').slider 'value', $.glob.inc.con
      updateKey '.containers-keys', $.glob.inc.con
      $.glob.slide.con = $.glob.inc.con
    # Move the disk slider
    if $('#disk-slider').slider('option', 'value') < $.glob.inc.dis
      $('#disk-slider').slider 'value', $.glob.inc.dis
      updateKey '.disk-key', $.glob.inc.dis
      $.glob.slide.dis = $.glob.inc.dis
    # Move the domains slider
    if $('#domain-slider').slider('option', 'value') < $.glob.inc.dom
      $('#domain-slider').slider 'value', $.glob.inc.dom
      updateKey '.domains-key', $.glob.inc.dom
      $.glob.slide.dom = $.glob.inc.dom
    updatePrice $.glob.slide.con, $.glob.slide.dis, $.glob.slide.dom
    blueBar $.glob.slide.con, $.glob.slide.dis, $.glob.slide.dom

    showFSC()

  else
    # Reverting back to non-PHI, undoing any changes made
    # hide full-service compliance option WITH animation
    $.glob.phi = false

    $('.included').addClass 'hidden-alt'
    if $('#container-slider').attr('userval') < $('#container-slider').slider('option', 'value')
      $('#container-slider').slider 'value', $('#container-slider').attr('userval')
      updateKey '.containers-keys', $('#container-slider').attr('userval')
      $.glob.slide.con = $('#container-slider').attr('userval')
    if $('#disk-slider').attr('userval') < $('#disk-slider').slider('option', 'value')
      $('#disk-slider').slider 'value', $('#disk-slider').attr('userval')
      updateKey '.disk-key', $('#disk-slider').attr('userval')
      $.glob.slide.dis = $('#disk-slider').attr('userval')
    if $('#domain-slider').attr('userval') < $('#domain-slider').slider('option', 'value')
      $('#domain-slider').slider 'value', $('#domain-slider').attr('userval')
      updateKey '.domains-key', $('#domain-slider').attr('userval')
      $.glob.slide.dom = $('#domain-slider').attr('userval')

    if $('.compliance-checkbox').is(':checked')
      $('.compliance-checkbox').prop('checked', false)
      FSCchange()

    $.glob.plan = 'development'

    updatePrice $.glob.slide.con, $.glob.slide.dis, $.glob.slide.dom
    blueBar $('#container-slider').slider('option', 'value'), $('#disk-slider').slider('option', 'value'), $('#domain-slider').slider('option', 'value')

  return

# Trigger things when full service
# compliance is changed

hideFSC = ->
  ttH = $('.col-settings').find('.pricing-title').outerHeight()
  ppH = $('.panel-phi').outerHeight()
  pcH = $('.panel-compliance').outerHeight()
  prCH = ppH + ttH + 2;
    
  $('.panel-compliance').animate {
    'opacity': 0
  }, 500
  window.setTimeout (->
      $('.col-settings > .panel').animate {
        'height': prCH
      }, 500
      $('.panel-compliance').addClass 'hidden-alt'
      window.setTimeout (->
          $('.col-settings > .panel').css {
            'height': ''
          }, 500
          return
        ), 500
      return
    ), 500

  return

showFSC = ->
  ttH = $('.col-settings').find('.pricing-title').outerHeight()
  ppH = $('.panel-phi').outerHeight()
  initprCH = $('.col-settings > .panel').outerHeight()

  $('.col-settings > .panel').height(initprCH)

  $('.panel-compliance').css {
    'opacity': 0
  }
  $('.panel-compliance').removeClass 'hidden-alt'

  pcH = $('.panel-compliance').outerHeight()
  prCH = ppH + pcH + ttH;
  $('.col-settings > .panel').animate {
    'height': prCH
  }, 500
  
  window.setTimeout (->
      $('.panel-compliance').animate {
        'opacity' : 1
      }, 500
      $('.col-settings > .panel').css {
        'height': ''
      }, 500
      return
    ), 500
  return

updateKey = (id, val) ->
  $(id + ' li').removeClass 'selected-key'
  $(id + ' .key-' + val).addClass 'selected-key'
  return

scaleInc = ->
  $('#container-inc-scale').width ($.glob.inc.con - 1.2) * 10 + '%'
  $('#disk-inc-scale').width ($.glob.inc.dis - 1.2) * 10 + '%'
  $('#domain-inc-scale').width ($.glob.inc.dom - 1.2) * 10 + '%'
  return

needmore = (type) ->
  if !type and !$('.total-wrap').hasClass('hidden-alt-total-wrap')
    # do nothing
  else if !type and $('.total-wrap').hasClass('hidden-alt-total-wrap')
    # NEED MORE to NORMAL
    needmoreslidersshow false
    origH = $('.total-wrap').outerHeight()
    $('.total-wrap').height('').css 'position': 'absolute'
    newH = $('.total-wrap').outerHeight()
    $('.total-wrap').height(origH).css 'position': ''
    $('.total-wrap').animate { 'height': newH }, 500
    window.setTimeout (->
      $('.total-wrap').animate { 'opacity': 1 }, 500
      return
    ), 500
    $('.total-wrap').removeClass 'hidden-alt-total-wrap'
  else if !$('.total-wrap').hasClass('hidden-alt-total-wrap')
    # NORMAL TO NEED MORE
    needmoreslidersshow true
    origH = $('.total-wrap').outerHeight()
    $('.total-wrap').height('').css 'position': 'absolute'
    newH = $('.total-wrap').outerHeight()
    $('.total-wrap').height(origH).css 'position': ''
    $('.total-wrap').animate { 'opacity': 0 }, 500
    window.setTimeout (->
      $('.total-wrap').animate { 'height': '1px' }, 500
      return
    ), 500
    $('.total-wrap').addClass 'hidden-alt-total-wrap'
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
    if `$.glob.slide.con === 11`
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
    else if `$.glob.slide.dis === 11`
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
    else if `$.glob.slide.dom === 11`
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

updatePrice = (con, dis, dom) ->
  `var domcurr`
  `var discurr`
  `var concurr`
  `var price`
  `var dom`
  `var domval`
  `var domval`
  `var disval`
  `var dis`
  `var dis`
  `var disval`
  `var conval`
  `var con`
  `var conval`
  `var urlprice`
  `var conurl`
  `var disur`
  `var domurl`

  # CONTAINERS
  if con < 11
    if $.glob.phi
      conval = parseFloat($.glob.price.con * (con - ($.glob.inc.con))).toFixed(2)
    else
      conval = parseFloat($.glob.price.con * con).toFixed(2)
    conval = Math.max(conval, 0).toFixed(2)
    conurl = con
  else
    conurl = 'more'
    con = 'I need more'
    conval = 'Contact us'
  # DISK SPACE
  if dis < 11
    if $.glob.phi
      disval = $.glob.price.dis * (dis - ($.glob.inc.dis))
    else
      disval = $.glob.price.dis * dis
    disval = Math.max(disval, 0).toFixed(2)
    dis = dis / 5 + 'TB'
    disurl = dis
  else
    disurl = 'more'
    dis = 'I need more'
    disval = 'Contact us'
  # DOMAINS
  if dom < 11
    if $.glob.phi
      domval = $.glob.price.dom * (dom - ($.glob.inc.dom))
    else
      domval = $.glob.price.dom * dom
    domval = Math.max(domval, 0).toFixed(2)
    domurl = dom
  else
    domurl = 'more'
    domval = 'Contact us'
    dom = 'I need more'
  # WORK OUT THE TOTAL PRICE
  if $.glob.phi
    price = parseFloat($.glob.price.base) + parseFloat(domval) + parseFloat(disval) + parseFloat(conval)
  else
    price = parseFloat(domval) + parseFloat(disval) + parseFloat(conval)
  curr = '$'
  concurr = ''
  discurr = ''
  domcurr = ''
  if $.isNumeric(conval)
    concurr = curr
    if conval > 0
      $('.cont-extra').text ' @ $' + parseFloat(conval).toFixed(2)
    else
      $('.cont-extra').text ''
  else
    needmore con
    $('.cont-extra').text ''
  if $.isNumeric(disval)
    discurr = curr
    if disval > 0
      $('.dis-extra').text ' @ $' + parseFloat(disval).toFixed(2)
    else
      $('.dis-extra').text ''
  else
    needmore dis
    $('.dis-extra').text ''
  if $.isNumeric(domval)
    domcurr = curr
    if domval > 0
      $('.dom-extra').text ' @ $' + parseFloat(domval).toFixed(2)
    else
      $('.dom-extra').text ''
  else
    needmore dom
    $('.dom-extra').text ''
  if $.isNumeric(conval) and $.isNumeric(disval) and $.isNumeric(domval)
    $('.tot-price-number').text curr + price.toFixed(2)
    urlprice = price
    needmore()
  $('.cont-price').text concurr + conval
  $('.containers-val').text con
  $('.dis-price').text discurr + disval
  $('.disk-val').text dis
  $('.dom-price').text domcurr + domval
  $('.domain-val').text dom

  con = con + ''.split(' ').join('_')
  dom = dom + ''.split(' ').join('_')
  dis = dis + ''.split(' ').join('_')

  if urlprice is undefined
    urlprice = 'enquire'

  ctaurl = $('.dev-plat-but').attr('href')
  ctaurl = ctaurl.split('?')[0]
  ctaurl = ctaurl + '?plan=' + $.glob.plan + '&containers=' + conurl + '&disk=' + disurl  + '&domains=' + domurl + '&val=' + urlprice
  $('.dev-plat-but').attr('href', ctaurl)
  return

updatePlan = ->
  `var prS`
  `var deS`
  # Unhide hidden-alt summaries to get heights
  deS = $('.Development-summary').outerHeight()
  prS = $('.Platform-summary').outerHeight()
  if $('.Development-summary').hasClass('hidden-alt')
    $('.Development-summary').css
      'opacity': 0
      'position': 'absolute'
      'display': 'inline-block'
    deS = $('.Development-summary').outerHeight()
    $('.Development-summary').css
      'opacity': 1
      'position': ''
      'display': ''
  if $('.Platform-summary').hasClass('hidden-alt')
    $('.Platform-summary').css
      'opacity': 0
      'position': 'absolute'
      'display': 'inline-block'
    prS = $('.Platform-summary').outerHeight()
    $('.Platform-summary').css
      'opacity': 1
      'position': ''
      'display': ''
  if $.glob.phi and !$.glob.fsc
    $('.key-overview').animate { 'opacity': 0 },
      duration: 300
      easing: 'swing'
    $('.Platform-summary').css 'height': deS
    window.setTimeout (->
      $('.key-overview h3').text 'Platform Account'
      $('.Development-summary').addClass 'hidden-alt'
      $('.Platform-summary').removeClass('hidden-alt').animate { 'height': prS }, 500
      $('.Production-summary').addClass 'hidden-alt'
      $('.pricing-calc').removeClass 'production-account'
      $('.key-overview').animate { 'opacity': 1 }, 500
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
      $('.key-overview h3').text 'Production Account'
      $('.Development-summary').addClass 'hidden-alt'
      $('.Platform-summary').addClass 'hidden-alt'
      $('.Production-summary').removeClass 'hidden-alt'
      $('.pricing-calc').addClass 'production-account'
      $('.key-overview').animate { 'opacity': 1 },
        duration: 500
        easing: 'swing'
      return
    ), 500
    $('.plan-price-tot').text '$499'
  else
    $('.key-overview').animate { 'opacity': 0 },
      duration: 300
      easing: 'swing'
    window.setTimeout (->
      $('.plan-price-tot').text '$0'
      $('.key-overview h3').text 'Development Account'
      $('.Development-summary').removeClass 'hidden-alt'
      $('.Platform-summary').addClass 'hidden-alt'
      $('.Production-summary').addClass 'hidden-alt'
      $('.pricing-calc').removeClass 'production-account'
      $('.key-overview').animate { 'opacity': 1 },
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
    updatePrice $.glob.slide.con, $.glob.slide.dis, $.glob.slide.dom

  return

$.glob = new Object
# An object to define internal stuff for the plugin:
$.glob.price = new Object
$.glob.price.con = 58.40
$.glob.price.dis = 37
$.glob.price.dom = 18.25
$.glob.price.base = 499
# Platform account included
$.glob.inc = new Object
$.glob.inc.con = 4
$.glob.inc.dis = 6
$.glob.inc.dom = 4
# defaults
$.glob.slide = new Object
$.glob.slide.con = 2
$.glob.slide.dis = 2
$.glob.slide.dom = 2
$.glob.phi = false
$.glob.plan = 'development'
# First of all, lets generate the sliders

$(document).ready ->
  $('#container-slider').slider
    min: 1
    max: 11
    value: $.glob.slide.con
    step: 1
    animate: 'slow'
    slide: (event, ui) ->
      $.glob.slide.con = ui.value
      updateKey '.containers-keys', ui.value
      writeValAttr '#container-slider', ui.value
      updatePrice ui.value, $.glob.slide.dis, $.glob.slide.dom
      blueBar ui.value, $.glob.slide.dis, $.glob.slide.dom
      return
  $('#disk-slider').slider
    min: 1
    max: 11
    value: $.glob.slide.dis
    step: 1
    animate: 'slow'
    slide: (event, ui) ->
      $.glob.slide.dis = ui.value
      updateKey '.disk-key', ui.value
      writeValAttr '#disk-slider', ui.value
      updatePrice $.glob.slide.con, ui.value, $.glob.slide.dom
      blueBar $.glob.slide.con, ui.value, $.glob.slide.dom
      return
  $('#domain-slider').slider
    min: 1
    max: 11
    value: $.glob.slide.dom
    step: 1
    animate: 'slow'
    slide: (event, ui) ->
      $.glob.slide.dom = ui.value
      updateKey '.domains-key', ui.value
      writeValAttr '#domain-slider', ui.value
      updatePrice $.glob.slide.con, $.glob.slide.dis, ui.value
      blueBar $.glob.slide.con, $.glob.slide.dis, ui.value
      return

  scaleInc()
  writeValAttr '#container-slider', $.glob.slide.con
  writeValAttr '#domain-slider', $.glob.slide.dom
  writeValAttr '#disk-slider', $.glob.slide.dis
  updatePrice $.glob.slide.con, $.glob.slide.dis, $.glob.slide.dom
  hideFSC

  $('#PHIcheck input').change ->
    PHIchange()
    updatePlan()
    return
  $('#FSCcheck input').change ->
    FSCchange()
    updatePlan()
    return
  blueBar $.glob.slide.con, $.glob.slide.dis, $.glob.slide.dom
  return

# $(window).resize ->
#   if $(window).width < '1170'
#     $('.main-content').css 'max-width': $(window).width()
#   else
#     $('.main-content').css 'max-width': '1170px'
#   return