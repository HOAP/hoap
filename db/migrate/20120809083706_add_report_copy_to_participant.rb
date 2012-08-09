class AddReportCopyToParticipant < ActiveRecord::Migration
  def change
    add_column :participants, :report_copy, :string, :limit => 5
  end
end
