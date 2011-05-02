class StoresController < ApplicationController
  
  # GET /stores
  # GET /stores.xml
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
    @stores = stores || Store.all
    #@center = Store.optimal_origin
    #@bounds = Store.optimal_bounds
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @stores }
    end
  end

  # GET /stores/1
  # GET /stores/1.xml
  def show
    @store = Store.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @store }
    end
  end

  # GET /stores/new
  # GET /stores/new.xml
  def new
    @store = Store.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @store }
    end
  end

  # GET /stores/1/edit
  def edit
    @store = Store.find(params[:id])
  end

  # POST /stores
  # POST /stores.xml
  def create
    @store = Store.new(params[:store])

    respond_to do |format|
      if @store.save
        format.html { redirect_to(@store, :notice => 'Store was successfully created.') }
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
    @store = Store.find(params[:id])

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
    @store = Store.find(params[:id])
    @store.destroy

    respond_to do |format|
      format.html { redirect_to(stores_url) }
      format.xml  { head :ok }
    end
  end
end
