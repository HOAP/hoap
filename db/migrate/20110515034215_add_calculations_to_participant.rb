class AddCalculationsToParticipant < ActiveRecord::Migration
  def self.up
    add_column :participants, :c_audit, :integer
    add_column :participants, :c_bac, :decimal, :precision => 3, :scale => 2
    add_column :participants, :c_money, :string
    add_column :participants, :c_ldq, :integer
    add_column :participants, :c_dpw, :decimal, :precision => 5, :scale => 2
  end

  def self.down
    remove_column :participants, :c_dpw
    remove_column :participants, :c_ldq
    remove_column :participants, :c_money
    remove_column :participants, :c_bac
    remove_column :participants, :c_audit
  end
end
