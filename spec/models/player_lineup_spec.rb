require 'rails_helper'

RSpec.describe PlayerLineup, type: :model do

  subject(:lineup) { PlayerLineup.new }

  describe "#title" do
    before do
      lineup.title = nil
      lineup.valid?
    end

    it 'assigns an error to title' do
      expect(lineup.errors.has_key?(:title)).to be_truthy
    end
  end

end
