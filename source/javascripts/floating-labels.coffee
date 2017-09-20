$.fn.extend floatingLabel: (_options) ->
  $(this).each ->
    $this = $(this)
    $input = $this.find('input')
    $label = $this.find('label, .placeholder')
    $input.keyup (e) ->
      hasValue = e.target.value.length
      if hasValue
        $label.addClass 'is-visible active'
      else
        $label.removeClass 'is-visible active'
      return
    return
  return
$('.floating-label').floatingLabel()