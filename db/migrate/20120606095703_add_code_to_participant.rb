class AddCodeToParticipant < ActiveRecord::Migration
  def change
    add_column :participants, :code, :string

  end
end
