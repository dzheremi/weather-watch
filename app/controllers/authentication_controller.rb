class AuthenticationController < ApplicationController
  before_filter :authorised_user
  around_filter :set_time_zone

  def process_login
    user = User.authenticate(params[:username], params[:password])
    if user
      session[:user] = user.id
      redirect_to :controller => :site, :action => :index
    else
      flash[:notice] = 'That is an invalid username or password.'
      render :action => :login
    end
  end

  def logout
    session[:user] = nil
    redirect_to :controller => :site, :action => :index
  end

  def register
    @user = User.new
    @timezones = Timezone.all.order(name: :asc)
  end

  def save_user
    @user = User.new(user_params)
    if @user.save
      session[:user] = @user.id
      redirect_to :controller => :site, :action => :index
    else
      @timezones = Timezone.all.order(name: :asc)
      flash[:notice] = 'There was a problem creating your account.'
      if @user.errors.any?
        flash[:notice] << '<br/><ul>'
        @user.errors.full_messages.each do |msg|
          flash[:notice] << "<li>#{msg}</li>"
        end
        flash[:notice] << '</ul>'
      end
      render :action => :register
    end
  end

  def toggle_favorite
    if @current_user
      remove = false
      @current_user.favorites.each do |f|
        if params[:id].to_i == f.station.id
          f.destroy
          remove = true
        end
      end
      unless remove
        favorite = Favorite.new
        favorite.station_id = params[:id]
        favorite.user = @current_user
        favorite.save
      end
      render json: true
    else
      render json: false
    end
  end

  def edit_user
    @timezones = Timezone.all.order(name: :asc)
  end

  def update_user
    if @current_user.update(user_params)
      flash[:notice] = 'Your changes have been saved.'
      redirect_to :action => :edit_user
    else
      if @current_user.errors.any?
        flash[:notice] = 'There was a problem updating your account.'
        flash[:notice] << '<br/><ul>'
        @current_user.errors.full_messages.each do |msg|
          flash[:notice] << "<li>#{msg}</li>"
        end
        flash[:notice] << '</ul>'
      end
      @timezones = Timezone.all.order(name: :asc)
      render :action => :edit_user
    end
  end

  def update_password
    user = User.authenticate(@current_user.username, params[:password])
    if user
      user.update(user_params)
      flash[:notice] = 'Your password has been changed.'
      redirect_to :action => :edit_password
    else
      flash[:notice] = 'The existing password you entered is incorrect.'
      render :action => :edit_password
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :name, :email, :password, :password_confirmation, :timezone_id)
  end

end
