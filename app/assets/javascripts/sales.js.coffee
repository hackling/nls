$ ->
  $('[data-toggle]').click ->
    $(this).toggleClass("toggled")
    $($(this).data("toggle")).toggle()
