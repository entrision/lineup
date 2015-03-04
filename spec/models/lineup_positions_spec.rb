require 'rails_helper'

RSpec.describe LineupPosition, type: :model do
  it "must have a player" do
    expect(LineupPosition.new(player_lineup: create(:player_lineup))).to be_invalid
  end

  it "has no duplicate players"
  it "has no duplicate positions"

  describe "changing position" do
    let!(:player1) { create(:player) }
    let!(:player2) { create(:player) }
    let!(:player3) { create(:player) }
    let!(:lineup1)  { create(:player_lineup) }
    let!(:position1) { create(:lineup_position, position: 1, player: player1, player_lineup: lineup1) }
    let!(:position2) { create(:lineup_position, position: 2, player: player2, player_lineup: lineup1) }
    let!(:position3) { create(:lineup_position, position: 3, player: player3, player_lineup: lineup1) }

    context "with no matches played" do
      it "moves without restriction" do
        position3.position = 1
        expect(position3).to be_valid
      end
    end

    context "with matches played" do
      before do
        player1.update_attributes(win: 2, loss: 1)
        player2.update_attributes(win: 1, loss: 2)
        player3.update_attributes(win: 3, loss: 0)
      end

      describe "having not played at current position" do
        before do
          position3.update_attributes(player_match_count_at_change: 3)
          position3.position = 2
          position3.valid?
        end

        it "assigns an error" do
          expect(position3.errors.has_key?(:position)).to be_truthy
        end
      end

      describe "having played match(es) at current position" do
        before do
          position2.update_attributes(player_match_count_at_change: 2)
          position3.update_attributes(player_match_count_at_change: 2)
        end

        context "moving up with higher win percentage" do
          it "moves 1 spot" do
            position3.position = 2
            expect(position3).to be_valid
          end

          it "cannot move 2 spots" do
            position3.position = 1
            position3.valid?
            expect(position3.errors.has_key?(:position)).to be_truthy
          end
        end

        context "moving up with lower win percentage" do
          before do
            position2.position = 1
            position2.valid?
          end

          it "assigns error to position" do
            expect(position2.errors.has_key?(:position)).to be_truthy
          end
        end
      end

      context "after the first 5 matches" do
        before do
          player3.update_attributes(win: 5, loss: 1)
          position3.update_attributes(player_match_count_at_change: 4)
        end

        it "cannot move before 3 matches at new position" do
          position3.position = 2
          position3.valid?
          expect(position3.errors.has_key?(:position)).to be_truthy
        end

        it "changes position after 3 matches" do
          position3.player_match_count_at_change = 3
          position3.position = 2
          expect(position3).to be_valid
        end
      end
    end
  end

  describe "#check_and_move_mandatory" do
    let!(:player1) { create(:player, win: 3, loss: 5) }
    let!(:player2) { create(:player, win: 7, loss: 1) }
    let!(:lineup1)  { create(:player_lineup) }
    let!(:position1) { create(:lineup_position, position: 1, player: player1, player_lineup: lineup1, player_match_count_at_change: 2) }
    let!(:position2) { create(:lineup_position, position: 2, player: player2, player_lineup: lineup1, player_match_count_at_change: 2) }

    context "with 20% win difference" do
      before do
        position1.update_attributes(player_match_count_at_change: 2)
        position2.update_attributes(player_match_count_at_change: 2)
      end

      it "automatically moves players" do
        position1.check_and_move_mandatory
        position1.reload
        position2.reload
        expect(position1.position).to eq(2)
        expect(position2.position).to eq(1)
        expect(position1.locked?).to eq(true)
      end
    end
  end
end
