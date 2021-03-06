class PostsController < ApplicationController
  before_filter :find_forum_topic
  # GET /posts
  # GET /posts.xml
  def index
    @posts = Post.paginate :page => params[:page], 
                           :include => :user,
                           :conditions => ['topic_id = ?', @topic],
                           :order => 'updated_at ASC'

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.xml
  def show

  end

  # GET /posts/new
  # GET /posts/new.xml
  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  # POST /posts
  # POST /posts.xml
  def create
    @post = Post.new(params[:post])
    @post.user = logged_in_user
    @post.topic = @topic
    
    respond_to do |format|
      if @post.save && @topic.update_attributes(:updated_at => Time.now)
        flash[:notice] = 'Post was successfully created.'
        format.html { redirect_to(forum_topic_posts_path(:forum_id => @forum, :topic_id => @topic)) }
        format.xml  { render :xml => @post, :status => :created, :location => @post }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.xml
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        flash[:notice] = 'Post was successfully updated.'
        format.html { redirect_to(forum_topic_posts_path(:forum_id => @forum, :topic_id => @topic)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.xml
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to(forum_topic_posts_path(:forum_id => @forum, :topic_id => @topic)) }
      format.xml  { head :ok }
    end
  end
  
  protected
  def find_forum_topic
    @forum = Forum.find(params[:forum_id])
    @topic = Topic.find(params[:topic_id])
  end
  
end
