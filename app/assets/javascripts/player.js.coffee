$(document).on "page:change", ->
  $('#show_record_form').on 'click', ->
    $('.player_record').show()
    $(this).hide()
