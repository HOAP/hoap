class SurveyController < ApplicationController
  before_filter :get_participant, :except => [:index, :start]

  def index
  end

  def start
    if params[:code].present? && params[:code] =~ /^[0-9a-f]{12}$/i
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
    render :action => "page#{@participant.page}"
  end

  def save
    @participant.update_progress(params[:page])
    if @participant.page == 1
      @participant.update_attributes(params[:participant])
      error_count = @participant.errors.count
    else
      @answers, error_count = Answer.save_all(params[:answer])
    end
    if error_count == 0
      @participant.next_page!
      redirect_to page_url(:key => @participant.key)
    else
      @questions = Question.find_for(@participant)
      render :action => "page#{@participant.page}"
    end
  end

  def feedback
  end

  def facts
  end

  def tips
  end

  def support
  end

  private

  def get_participant
    @participant = nil
    if params[:key].present? && params[:key] =~ /^[0-9a-f]{12}$/i
      @participant = Participant.where(:key => params[:key]).first
    end
    if @participant.nil?
      flash[:error] = "Unknown participant code."
      redirect_to :action => 'index'
    end
  end

end
