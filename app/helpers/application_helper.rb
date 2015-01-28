module ApplicationHelper

  def link_to_add_player(name, f, player)
    fields = f.fields_for :lineup_positions, LineupPosition.new(player: player) do |pf|
      render "lineup_positions_fields", f: pf
    end

    link_to(name, '#', class: "add_player", data: { id: player.id, fields: fields.gsub("\n", "") } )
  end

end
