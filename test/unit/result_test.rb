require File.dirname(__FILE__) + '/../test_helper'

context "Result" do

  specify "creates benchmark" do
    result = Result.create(:version => '1.8', :exit_code => 0,
      :user_cpu_time => 1.0,
      :system_cpu_time => 2.0,
      :child_user_cpu_time => 3.0,
      :child_system_cpu_time => 4.0,
      :real_time => 10.0
    )
    assert result.benchmark.is_a?(Benchmark::Tms)
    assert 10.0, result.benchmark.real
  end
  
  specify "saves benchmark" do
    result = Result.create(:version => '1.8', :exit_code => 0, :benchmark => Benchmark.measure { sleep 0.2 })
    assert result.benchmark.is_a?(Benchmark::Tms)
    assert result.benchmark.real > 0.0
  end

end
