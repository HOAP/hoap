class CreateParticipants < ActiveRecord::Migration
  def self.up
    create_table :participants do |t|
      t.string :key, :limit => 12, :null => false
      t.string :name
      t.integer :page, :default => 1
      t.boolean :completed, :default => false

      t.timestamps
    end
    # The key property is used as a secure way to identify participants,
    # so make sure that there cannot be any duplicates.
    add_index :participants, :key, :unique => true
  end

  def self.down
    drop_table :participants
  end
end
