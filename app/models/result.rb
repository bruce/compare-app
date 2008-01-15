require 'benchmark'

class Result < ActiveRecord::Base
  
  include Comparable
    
  composed_of :benchmark, :class_name => "Benchmark::Tms", :mapping => [
    %w(user_cpu_time utime), %w(system_cpu_time stime),
    %w(child_user_cpu_time cutime), %w(child_system_cpu_time cstime),
    %w(real_time real)
  ]
  
  validates_presence_of :version
  validates_presence_of :exit_code
  
  def success?
    exit_code == 0
  end
    
end
