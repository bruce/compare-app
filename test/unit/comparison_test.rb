require File.dirname(__FILE__) + '/../test_helper'

context "Context" do
  
  specify "creates results" do
    comparison = nil
    assert_nothing_raised do
      comparison = Comparison.create(:name => 'Simple output', :code => 'puts 1; sleep 1')
    end
    assert_equal 2, comparison.results.count
    comparison.results.each do |result|
      assert_kind_of Benchmark::Tms, result.benchmark
      assert result.benchmark.real > 0.0
    end
  end
  
end