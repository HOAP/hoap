require 'csv'

namespace :db do
  task :cacheinit => [:environment] do
    participants = Participant.order("id ASC")
    records = Hash.new
    header = %w{ParticipantID Code Key Page Name Email Completed CompletionType AUDITC AUDIT}
    header += %w{BAC LDQ ReportCopy DAOCAppoint ReportTime FactsTime SupportTime TipsTime}
    Question.order("id ASC").pluck(:page).uniq.each do |page|
      Question.count(:conditions => {:page => page}).times do |q|
        header << "Pg#{page}Q#{q + 1}"
      end
    end
    records["header"] = header.to_csv
    current = Time.zone.now.to_i
    participants.each do |participant|
      records[participant.id] = participant.to_a.to_csv
    end
    records["last"] = current
    File.open("db/export_cache.yml", "wb") do |file|
      file.print(records.to_yaml)
    end
  end
end
