class AddAuditCToParticipant < ActiveRecord::Migration
  def change
    add_column :participants, :c_audit_c, :integer
  end
end
