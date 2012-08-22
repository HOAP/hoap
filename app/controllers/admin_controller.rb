require 'csv'

class AdminController < ApplicationController
  before_filter :require_user

  def index
    @count = Participant.where(:completed => true).count
    @participants = Participant.where("created_at >= ? AND exit_code = 0 AND completed = true", 1.day.ago).order("id ASC").select("code, key")
  end

  def participant
    count = params[:count].to_i
    count.times do
      Participant.make
    end
    redirect_to :action => :index
  end

  def export
    filename = "HOAP-#{DateTime.now.strftime("%Y%m%d%H%M")}.csv"
    participants = Participant.order("id ASC")
    header = %w{ParticipantID Code Name Email Completed CompletionType AUDITC AUDIT}
    header += %w{BAC LDQ ReportCopy DAOCAppoint ReportTime FactsTime SupportTime TipsTime}
    Question.order("id ASC").pluck(:page).uniq.each do |page|
      Question.count(:conditions => {:page => page}).times do |q|
        header << "Pg#{page}Q#{q + 1}"
      end
    end
    results = CSV.generate do |file|
      file << header
      participants.each do |participant|
        file << participant.to_a
      end
    end
    send_data(results, :type => 'text/csv', :disposition => 'inline', :filename => filename)
  end
end
