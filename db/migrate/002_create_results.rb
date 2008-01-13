class CreateResults < ActiveRecord::Migration
  def self.up
    create_table :results do |t|
      t.belongs_to :comparison
      t.string :version
      t.text :stdout, :stdin
      t.integer :exit_code
      t.timestamps
    end
  end

  def self.down
    drop_table :results
  end
end
