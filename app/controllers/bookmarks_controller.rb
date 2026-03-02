class BookmarksController < ApplicationController

  def create
    @bookmark = Bookmark.new(bookmark_params)
    list_id = params[:list_id]
    list = List.find(list_id)
    @bookmark.list = list

    if @bookmark.save
      redirect_to list_path(list)
    else
      render "lists/show"
    end
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:comment, :movie_id)
  end
end
