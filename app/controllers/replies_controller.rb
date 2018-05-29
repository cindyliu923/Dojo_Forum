class RepliesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_reply, only: [:destroy, :update, :edit]
  before_action :set_post
  before_action :authenticate_permit_user

  def create
    @reply = @post.replies.build(reply_params)
    @reply.user = current_user
    if @reply.save
      flash[:notice] = "Reply success！"
      redirect_to post_path(@post)
    else
      @post = Post.find(params[:post_id])     
      flash[:alert] = "Reply can't be blank or too long!!"
      redirect_to post_path(@post)
    end
  end

  def destroy
    @reply.destroy
    flash[:alert] = "reply was deleted"  
    redirect_back(fallback_location: root_path)
  end

  def update
    @reply.update_attributes(reply_params)
  end

  private

  def reply_params
    params.require(:reply).permit(:comment)
  end

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_reply
    @reply = Reply.find(params[:id])
  end

end
