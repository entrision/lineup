class PlayerLineupsController < ApplicationController
  before_action :authenticate_coach!
  before_action :set_lineup, only: [:show, :update, :edit, :destroy]
  before_action :set_players_not_in_lineup, only: [:update, :edit]

  def index
    @lineups = current_coach.player_lineups
  end

  def new
    @lineup = PlayerLineup.new
    @pnil = current_coach.players
  end

  def show
    @players = current_coach.players
  end

  def edit
  end

  def create
    @lineup = PlayerLineup.new(lineup_params)

    if @lineup.save
      flash[:success] = "Lineup created."
      redirect_to @lineup
    else
      added_player_ids = []
      @lineup.lineup_positions.each { |lp| added_player_ids << lp.player_id }
      @pnil = current_coach.players.to_a.delete_if { |p| added_player_ids.include?(p.id) }

      flash[:error] = ""
      @lineup.errors.full_messages.each { |message| flash[:error] << message }

      render :new
    end
  end

  def update
    if @lineup.update(lineup_params)
      flash[:success] = "Lineup successfully updated."
      redirect_to @lineup
    else
      render :edit
    end
  end

  def destroy
    @lineup.destroy
    redirect_to player_lineups_path, notice: "Lineup successfully removed."
  end

  private
    def lineup_params
      params.require(:player_lineup).permit(:title, lineup_positions_attributes: [:id, :player_id, :position, :add, :_destroy]).merge(coach_id: current_coach.id)
    end

    def set_lineup
      @lineup = PlayerLineup.find(params[:id])
    end

    def set_players_not_in_lineup
      @pnil = Player.where.not(id: LineupPosition.select("player_id").where(player_lineup_id: @lineup.id)).where(coach: current_coach)
    end
end
