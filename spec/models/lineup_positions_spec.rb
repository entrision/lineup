require 'rails_helper'

RSpec.describe LineupPosition, type: :model do
  it "must have a player" do
    expect(LineupPosition.new(player_lineup: create(:player_lineup))).to be_invalid
  end

  it "has no duplicate players"
  it "has no duplicate positions"

  describe "position change" do
    let!(:player1) { create(:player, win: 2, loss: 1) }
    let!(:player2) { create(:player, win: 1, loss: 2) }
    let!(:player3) { create(:player, win: 3, loss: 0) }
    let!(:player4) { create(:player, win: 2, loss: 1) }
    let!(:no_match_p1) { create(:player) }
    let!(:no_match_p2) { create(:player) }
    let!(:no_match_p3) { create(:player) }

    let!(:lineup1)  { create(:player_lineup) }
    let!(:lineup2)  { create(:player_lineup) }

    let!(:position1) { create(:lineup_position, position: 1, player: player1, player_lineup: lineup1) }
    let!(:position2) { create(:lineup_position, position: 2, player: player2, player_lineup: lineup1) }
    let!(:position3) { create(:lineup_position, position: 3, player: player3, player_lineup: lineup1) }
    let!(:position4) { create(:lineup_position, position: 4, player: player4, player_lineup: lineup1) }
    let!(:no_match_pos1) { create(:lineup_position, position: 1, player: no_match_p1, player_lineup: lineup2) }
    let!(:no_match_pos2) { create(:lineup_position, position: 2, player: no_match_p2, player_lineup: lineup2) }
    let!(:no_match_pos3) { create(:lineup_position, position: 3, player: no_match_p3, player_lineup: lineup2) }

    context "without playing matches" do
      it "moves without restriction" do
        no_match_pos3.position = 1
        expect(no_match_pos3).to be_valid
      end
    end

    context "with matches played" do

      it "moves 1 spot" do
        position3.player.win += 1
        position3.position = 2
        expect(position3).to be_valid
      end

      it "cannot move 2 spots" do
        position3.position = 1
        expect(position3).to be_invalid
      end

      it "must play a match before moving again" do
        position2.position = 1
        expect(position2).to be_invalid
      end

      it "player must have higher win % to overtake position" do
        position4.position = 3
        expect(position4).to be_invalid
      end

      context "after the first 5 matches" do
        before {
          # add 3 mathces for 6 total
          position3.player.win += 2
          position3.player.loss += 1
          # set match count when position was taken
          position3.player_match_count_at_change = 4
          position3.save!
        }

        it "cannot move before 3 matches at new position" do
          position3.position = 2
          expect(position3).to be_invalid
        end

        it "changes position after 3 matches" do
          position3.player_match_count_at_change = 3
          position3.position = 2
          expect(position3).to be_valid
        end

      end


    end
  end
end
