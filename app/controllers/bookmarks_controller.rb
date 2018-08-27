class BookmarksController < ApplicationController
  before_action :find_bookmark, only: %i(edit update destroy)
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

  def edit; end

  def update
    @bookmark.update(bookmark_params)
  end

  def destroy
    @bookmark = current_user.bookmarks.find(params[:id])
    @bookmark.destroy if current_user.id == @bookmark.user_id
  end

  def welcome; end

  private
  def find_bookmark
    @bookmark = current_user.bookmarks.find(params[:id])
  end
  def bookmark_params
    params.require(:bookmark).permit(:name, :url)
  end
end
