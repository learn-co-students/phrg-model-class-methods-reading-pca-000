# frozen_string_literal: true

class PostsController < ApplicationController
  helper_method :params

  def index
    # provide a list of authors to the view for the filter control
    @authors = Author.all

    # filter the @posts list based on user input
    @posts =
      if !params[:author].blank?
        Post.by_author(params[:author])
      elsif !params[:date].blank?
        postsbydate
      else
        # if no filters are applied, show all posts
        Post.all
      end
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(params)
    @post.save
    redirect_to post_path(@post)
  end

  def update
    @post = Post.find(params[:id])
    @post.update(params.require(:post))
    redirect_to post_path(@post)
  end

  def edit
    @post = Post.find(params[:id])
  end

  def postsbydate
    if params[:date] == "Today"
      Post.from_today
    else
      Post.old_news
    end
  end
end
