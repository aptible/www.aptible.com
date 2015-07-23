$ ->
  $priceCalc = $ '.price-calc'

  # Only run on the pricing page...
  if $priceCalc.length > 0
    
    $doc = $ document
    # Model / State
    window.priceCalc = new PriceCalculator()

    # DOM "Views"
    $phiToggle          = $ '.toggle[data-name="phi"]'
    $fullServiceToggle  = $ '.toggle[data-name="full-service"]'

    # TODO: Group containers, disks, domains with input, rangeKey, amount, & price

    $containersInput    = $ 'input[data-type="containers"]'
    $disksInput         = $ 'input[data-type="disks"]'
    $domainsInput       = $ 'input[data-type="domains"]'

    $priceCalcButton    = $ '.price-calc__submit'

    $rangeKeys = {
      containers: $ '.price-calc__range-keys[data-type="containers"]'
      disks     : $ '.price-calc__range-keys[data-type="disks"]'
      domains   : $ '.price-calc__range-keys[data-type="domains"]'
    }

    $amountViews = {
      containers: $ '.price-calc__item-value--containers'
      disks     : $ '.price-calc__item-value--disks'
      domains   : $ '.price-calc__item-value--domains'
      plan      : $ '.price-calc__plan-value'
    }

    $priceViews = {
      containers: $ '.price-calc__item-price--containers'
      disks     : $ '.price-calc__item-price--disks'
      domains   : $ '.price-calc__item-price--domains'
      plan      : $ '.price-calc__plan-price'
      total     : $ '.price-calc__monthly-total'
    }

    #
    # Input sliders
    # Rangeslider.js for touch support (Heroku uses this)
    #
    $ranges = $ 'input[type="range"]'

    # Slider Helper
    setSliderKey = ($keys, index) ->
      $keys.find("[data-state='selected']").attr('data-state', '')
      $keys.find('.price-calc__range-key')
        .eq(index).attr 'data-state', 'selected'

    $ranges.rangeslider
      polyfill: false
      onSlide: (position, value) ->
        item = @$element.data 'type'
        # Skip if no value change or one of the sliders is at the +
        return if priceCalc[item] is value
        # Focus the handle
        @$element.focus() unless @$element.is(':focus')
        # Update the model
        priceCalc[item] = value
        # Trigger updates
        $doc.trigger 'updateViews', [priceCalc]

    #
    # Toggles
    # Update model / state and trigger global event for views
    $phiToggle.on 'click', ->
      priceCalc.handlesPHI = $priceCalc.attr('data-phi') isnt 'on'
      priceCalc.setDevBaseValues() if priceCalc.handlesPHI
      priceCalc.fullService = false unless priceCalc.handlesPHI
      $doc.trigger 'updateViews', [priceCalc]
      false

    $fullServiceToggle.on 'click', ->
      priceCalc.fullService = $priceCalc.attr('data-full-service') isnt 'on'
      $doc.trigger 'updateViews', [priceCalc]
      false

    #
    # Cancel submit button when needing more
    #
    $priceCalcButton.on 'click', -> !priceCalc.needsMore()

    #
    # DOM / View Event Handlers
    #
    $doc.on 'updateViews', (event, priceCalc) ->
      # handlesPHI
      $phiToggle.attr 'data-state', priceCalc.toOnOff('handlesPHI')
      $priceCalc.attr 'data-phi', priceCalc.toOnOff('handlesPHI')
      $amountViews.plan.html priceCalc.baseCost()
      $priceViews.plan.html priceCalc.baseCost()

      # fullService
      $fullServiceToggle.attr 'data-state', priceCalc.toOnOff('fullService')
      $priceCalc.attr 'data-full-service', priceCalc.toOnOff('fullService')

      # Containers
      $containersInput.val(priceCalc.containers).change()
      setSliderKey $rangeKeys.containers, priceCalc.containers
      unless priceCalc.containers > 10
        $amountViews.containers.html priceCalc.containers
        $priceViews.containers.html priceCalc.containersCost()

      # Disks
      $disksInput.val(priceCalc.disks).change()
      setSliderKey $rangeKeys.disks, priceCalc.disks
      unless priceCalc.disks > 10
        $amountViews.disks.html priceCalc.diskSize()
        $priceViews.disks.html priceCalc.disksCost()


      # Domains
      $domainsInput.val(priceCalc.domains).change()
      setSliderKey $rangeKeys.domains, priceCalc.domains
      unless priceCalc.domains > 10
        $amountViews.domains.html priceCalc.domains
        $priceViews.domains.html priceCalc.domainsCost()

      $priceCalc.attr 'data-needs-more', priceCalc.needsMoreOnOff()

      # Total
      $priceViews.total.html priceCalc.price()

      # Button
      baseUrl = $priceCalcButton.attr('href').split('?')[0]
      $priceCalcButton.attr 'href', "#{baseUrl}?#{$.param(priceCalc.toParams())}"
      if priceCalc.needsMore()
        $priceCalcButton.attr 'disabled', 'disabled'
      else
        $priceCalcButton.removeAttr 'disabled'

    # Initialize Views
    $doc.trigger 'updateViews', [priceCalc]
