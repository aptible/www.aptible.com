$ ->
  class PriceCalculator
    # Mutable Attributes
    containers     : 4
    disks          : 6
    endpoints      : 4
    vpnConnections : 0

    # Included
    incContainers  : 4
    incDisks       : 6
    incEndpoints   : 4

    containerValuesGB: [0, 1, 2, 4, 6, 8, 12, 16, 32, 64, 128]
    diskValuesGB     : [0, 10, 50, 100, 250, 500, 1000, 1500, 2000, 3000, 4000]

    # Prices
    # ~730 hours in a month
    perContainer     : (0.08 * 730).toFixed 2
    perDisk          : (gb) -> (0.37 * gb).toFixed 2
    perEndpoint      : (0.05 * 730).toFixed 2
    perVpnConnection : 99
    perMonthBase     : 999
    perHIDSContainer : (0.02 * 730).toFixed 2

    managedHIDSEnabled: false

    setValue: (attr, value) -> @[attr] = value

    containersCost: (format = true) ->
      includedContainers = @containerValuesGB[@incContainers]
      containers = @containerValuesGB[if @containers > 10 then 10 else @containers]
      cost = Math.max(((containers - includedContainers) * @perContainer), 0)
      if @managedHIDSEnabled
        hidsCost = containers * @perHIDSContainer
        cost += hidsCost
      if format then @toCurrency(cost) else cost

    disksCost: (format = true) ->
      includedGB = @diskValuesGB[@incDisks]
      diskGB = @diskValuesGB[if @disks > 10 then 10 else @disks]
      gb = Math.max(diskGB - includedGB, 0)
      cost = parseFloat(@perDisk(gb))
      if format then @toCurrency(cost) else cost

    endpointsCost: (format = true) ->
      endpoints = if @endpoints > 10 then 10 else @endpoints
      cost = Math.max(((endpoints - @incEndpoints) * @perEndpoint), 0)
      if format then @toCurrency(cost) else cost

    vpnConnectionsCost: (format = true) ->
      connections = if @vpnConnections > 10 then 10 else @vpnConnections
      cost = Math.max(connections * @perVpnConnection, 0)
      if format then @toCurrency(cost) else cost

    baseCost: (format = true) ->
      if format then @toCurrency(@perMonthBase) else @perMonthBase

    price: ->
      @toCurrency(
        @baseCost(false) + @containersCost(false) + @disksCost(false) +
        @endpointsCost(false) + @vpnConnectionsCost(false)
      )

    # Formats with commas and ~~fixed cents~~ rounding to dollars
    toCurrency: (num) ->
      # num.toFixed(2).replace(/(\d)(?=(\d{3})+\.)/g, '$1,')
      Math.round(num).toLocaleString();
  # } End PriceCalculator object definition

  #
  # Hook up the UI to the PriceCalculator object
  # Check for DOM elements, bind update events
  #
  $priceCalc = $ '.price-calc'

  # Only run on the pricing page...
  if $priceCalc.length > 0

    $doc = $ document
    # Model / State
    window.priceCalc = new PriceCalculator()

    # DOM "Views"
    $containersInput     = $ 'input[data-type="containers"]'
    $disksInput          = $ 'input[data-type="disks"]'
    $endpointsInput      = $ 'input[data-type="endpoints"]'
    $vpnConnectionsInput = $ 'input[data-type="vpn-connections"]'
    $managedHIDSInput    = $ 'input[data-type="managed-hids"]'
    $containerUnitPrice =  $ '.price-calc__unit.price-calc__unit--containers
                              .price-calc__unit__price'

    $rangeKeys = {
      containers     : $ '.price-calc__range-keys[data-type="containers"]'
      disks          : $ '.price-calc__range-keys[data-type="disks"]'
      endpoints      : $ '.price-calc__range-keys[data-type="endpoints"]'
      vpnConnections : $ '.price-calc__range-keys[data-type="vpn-connections"]'
    }

    $priceViews = {
      containers    : $ '.price-calc__item-price--containers'
      disks         : $ '.price-calc__item-price--disks'
      endpoints     : $ '.price-calc__item-price--endpoints'
      vpnConnections: $ '.price-calc__item-price--vpn-connections'
      total         : $ '.price-calc__monthly-total'
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
        item = 'vpnConnections' if item is 'vpn-connections'
        # Skip if no value change or one of the sliders is at the +
        return if priceCalc[item] is value
        # Focus the handle
        @$element.focus() unless @$element.is(':focus')
        # Update the model
        priceCalc.setValue(item, value)
        # Trigger updates
        $doc.trigger 'updateViews', [priceCalc]

    $managedHIDSInput.on 'change', (event) ->
      priceCalc.managedHIDSEnabled = $(event.target).prop('checked')
      $doc.trigger 'updateViews', [priceCalc]

    urlToPriceCalc = (priceCalc) ->
      # remove ?, split on &, and iterate
      location.search.substring(1).split('&').forEach (param) ->
        keyVal = param.split('=')
        switch keyVal[0]
          when 'hids'
            priceCalc.managedHIDSEnabled = !!parseInt(keyVal[1])
          when 'containers'
            priceCalc.containers = keyVal[1]
          when 'disks'
            priceCalc.disks = keyVal[1]
          when 'endpoints'
            priceCalc.endpoints = keyVal[1]
          when 'vpn-connections'
            priceCalc.vpnConnections = keyVal[1]

    priceCalcToUrl = (priceCalc) ->
      params = []
      hidsVal = if priceCalc.managedHIDSEnabled then '1' else '0'
      params.push "hids=#{hidsVal}"
      params.push "containers=#{priceCalc.containers}"
      params.push "disks=#{priceCalc.disks}"
      params.push "endpoints=#{priceCalc.endpoints}"
      params.push "vpn-connections=#{priceCalc.vpnConnections}"
      searchString = "?#{params.join('&')}"
      if searchString isnt location.search and history.replaceState
        url = location.href.replace(location.search, '') + searchString
        window.history.replaceState({ path: url }, '', url);

    #
    # DOM / View Event Handlers
    #
    $doc.on 'updateViews', (event, priceCalc) ->
      # Containers
      $containersInput.val(priceCalc.containers).change()
      setSliderKey $rangeKeys.containers, priceCalc.containers
      $priceViews.containers.html priceCalc.containersCost()

      # Disks
      $disksInput.val(priceCalc.disks).change()
      setSliderKey $rangeKeys.disks, priceCalc.disks
      $priceViews.disks.html priceCalc.disksCost()

      # Endpoints
      $endpointsInput.val(priceCalc.endpoints).change()
      setSliderKey $rangeKeys.endpoints, priceCalc.endpoints
      $priceViews.endpoints.html priceCalc.endpointsCost()

      # VPN Connections
      $vpnConnectionsInput.val(priceCalc.vpnConnections).change()
      setSliderKey $rangeKeys.vpnConnections, priceCalc.vpnConnections
      $priceViews.vpnConnections.html priceCalc.vpnConnectionsCost()

      # Managed HIDS
      if priceCalc.managedHIDSEnabled
        $containerUnitPrice.html('$0.10/GB/hour')
        unless $managedHIDSInput.is(':checked')
          $managedHIDSInput.attr('checked', 'checked').change()
      else
        $containerUnitPrice.html('$0.08/GB/hour')
        if $managedHIDSInput.is(':checked')
          $managedHIDSInput.removeAttr('checked').change()

      # Total
      $priceViews.total.html priceCalc.price()

      # Update URL
      priceCalcToUrl(priceCalc)

    # Initialize Views
    urlToPriceCalc(priceCalc) if location.search isnt ''
    $doc.trigger 'updateViews', [priceCalc]
