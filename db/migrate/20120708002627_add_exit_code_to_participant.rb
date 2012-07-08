class AddExitCodeToParticipant < ActiveRecord::Migration
  def change
    add_column :participants, :exit_code, :integer, :default => 0
  end
end
