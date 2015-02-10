$(document).on "page:change", ->

  $('fieldset.locked').each ->
    $(this).find('.move_player').prop('disabled', true)
    $(this).prevAll('fieldset').first().find('[data-direction="down"]').prop('disabled', true)
    $(this).nextAll('fieldset').first().find('[data-direction="up"]').prop('disabled', true)

  $('.add_player').on 'click', (event) ->
    form_markup = $(this).data("fields")
    $('.position_fields').append(form_markup)
    $(this).hide()
    fieldset = $('form fieldset').last()

    $(fieldset).find('.position_hidden').val($('fieldset').length)
    $(fieldset).find('.move_player').prop('disabled', false)
    $(fieldset).addClass('new')
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
      unless $(target).hasClass('new')
        $(original).find('[data-direction="up"]').prop('disabled', true)
        $(original).find('[data-direction="down"]').prop('disabled', false)
        $(target).find('[data-direction="down"]').prop('disabled', true)
        $(target).find('[data-direction="up"]').prop('disabled', false)
    else
      $(target).after(original)
      unless $(target).hasClass('new')
        $(original).find('[data-direction="up"]').prop('disabled', false)
        $(original).find('[data-direction="down"]').prop('disabled', true)
        $(target).find('[data-direction="down"]').prop('disabled', false)
        $(target).find('[data-direction="up"]').prop('disabled', true)

