#
# PriceCalculator
#
# Local Object for state management and formatting helpers for that state.
# Requires jQuery, broadcasts update events on $(document)
# DOM controls (links, inputs) update this object
#
class PriceCalculator
  # Mutable Attributes
  handlesPHI    : false
  fullService   : false
  containers    : 2
  disks         : 1
  domains       : 1
  prevContainers: 0
  prevDisks     : 0
  prevDomains   : 0

  # Fixed
  phiContainers : 6
  phiDisks      : 8
  phiDomains    : 4

  diskValuesGB  : [0, 10, 20, 50, 100, 250, 500, 750, 1000, 1500, 2000]
  diskLabels    : ['0 GB', '10 GB', '20 GB', '50 GB', '100 GB', '250 GB',
                   '500 GB', '750 GB', '1 TB', '1.5 TB', '2 TB']

  # Prices
  # ~730 hours in a month
  perContainer  : (0.08 * 730).toFixed 2
  perDisk       : (gb) -> (0.37 * gb).toFixed 2
  perDomain     : (0.05 * 730).toFixed 2
  phiBaseCost   : 499

  # Retain higher values if set, only up to what's included
  setDevBaseValues: ->
    if @handlesPHI
      @prevContainers = @containers
      @prevDisks = @disks
      @prevDomains = @domains
      @containers = Math.max(@containers, @phiContainers)
      @disks = Math.max(@disks, @phiDisks)
      @domains = Math.max(@domains, @phiDomains)
    else # restore
      @containers = @prevContainers
      @disks = @prevDisks
      @domains = @prevDomains

  # Aids restoring values on a PHI toggle.
  # This ensures that the restore values are updated correctly if the selection
  # is above or at the included dev values
  setValue: (attr, value) ->
    attrCap = attr[0].toUpperCase() + attr[1..]
    @["prev#{attrCap}"] = value if @handlesPHI and value >= @["phi#{attrCap}"]
    @[attr] = value

  diskSize: -> @diskLabels[@disks]

  containersCost: ->
    includedContainers = if @handlesPHI then @phiContainers else 0
    containers = if @containers > 10 then 10 else @containers
    @toCurrency Math.max(((containers - includedContainers) * @perContainer), 0)

  disksCost: ->
    includedGB = @diskValuesGB[if @handlesPHI then @phiDisks else 0]
    diskGB = @diskValuesGB[if @disks > 10 then 10 else @disks]
    gb = Math.max(diskGB - includedGB, 0)
    @toCurrency parseFloat(@perDisk(gb))

  domainsCost: ->
    includedDomains = if @handlesPHI then @phiDomains else 0
    domains = if @domains > 10 then 10 else @domains
    @toCurrency Math.max(((domains - includedDomains) * @perDomain), 0)

  baseCost: ->
    @toCurrency(if @handlesPHI then @phiBaseCost else 0)

  price: ->
    @toCurrency(
      parseFloat(@baseCost()) +
      parseFloat(@containersCost()) +
      parseFloat(@disksCost()) +
      parseFloat(@domainsCost())
    )

  plan: ->
    if @handlesPHI
      'plantform'
    else if @fullService
      'managed'
    else
      'development'

  needsMore: ->
    @containers > 10 || @disks > 10 || @domains > 10

  needsMoreOnOff: ->
    if @needsMore() and not @fullService then 'on' else 'off'

  # Formats with commas and fixed cents
  toCurrency: (num) ->
    num.toFixed(2).replace /(\d)(?=(\d{3})+\.)/g, '$1,'

  toOnOff: (attr) ->
    if @[attr] then 'on' else 'off'

  toParams: ->
    containers: @containers
    disk      : @disks
    domains   : @domains
    plan      : if @handlesPHI then 'platform' else 'development'
    val       : @price()
