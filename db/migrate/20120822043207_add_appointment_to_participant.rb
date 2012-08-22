class AddAppointmentToParticipant < ActiveRecord::Migration
  def change
    add_column :participants, :appointment, :integer, :default => 0
  end
end
