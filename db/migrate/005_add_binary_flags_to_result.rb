class AddBinaryFlagsToResult < ActiveRecord::Migration
  def self.up
    add_column :results, :binary_stdout, :boolean, :default => false
    add_column :results, :binary_stderr, :boolean, :default => false    
  end

  def self.down
    remove_column :results, :binary_stdout
    remove_column :results, :binary_stderr
  end
end
