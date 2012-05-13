class AdminController < ApplicationController
  before_filter :require_admin_user

  def index
    @count = Participant.where(:completed => true).count
    @available = Participant.where(:page => 1).pluck(:key)
  end

  def participant
    count = params[:count].to_i
    count.times do
      Participant.make
    end
    redirect_to :action => :index
  end

  def export
  end
end
