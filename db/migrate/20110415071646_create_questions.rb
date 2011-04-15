class CreateQuestions < ActiveRecord::Migration
  def self.up
    create_table :questions do |t|
      t.integer :page
      t.text :text
      t.text :values
      t.string :atype, :limit => 2

      t.timestamps
    end
  end

  def self.down
    drop_table :questions
  end
end
