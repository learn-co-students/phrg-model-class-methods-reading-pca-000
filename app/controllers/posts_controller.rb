# frozen_string_literal: true

class PostsController < ApplicationController
  def index
    @authors = Author.all
    @posts = if params[:author]
               Post.by_author(params[:author])
             elsif params[:date]
               params[:date] == "Today" ? Post.from_today : Post.old_news
             else
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
end
