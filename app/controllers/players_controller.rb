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
      redirect_to @player, notice: "Player created."
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
  end

  private
    def set_player
      @player = Player.find(params[:id])
    end

    def player_params
      params.require(:player).permit(:name, :win, :loss).merge(coach_id: current_coach.id)
    end
end
