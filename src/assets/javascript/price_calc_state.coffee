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
  containers    : 0
  disks         : 0
  domains       : 0

  # Fixed
  # Disks are 200 GB each
  devContainers : 6
  devDisks      : 5
  devDomains    : 4

  # Prices
  # ~730 hours in a month
  perContainer  : (0.08 * 730).toFixed 2
  perDisk       : (0.37 * 200).toFixed 2
  perDomain     : (0.05 * 730).toFixed 2
  devBaseCost   : 499

  # Retain higher values if set, only up to what's included
  setDevBaseValues: ->
    @containers = Math.max(@containers, @devContainers)
    @disks = Math.max(@disks, @devDisks)
    @domains = Math.max(@domains, @devDomains)

  diskSize: ->
    switch @disks
      when 0, 1, 2, 3, 4
        "#{@disks * 200} GB"
      when 5, 10
        "#{@disks * 0.2} TB"
      else
        "#{(@disks * 0.2).toFixed(1)} TB"

  containersCost: ->
    includedContainers = if @handlesPHI then @devContainers else 0
    containers = if @containers > 10 then 10 else @containers
    @toCurrency Math.max(((containers - includedContainers) * @perContainer), 0)

  disksCost: ->
    includedDisks = if @handlesPHI then @devDisks else 0
    disks = if @disks > 10 then 10 else @disks
    @toCurrency Math.max(((disks - includedDisks) * @perDisk), 0)

  domainsCost: ->
    includedDomains = if @handlesPHI then @devDomains else 0
    domains = if @domains > 10 then 10 else @domains
    @toCurrency Math.max(((domains - includedDomains) * @perDomain), 0)

  baseCost: ->
    @toCurrency(if @handlesPHI then @devBaseCost else 0)

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
    if @needsMore() then 'on' else 'off'

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
