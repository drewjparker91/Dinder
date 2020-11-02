class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
    if params[:add_friend]
      if !@user.friend_requests.include?(current_user) && !current_user.friend_requests.include?(@user)
        @user.friend_requests << current_user
      else
        current_user.friends << @user  
        @user.friends << current_user
        current_user.friend_requests.delete(@user)
      end
      redirect_to friends_path(current_user) and return
    end
    render :show
  end

  def edit
    @user = current_user
    render :edit
  end   

  def friends
    @user = User.find(params[:id])
    if params[:friend_search]
      @friends = User.friend_search(params[:friend_search])
    end
    render :friends
  end
end