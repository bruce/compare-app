class RenameStdinToStderr < ActiveRecord::Migration
  def self.up
    rename_column :results, :stdin, :stderr
  end

  def self.down
    rename_column :results, :stderr, :stdin
  end
end
