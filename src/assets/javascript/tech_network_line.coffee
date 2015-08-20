class TechNetworkLine

  constructor: ->

    # unique timing values
    @start = null
    @startTime = null

    # jquery DOM objects
    @line = $ '<div class="network-line">'
    @dot = null
    @active = null

    # Request Animation Frame State Object
    @animating = null


  # Helper function generates a random time
  # value in miliseconds
  randomTime: (max, min) ->
    (Math.random() * (max - min) + min) * 1000


  # Helper function that uses rAF to improve animation
  # https://developer.mozilla.org/en-US/docs/Web/API/window/requestAnimationFrame
  step: (timestamp) =>
    if !@start
      @start = timestamp
    progress = timestamp - @start
    stepping = Math.min(progress / 20, 96)

    @active.css('transform', 'scaleY(' + stepping / 100 + ')')
    @dot.css('top', stepping + '%')

    if progress < 2000
      @animating = window.requestAnimationFrame @step
    else
      @resetActivity()
      @animating = window.requestAnimationFrame @step



  # -------------------------------
  # Internal methods
  # -------------------------------


  resetActivity: ->
    @active.css('transform', 'scaleY(0)')
    @dot.css('top', '0%')
    @start = null


  showActive: ->
    animate
      el: @dot
      easing: 'easeOutCirc'
      opacity: [0, 1]
      duration: 500
    animate
      el: @active
      easing: 'easeOutCirc'
      opacity: [0, 1]
      duration: 500


  hideActive: ->
    animate
      el: @dot
      easing: 'easeOutCirc'
      opacity: [1, 0]
      duration: 500
    animate
      el: @active
      easing: 'easeOutCirc'
      opacity: [1, 0]
      duration: 500



  # -------------------------------
  # Externally called methods
  # -------------------------------


  # Sets position and adds dot + active line
  createLine: (yPos, klass)->
    @line.addClass(klass)
    @line.css('left', yPos + "px")   

    @active = $ '<div class="active">'
    @dot = $ '<div class="dot">'
    @line.append(@active).append(@dot)

    @startTime = @randomTime(0, 3)


  # Returns jquery object
  getDOMObject: ->
    @line


  # Start and show the animation
  startActivity: ->
    @showActive()
    setTimeout (=>
      @animating = window.requestAnimationFrame @step
    ), @startTime


  # Stops the animation from playing and resets position
  stopActivity: ->
    @hideActive()
    setTimeout ( => 
      window.cancelAnimationFrame @animating
      @animating = null
      @resetActivity()
    ), 600


