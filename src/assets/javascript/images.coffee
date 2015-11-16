$ ->
  if window.devicePixelRatio == 2
    $("img[src$='product-stack.png']").attr('src', '/assets/images/product-stack-2x.png')
