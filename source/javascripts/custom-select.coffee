$.fn.extend dashedSelect: (_options) ->
  SELECT_KEYS = [13, 32]
    
  $(@).each ->
    $this = $(@)
    $menu = $this.find('.custom-select__menu')
    $link = $this.find('.custom-select__link')
    $item = $this.find('.custom-select__item')
    $input = $this.find('.custom-select__input')

    # Toggle visibility of options
    $link.click (e) ->
      $menu.toggleClass 'active'
      return

    # Space or Enter keys
    $link.keyup (e) ->
      if e.keyCode in SELECT_KEYS
        $menu.toggleClass 'active'
      return false

    # Set label and hidden input value
    itemSelect = (e) ->
      if e.type is 'click' or (e.type is 'keyup' and e.keyCode in SELECT_KEYS)
        label = $(e.target).text()
        $link.text label
        $input.val label
        $menu.toggleClass 'active'
      return false

    $item.click itemSelect
    $item.keyup itemSelect

    return
  return

$ -> $('.custom-select').dashedSelect()
