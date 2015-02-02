$(document).on "page:change", ->

  $('.add_player').on 'click', (event) ->
    form_markup = $(this).data("fields")
    $('form fieldset').last().after(form_markup)
    $(this).hide()
    event.preventDefault()

  $('.move_player_up').on 'click', (event) ->
    current_fieldset = $(this).parent('fieldset')
    target_fieldset = $($(current_fieldset)).prevAll('fieldset').first()
    swap_positions($(current_fieldset), $(target_fieldset), "up")
    event.preventDefault()


  $('.move_player_down').on 'click', (event) ->
    current_fieldset = $(this).parent('fieldset')
    target_fieldset = $($(current_fieldset)).nextAll('fieldset').first()
    swap_positions($(current_fieldset), $(target_fieldset), "down")
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
