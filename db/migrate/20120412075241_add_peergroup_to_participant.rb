class AddPeergroupToParticipant < ActiveRecord::Migration
  def change
    add_column :participants, :peergroup, :string

  end
end
