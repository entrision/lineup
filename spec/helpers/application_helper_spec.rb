require 'rails_helper'

describe ApplicationHelper do

  describe "#decimal_to_percent" do
    it 'returns 99.9%' do
      expect(helper.decimal_to_percent(0.999)).to eql("99.9%")
    end
  end

  describe "#percent" do
    it 'returns 99.9%' do
      expect(helper.percent(99.9)).to eql("99.9%")
    end
  end

end
