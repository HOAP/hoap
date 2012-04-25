class AddShowPeerFieldsToParticipant < ActiveRecord::Migration
  def change
    add_column :participants, :peer_dpo, :boolean
    add_column :participants, :peer_dpw, :boolean
  end
end
