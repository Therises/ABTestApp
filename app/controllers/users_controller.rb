class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    if params[:query].present?
      @bookmarks = Bookmark.search(params[:query]).page(params[:page]).per(12)
    else
      @bookmarks = Bookmark.where(user_id: @user.id).page(params[:page]).per(12)
    end
  end
  def friends
    @user = current_user
    @friends = @user.facebook.get_connections('me', 'friends').map do |e|
      User.find_by uid: e['id']
    end
  end
end
