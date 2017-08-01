$ ->
  class PriceCalculator
    # Mutable Attributes
    containers     : 6
    disks          : 8
    endpoints      : 4
    vpnConnections : 0

    # Included
    incContainers  : 6
    incDisks       : 8
    incEndpoints   : 4

    containerValues: []
    containerLabels: []

    diskValuesGB   : [0, 10, 20, 50, 100, 250, 500, 750, 1000, 1500, 2000]
    diskLabels     : ['0 GB', '10 GB', '20 GB', '50 GB', '100 GB', '250 GB',
                     '500 GB', '750 GB', '1 TB', '1.5 TB', '2 TB']

    # Prices
    # ~730 hours in a month
    perContainer     : (0.08 * 730).toFixed 2
    perDisk          : (gb) -> (0.37 * gb).toFixed 2
    perEndpoint      : (0.05 * 730).toFixed 2
    perVpnConnection : 99
    perMonthBase     : 999

    setValue: (attr, value) -> @[attr] = value

    diskSize: -> @diskLabels[@disks]

    containersCost: ->
      includedContainers = @incContainers
      containers = if @containers > 10 then 10 else @containers
      @toCurrency Math.max(((containers - includedContainers) * @perContainer), 0)

    disksCost: ->
      includedGB = @diskValuesGB[@incDisks]
      diskGB = @diskValuesGB[if @disks > 10 then 10 else @disks]
      gb = Math.max(diskGB - includedGB, 0)
      @toCurrency parseFloat(@perDisk(gb))

    endpointsCost: ->
      endpoints = if @endpoints > 10 then 10 else @endpoints
      @toCurrency Math.max(((endpoints - @incEndpoints) * @perEndpoint), 0)

    vpnConnectionsCost: ->
      connections = if @vpnConnections > 10 then 10 else @vpnConnections
      @toCurrency Math.max(connections * @perVpnConnection, 0)

    baseCost: -> @toCurrency(@perMonthBase)

    price: ->
      @toCurrency(
        parseFloat(@baseCost()) +
        parseFloat(@containersCost()) +
        parseFloat(@disksCost()) +
        parseFloat(@endpointsCost()) +
        parseFloat(@vpnConnectionsCost())
      )

    needsMore: ->
      @containers > 10 || @disks > 10 || @endpoints > 10 || @vpnConnections > 10

    # Formats with commas and ~~fixed cents~~ rounding to dollars
    toCurrency: (num) ->
      # num.toFixed(2).replace(/(\d)(?=(\d{3})+\.)/g, '$1,')
      Math.round(num).toString().replace(/(\d)(?=(\d{3}))/g, '$1,')
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

    #
    # DOM / View Event Handlers
    #
    $doc.on 'updateViews', (event, priceCalc) ->
      # Containers
      $containersInput.val(priceCalc.containers).change()
      setSliderKey $rangeKeys.containers, priceCalc.containers
      unless priceCalc.containers > 10
        $priceViews.containers.html priceCalc.containersCost()

      # Disks
      $disksInput.val(priceCalc.disks).change()
      setSliderKey $rangeKeys.disks, priceCalc.disks
      unless priceCalc.disks > 10
        $priceViews.disks.html priceCalc.disksCost()

      # Endpoints
      $endpointsInput.val(priceCalc.endpoints).change()
      setSliderKey $rangeKeys.endpoints, priceCalc.endpoints
      unless priceCalc.endpoints > 10
        $priceViews.endpoints.html priceCalc.endpointsCost()

      # VPN Connections
      $vpnConnectionsInput.val(priceCalc.vpnConnections).change()
      setSliderKey $rangeKeys.vpnConnections, priceCalc.vpnConnections
      unless priceCalc.vpnConnections > 10
        $priceViews.vpnConnections.html priceCalc.vpnConnectionsCost()

      # Total
      $priceViews.total.html priceCalc.price()

    # Initialize Views
    $doc.trigger 'updateViews', [priceCalc]
