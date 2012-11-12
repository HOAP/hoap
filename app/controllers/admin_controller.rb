require 'csv'

class AdminController < ApplicationController
  before_filter :require_user

  def index
    @count = Participant.where(:completed => true).count
    @participants = Participant.where("created_at >= ? AND exit_code = 0 AND completed = true", 1.day.ago).order("id ASC").select("code, key")
    @incomplete = Participant.where("created_at >= ? AND completed = false", 1.day.ago).order("id ASC").select("code, key, email")
  end

  def reports
    @participants = Participant.where(:exit_code => 0, :completed => true).order("id ASC").select("code, key")
  end

  def incomplete
    @incomplete = Participant.where(:completed => false).order("id ASC").select("code, key, email")
  end

  def participant
    count = params[:count].to_i
    count.times do
      Participant.make
    end
    redirect_to :action => :index
  end

  def export
    cache_file = "db/export_cache.yml"
    if File.exists?(cache_file)
      records = Psych.load_file(cache_file)
      last = Time.zone.at(records.delete("last"))
    else
      records = Hash.new
      last = Time.zone.at(0)
      header = %w{ParticipantID Code Key Page Name Email Completed CompletionType AUDITC AUDIT}
      header += %w{BAC LDQ ReportCopy DAOCAppoint ReportTime FactsTime SupportTime TipsTime}
      Question.order("id ASC").pluck(:page).uniq.each do |page|
        Question.count(:conditions => {:page => page}).times do |q|
          header << "Pg#{page}Q#{q + 1}"
        end
      end
      records["header"] = header.to_csv
    end
    filename = "HOAP-#{DateTime.now.strftime("%Y%m%d%H%M")}.csv"
    current = Time.zone.now.to_i
    participants = Participant.where("updated_at >= ?", last).order("id ASC")
    participants.each do |participant|
      records[participant.id] = participant.to_a.to_csv
    end
    results = records.values.join("")
    records["last"] = current
    File.open(cache_file, "wb") do |file|
      file.print(records.to_yaml)
    end
    send_data(results, :type => 'text/csv', :disposition => 'inline', :filename => filename)
  end

  def import
    error = false
    if params[:data_file].content_type.chomp =~ /^text\/csv$/
      data = CSV.parse(params[:data_file].read)
      data.shift # Discard the header row
      if data[0][5] =~ /@/
      else
        data.each do |row|
          if row[5] =~ /@/
            flash[:error] = "Data file must not be unencrypted!"
            error = true
            break
          end
          if Participant.from_a(row) == nil
            flash[:error] = "Failed to import participant #{row[0]}"
            error = true
            break
          end
        end
        unless error
          flash[:notice] = "Data file successfully imported."
        end
      end
    end
    redirect_to admin_url
  end
end
