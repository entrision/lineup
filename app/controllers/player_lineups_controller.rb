class PlayerLineupsController < ApplicationController
  before_action :authenticate_coach!
  before_action :set_lineup, only: [:show, :update, :edit, :destroy]

  def index
    @lineups = current_coach.player_lineups
  end

  def new
    @lineup = PlayerLineup.new
    @pnil = current_coach.players
  end

  def show
  end

  def edit
    @pnil = Player.where.not(id: LineupPosition.select("player_id").where(player_lineup_id: @lineup.id)).where(coach: current_coach)
  end

  def create
    @lineup = PlayerLineup.new(lineup_params)

    if @lineup.save
      redirect_to @lineup, notice: "Lineup created."
    else
      render :new
    end
  end

  def update
    if @lineup.update(lineup_params)
      redirect_to @lineup, notice: "Lineup successfully updated."
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
end
