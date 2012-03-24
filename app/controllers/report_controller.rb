class ReportController < ApplicationController
  before_filter :get_participant

  def index
  end

  def facts
  end

  def support
  end

  def tips
  end

  def dpo_graph
    send_data(@participant.dpo_graph, :type => 'image/png', :disposition => 'inline', :filename => 'std_drinks_graph.png')
  end

  def dpw_graph
    send_data(@participant.dpw_graph, :type => 'image/png', :disposition => 'inline', :filename => 'dpw_graph.png')
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
