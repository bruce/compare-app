require File.dirname(__FILE__) + '/../test_helper'

context "Context" do
  
  specify "creates results" do
    comparison = nil
    assert_nothing_raised do
      comparison = Comparison.create(:name => 'Simple output', :code => 'puts 1')
    end
    assert_equal 2, comparison.results.count
  end
  
end