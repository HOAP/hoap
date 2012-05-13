class AdminController < ApplicationController
  before_filter :require_admin_user

  def index
    @count = Participant.where(:completed => true).count
    @available = Participant.where(:page => 1).pluck(:key)
  end

  def participant
  end

  def export
  end
end
