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
    filename = "HOAP-#{Time.zone.now.strftime("%Y%m%d%H%M")}.csv"
    send_data(Participant.export_csv, :type => 'text/csv', :disposition => 'inline', :filename => filename)
  end

  def import
    error = false
    if !params[:data_file].nil? && params[:data_file].content_type.chomp =~ /^text\/csv$/
      data = CSV.parse(params[:data_file].read)
      data.shift # Discard the header row
      begin
        Participant.import(data)
        flash[:notice] = "Data file successfully imported."
      rescue Exception => e
        flash[:error] = e.message
      end
    end
    redirect_to admin_url
  end
end
