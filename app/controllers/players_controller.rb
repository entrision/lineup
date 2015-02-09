class PlayersController < ApplicationController
  before_action :authenticate_coach!
  before_action :set_player, only: [:show, :update, :edit, :destroy]

  def index
    @players = current_coach.players
  end

  def new
    @player = Player.new
  end

  def show
  end

  def edit
  end

  def create
    @player = Player.new(player_params)

    if @player.save
      redirect_to players_url, notice: "Player created."
    else
      render :new
    end
  end

  def update
    if @player.update(player_params)
      redirect_to @player, notice: "Player successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @player.destroy
    redirect_to players_path, notice: "Player successfully removed."
  end

  def edit_multiple
    @lineup = PlayerLineup.find(params[:id])
    @players = @lineup.players
  end

  def update_multiple
    lineup = PlayerLineup.find(params[:lineup_id])
    @players = Player.update(params[:players].keys, params[:players].values)

    lineup.lineup_positions.each do |pos|
      pos.check_and_move_mandatory
    end

    @players.reject! { |p| p.errors.empty? }
    if @players.empty?
      redirect_to lineup
    else
      render "edit_multiple"
    end
  end

  private
    def set_player
      @player = Player.find(params[:id])
    end

    def player_params
      params.require(:player).permit(:name, :win, :loss).merge(coach_id: current_coach.id)
    end
end
