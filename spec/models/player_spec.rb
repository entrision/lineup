require 'rails_helper'

RSpec.describe Player, type: :model do

  subject(:player) { Player.new(name: "Guy Testman", win: 10, loss: 1) }

  describe "#name" do
    before do
      player.name = ""
      player.valid?
    end

    it "assigns an error to name" do
      expect(player.errors.has_key?(:name)).to be_truthy
    end
  end

  describe "#coach" do
    before do
      player.coach = nil
      player.valid?
    end

    it 'assigns an error to coach' do
      expect(player.errors.has_key?(:coach)).to be_truthy
    end
  end

  describe "#matches_played" do
    it 'has 11 matches_played' do
      expect(player.matches_played).to be(11)
    end

    it 'has matches_played' do
      expect(player.matches_played?).to be_truthy
    end
  end

  describe "#win_percentage" do
    it 'has a win_percentage of 0.909' do
      expect(player.win_percentage).to eq(0.909)
    end
  end

  describe "#win_loss" do
    it 'increments win' do
      expect { player.win_loss = 1 }.to change { player.win }.from(10).to(11)
    end

    it 'increments loss' do
      expect { player.win_loss = 0 }.to change { player.loss }.from(1).to(2)
    end
  end

end
