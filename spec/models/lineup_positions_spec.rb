require 'rails_helper'

RSpec.describe LineupPosition, type: :model do
  it "must have a player" do
    expect(LineupPosition.new(player_lineup: create(:player_lineup))).to be_invalid
  end

  it "must have a lineup" do
    expect(LineupPosition.new(player: create(:player))).to be_invalid
  end

  it "has no duplicate players"
  it "has no duplicate positions"

  describe "position change" do
    let(:player1) { create(:player, win: 1, loss: 1) }
    let(:player2) { create(:player, win: 2, loss: 1) }
    let(:player3) { create(:player, win: 3, loss: 1) }
    let(:position1) { create(:lineup_position, position: 1, player: player1) }
    let(:position2) { create(:lineup_position, position: 2, player: player2) }
    let(:position3) { create(:lineup_position, position: 3, player: player3) }

    context "without playing matches" do

    end

    context "with matches played" do

      it "moves 1 spot" do
        puts "#######################"
        puts position2.player.win_percentage
        puts "#######################"
        puts position1.player.win_percentage
        position2.position = 1
        expect(position2).to be_valid
      end

      it "cannot move 2 spots" do
        position3.position = 1
        expect(position3).to be_invalid
      end

      context "before the first 5 matches" do
        it "moves position i"
      end

      context "after the first 5 matches"

    end
  end
end
