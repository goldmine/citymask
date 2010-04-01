class AlbumsController < ApplicationController
  before_filter :login_required, :except => [:index, :show]
  before_filter :find_user
  
  # GET /albums
  # GET /albums.xml
  def index
    @albums = @user.albums

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @albums }
    end
  end

  # GET /albums/1
  # GET /albums/1.xml
  def show
    redirect_to user_album_photos_path(@user,params[:id])
  end

  # GET /albums/new
  # GET /albums/new.xml
  def new
    @album = Album.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @album }
    end
  end

  # GET /albums/1/edit
  def edit
    @album = Album.find_by_id_and_user_id(params[:id], @user)
  end

  # POST /albums
  # POST /albums.xml
  def create
    @album = Album.new(params[:album])
    respond_to do |format|
      if @user.albums << @album
        flash[:notice] = 'Album was successfully created.'
        format.html { redirect_to user_albums_path(@user) }
        format.xml  { render :xml => @album, :status => :created, :location => @album }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @album.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /albums/1
  # PUT /albums/1.xml
  def update
    @album = Album.find_by_id_and_user_id(params[:id], @user)

    respond_to do |format|
      if @album.update_attributes(params[:album])
        flash[:notice] = 'Album was successfully updated.'
        format.html { redirect_to user_albums_path(@user) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @album.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /albums/1
  # DELETE /albums/1.xml
  def destroy
    @album = Album.find(params[:id])
    @album.destroy

    respond_to do |format|
      format.html { redirect_to user_albums_path(@user) }
      format.xml  { head :ok }
    end
  end

  def find_user
    @user = User.find(params[:user_id]) if params[:user_id]
  end
end
