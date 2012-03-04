class UsersController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:show, :edit, :update]
  before_filter :require_admin_user, :only => [:index]

  def index
    @users = User.select("id, login, email, admin, last_login_at")
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Account registered!"
      redirect_back_or_default new_user_session_url
    else
      render :action => :new
    end
  end

  def show
    if @current_user.admin && !params[:id].blank?
      @user = User.find(params[:id])
    else
      @user = @current_user
    end
  end

  def edit
    if @current_user.admin && !params[:id].blank?
      @user = User.find(params[:id])
    else
      @user = @current_user
    end
  end

  def update
    if @current_user.admin && !params[:id].blank?
      @user = User.find(params[:id])
    else
      @user = @current_user
    end
    if @user.update_attributes(params[:user])
      flash[:notice] = "Account updated!"
      redirect_to @user
    else
      render :action => :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    # Make sure a user cannot disable their own account
    if @user.id != @current_user.id
      @user.enabled = false
    end
    flash[:notice] = "Account disbaled."
    redirect_to users_url
  end

end
