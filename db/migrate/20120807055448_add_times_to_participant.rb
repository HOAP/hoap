class AddTimesToParticipant < ActiveRecord::Migration
  def change
    add_column :participants, :report_time, :integer, :default => 0
    add_column :participants, :facts_time, :integer, :default => 0
    add_column :participants, :support_time, :integer, :default => 0
    add_column :participants, :tips_time, :integer, :default => 0
  end
end
