class SurveyController < ApplicationController
  def index
  end

  def start
    if !params[:code].nil? && params[:code] =~ /^[0-9a-f]{8}$/i
      @participant = Participant.where(:key => params[:code].downcase).first
      unless @participant.nil? || @participant.completed
        redirect_to page_url(@participant.key)
        return
      end
      flash[:error] = "Non existent code."
    else
      flash[:error] = "Invalid invitation code."
    end
    redirect_to :action => 'index'
  end

  def page
  end

  def feedback
  end

end
