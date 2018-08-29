class BookmarksController < ApplicationController
  before_action :find_bookmark, only: %i(edit update destroy)
  def index
    @bookmarks = Bookmark.search( params[:q],
                          current_user.id )
                          .order(created_at: :desc)
                          .page(params[:page]) if current_user
  end
  def create
    @bookmark = Bookmark.create(bookmark_params.merge(user_id: current_user.id))
    @bookmark.get_webshot
  end

  def edit; end

  def update
    old_url = @bookmark.url
    @bookmark.update(bookmark_params)
    unless old_url == @bookmark.url
      @bookmark.get_webshot
    end
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
