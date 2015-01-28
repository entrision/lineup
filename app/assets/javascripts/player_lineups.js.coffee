$(document).on "page:change", ->

  $('.add_player').on 'click', (event) ->
    form_markup = $(this).data("fields")
    $('form fieldset').last().after(form_markup)
    $(this).hide()
    event.preventDefault()
