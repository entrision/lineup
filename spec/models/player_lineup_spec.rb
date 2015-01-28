require 'rails_helper'

RSpec.describe PlayerLineup, type: :model do
  subject(:lineup) { PlayerLineup.new }

  context "when not valid" do
    it "missing title" do
      expect(lineup).to be_invalid
    end
  end

end
