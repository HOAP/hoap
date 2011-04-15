class CreateAnswers < ActiveRecord::Migration
  def self.up
    create_table :answers do |t|
      t.references :participant
      t.references :question
      t.integer :page
      t.text :value

      t.timestamps
    end
  end

  def self.down
    drop_table :answers
  end
end
