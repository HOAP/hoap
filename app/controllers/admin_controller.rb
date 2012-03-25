class AdminController < ApplicationController
  before_filter :require_admin_user

  def index
  end

  def participant
  end

  def export
  end
end
