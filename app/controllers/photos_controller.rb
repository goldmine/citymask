class PhotosController < ApplicationController
  before_filter :find_user_album, :except => :recent_photos
  before_filter :login_required, :except => [:index, :show, :recent_photos]
  # GET /photos
  # GET /photos.xml
  def index
    @photos = @album.photos

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @photos }
    end
  end
  
  def recent_photos
    @photos = Photo.recent_photos
  end

  # GET /photos/1
  # GET /photos/1.xml
  def show
    @photo = Photo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @photo }
    end
  end

  # GET /photos/new
  # GET /photos/new.xml
  def new
    @photo = Photo.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @photo }
    end
  end

  # GET /photos/1/edit
  def edit
    @photo = Photo.find(params[:id])
  end

  # POST /photos
  # POST /photos.xml
  def create
    @photo = Photo.new(params[:photo])
    @photo.album = @album
    @photo.user = @user
    respond_to do |format|
      if @photo.save!
        flash[:notice] = 'Photo was successfully created.'
        format.html { redirect_to user_album_photos_url(@user, @album) }
        format.xml  { render :xml => @photo, :status => :created, :location => @photo }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @photo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /photos/1
  # PUT /photos/1.xml
  def update
    @photo = Photo.find(params[:id])

    respond_to do |format|
      if @photo.update_attributes(params[:photo])
        flash[:notice] = 'Photo was successfully updated.'
        format.html { redirect_to user_album_photos_url(@user, @album) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @photo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /photos/1
  # DELETE /photos/1.xml
  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy

    respond_to do |format|
      format.html { redirect_to user_album_photos_url(@user, @album) }
      format.xml  { head :ok }
    end
  end
  
  def add_tag
    @photo = @user.photos.find(params[:id])
    @photo.tag_list << params[:tag][:name]
    @photo.save
    @new_tag = @photo.reload.tags.last
    
  end
  
  def remove_tag
    @photo = @user.photos.find(params[:id])
    @tag_to_delete = @photo.tags.find(params[:tag_id])
    if @tag_to_delete
      @photo.tags.delete(@tag_to_delete)
    else
      render :nothing =>  true
    end 

  end
  
  protected
  def find_user_album
    @user = User.find(params[:user_id]) if params[:user_id]
    @album = Album.find(params[:album_id]) if params[:album_id]
  end
end
