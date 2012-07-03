class AddEmailToParticipant < ActiveRecord::Migration
  def change
    add_column :participants, :email, :binary, :limit => 256.bytes

  end
end
