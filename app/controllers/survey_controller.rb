class SurveyController < ApplicationController
  before_filter :get_participant, :only => [:page, :feedback]

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
    @questions = Question.find_for(@participant)
    @answers = Answer.find_for(@participant)
    render :action => "page#{participant.page}"
  end

  def feedback
  end

  private

  def get_participant
    @participant = Participant.where(:key => params[:key]).first
    if @participant.nil?
      flash[:error] = "Unknown participant code."
      redirect_to :action => 'index'
    end
  end

end
