class TechNetwork

  OFFSET = 32 # in pixels, inner-offset from vpc box
  SPACING = 16 # spacing between network lines

  $networkContainer = null
  $vpc = null
  $vpcPosition = null

  vpcTop = 0
  vpcLeft = 0
  vpcWidth = 0
  numLines = 0
  halfLines = 0

  httpLines = []
  sshLines = []
  allLines = []


  generateNetwork = ->
    $vpc = $ '.customer-vpc'
    vpcPosition = $vpc.offset()
    vpcTop = Math.floor(vpcPosition.top)
    vpcLeft = Math.floor(vpcPosition.left) + (OFFSET / 2)
    vpcWidth = $vpc.outerWidth() - OFFSET

    numLines = Math.ceil(vpcWidth / SPACING)
    halfLines = Math.ceil(numLines * 0.65)

    unless $networkContainer
      $networkContainer = $ '<div class="network-container">'

    $networkContainer.css   
      height: vpcTop + 'px'
      width: vpcWidth
      left: vpcLeft + 'px'

    $('body').append($networkContainer)

    generateLines()


  generateLines = ->
    for i in [0...numLines]
      yPos = i * SPACING

      if i < halfLines
        lineObj = new TechNetworkLine()
        lineObj.createLine(yPos, 'left')
        httpLines.push lineObj
      else
        lineObj = new TechNetworkLine()
        lineObj.createLine(yPos, 'right')
        sshLines.push lineObj

      allLines = httpLines.concat(sshLines)
      line = lineObj.getDOMObject()

      $networkContainer.append(line)


  regenerateNetwork = ->
    destroyNetwork()
    generateNetwork()


  destroyNetwork = ->
    for i in [0...allLines.length]
      allLines[i].getDOMObject().remove()
      delete allLines[i]

    httpLines = []
    sshLines = []
    allLines = []


  $(window).resize ->
    regenerateNetwork()





  # -------------------------------
  # Public methods
  # -------------------------------


  createNetwork: ->
    generateNetwork()


  runHttp: ->
    for i in [0...httpLines.length]
      if i % 2 == 0
        httpLines[i].startActivity()


  runSSH: ->
    for i in [0...sshLines.length]
      if i != 0 and i % 2 == 0
        sshLines[i].startActivity()


  runHalf: ->
    for i in [0...allLines.length]
      if i % 2 == 0
        allLines[i].startActivity()


  runHalf2: ->
    for i in [0...allLines.length]
      if i % 2 != 0
        allLines[i].startActivity()


  stop: ->
    for i in [0...allLines.length]  
      allLines[i].stopActivity()




