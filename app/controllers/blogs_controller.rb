class BlogsController < ApplicationController
  def index
    @blogs = Entry.recent_blogs
  end

end
