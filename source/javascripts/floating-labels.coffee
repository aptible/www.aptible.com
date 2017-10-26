$.fn.extend floatingLabel: (_options) ->
  $(@).each ->
    $this = $(@)
    $input = $this.find('.input')
    $label = $this.find('label, .placeholder, .input')
    $input.keyup (e) ->
      hasValue = e.target.value.length
      if hasValue
        $label.addClass 'fl--is-active'
      else
        $label.removeClass 'fl--is-active'
      return
    return
  return

$ -> $('.floating-label').floatingLabel()
