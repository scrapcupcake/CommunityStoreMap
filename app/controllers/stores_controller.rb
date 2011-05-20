class StoresController < ApplicationController
  respond_to :html, :xml, :json
  load_resource :only => [:show, :new, :create]
  load_and_authorize_resource :only => [:edit, :update, :destroy, :approve, :pending, :manage]
  
  # GET /stores
  # GET /stores.xml
  # These top three methods require custom resource loading or authorization
  def index
    distance = 50
    if params.has_key? :distance
      distance = params[:distance]
    end
    stores = nil
    if params[:storesearch] 
      if params[:storesearch].length <= 0
        flash[:warning] = "Unable to find location, please check your spelling and try again"
      end
      stores = Store.stores_near(params[:storesearch], distance)
      if not stores or stores.count == 0 
        flash[:warning] = "Unable to find location, please check your spelling and try again"
        stores = nil
      end
    end
    @stores = stores || Store.approved
    
    if request.xhr?
      render(:content_type=>'text/html', :layout => false, :partial => 'map_sidebar')
    else
      respond_with(@stores)
    end
  end
  
  def pending
    @pending = @stores.unapproved    
    
    respond_with(@pending)
  end
  
  def manage #may need to paginate later
  end

  # GET /stores/1
  # GET /stores/1.xml
  def show
    respond_with(@store)
  end

  # GET /stores/new
  # GET /stores/new.xml
  def new
    respond_with(@store)    
  end

  # GET /stores/1/edit
  def edit
  end

  # POST /stores
  # POST /stores.xml
  def create
    if can? :manage, @store
      @store.approved = true      
    end

    respond_to do |format|
      if @store.save
        msg = ''
        unless @store.approved
          msg = ', an administrator will need to approve it'
        end
        format.html { redirect_to(@store, :notice => "Store was successfully created#{msg}.") }
        format.xml  { render :xml => @store, :status => :created, :location => @store }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @store.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /stores/1
  # PUT /stores/1.xml
  def update
    respond_to do |format|
      if @store.update_attributes(params[:store])
        format.html { redirect_to(@store, :notice => 'Store was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @store.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /stores/1
  # DELETE /stores/1.xml
  def destroy
    @store.destroy

    respond_to do |format|
      format.html { redirect_to(stores_url) }
      format.xml  { head :ok }
    end
  end  
  
  def approve
    @store.approved = true
    @store.save
    
    respond_to do |format|
      format.html { redirect_to(pending_stores_url) }
    end
  end
  
  
end
