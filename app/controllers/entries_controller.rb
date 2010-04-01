class EntriesController < ApplicationController
  before_filter :login_required, :except => [:index, :show]
  
  # GET /entries
  # GET /entries.xml
  def index
    @user = User.find(params[:user_id])
    @entries = Entry.paginate :page => params[:page], 
                              :conditions => ['user_id = ?', @user],
                              :order => 'updated_at DESC'
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @entries }
    end
  end

  # GET /entries/1
  # GET /entries/1.xml
  def show
    @entry = Entry.find_by_id_and_user_id(params[:id], params[:user_id], :include => [:user, [:comments => :user]])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @entry }
    end
  end

  # GET /entries/new
  # GET /entries/new.xml
  def new
    @entry = Entry.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @entry }
    end
  end

  # GET /entries/1/edit
  def edit
    @entry = @logged_in_user.entries.find(params[:id])
  end

  # POST /entries
  # POST /entries.xml
  def create
    @entry = Entry.new(params[:entry])
    respond_to do |format|
      if @logged_in_user.entries << @entry
        flash[:notice] = '博客发表成功！'
        format.html { redirect_to user_entries_path(@logged_in_user) }
        format.xml  { render :xml => @entry, :status => :created, :location => @entry }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @entry.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /entries/1
  # PUT /entries/1.xml
  def update
    @entry =  @logged_in_user.entries.find(params[:id])
    respond_to do |format|
      if @entry.update_attributes(params[:entry])
        flash[:notice] = 'Entry was successfully updated.'
        format.html { redirect_to user_entries_path(@logged_in_user) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @entry.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /entries/1
  # DELETE /entries/1.xml
  def destroy
    @entry =  @logged_in_user.entries.find(params[:id])
    @entry.destroy

    respond_to do |format|
      format.html { redirect_to user_entries_path(@logged_in_user) }
      format.xml  { head :ok }
    end
  end
end
