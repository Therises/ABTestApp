class BookmarksController < ApplicationController
  def index
    if params[:query].present?
      @bookmarks = Bookmark.search(params[:query]).page(params[:page]).per(12)
    elsif current_user
      @bookmarks = Bookmark.where(user_id: current_user.id).page(params[:page]).per(12)
    end
  end
  def create
    bookmark = Bookmark.create(bookmark_params.merge(user_id: current_user.id))
    bookmark.get_webshot
    redirect_back fallback_location: root_path
  end
  def edit
  end

  def destroy
    @bookmark = current_user.bookmark.id
    @bookmark.destroy
  end

  def welcome; end

  private
  def bookmark_params
    params.require(:bookmark).permit(:name, :url)
  end
end
