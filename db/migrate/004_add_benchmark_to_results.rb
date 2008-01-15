class AddBenchmarkToResults < ActiveRecord::Migration
  def self.up
    benchmark_columns.each do |col|
      add_column :results, col, :float, :default => 0.0
    end
  end

  def self.down
    benchmark_columns.each do |col|
      remove_column :results, col
    end
  end
  
  def self.benchmark_columns
    %w(user_cpu_time system_cpu_time child_user_cpu_time child_system_cpu_time real_time)  
  end
  
end
