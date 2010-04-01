class CommentsController < ApplicationController
before_filter :login_required
  def create
    @entry =  Entry.find_by_id_and_user_id(params[:entry_id], params[:user_id])
    @user = @entry.user
    @comment = Comment.new(:user_id => @logged_in_user, :body => params[:comment][:body])
    if @user.enable_comments
      respond_to do |format|
        if @entry.comments << @comment
          flash[:notice] = ''
          format.html { redirect_to user_entry_path(@user, @entry) }
          format.xml  { render :xml => @comment, :status => :created, :location => @comment }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
        end
      end
    else
      flash[:error] = '博主不允许发表评论！'
      redirect_to user_entry_path(@user, @entry)
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @entry = @comment.entry
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to user_entry_path(@entry.user, @entry) }
      format.xml  { head :ok }
    end
  end
end
