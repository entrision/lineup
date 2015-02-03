$(document).on "page:change", ->

  $('.add_player').on 'click', (event) ->
    form_markup = $(this).data("fields")
    $('.position_fields').append(form_markup)
    $(this).hide()

    $('form fieldset').last().find('.position_hidden').val($('fieldset').length)
    event.preventDefault()

  $('.position_fields').on 'click', '.move_player', (event) ->
    current_fieldset = $(this).parent('fieldset')
    if $(this).data('direction') == "up"
      target_fieldset = $($(current_fieldset)).prevAll('fieldset').first()
    else
      target_fieldset = $($(current_fieldset)).nextAll('fieldset').first()
    swap_positions($(current_fieldset), $(target_fieldset), $(this).data('direction'))
    event.preventDefault()

  swap_positions = (original, target, direction) ->
    new_position = $(target).find('.position_hidden').val()
    old_position = $(original).find('.position_hidden').val()

    $(target).find('.position_hidden').val(old_position)
    $(original).find('.position_hidden').val(new_position)

    if direction == "up"
      $(target).before(original)
    else
      $(target).after(original)
