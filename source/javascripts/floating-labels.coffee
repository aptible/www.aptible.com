$('.floating-label .input').keyup ->
  if !$.trim(@value).length
    $(this).closest('.floating-label').find('label, .placeholder').removeClass 'is-visible active'
    $(this).closest('.floating-label').find('.input').removeClass 'active'
  else
    $(this).closest('.floating-label').find('label,  .placeholder').addClass 'is-visible active'
    $(this).closest('.floating-label').find('.input').addClass 'active'
  return