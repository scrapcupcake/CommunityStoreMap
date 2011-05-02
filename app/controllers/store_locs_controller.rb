class StoreLocsController < ApplicationController
  def index
    @store_locs = StoreLoc.all
  end
  
  def find
    @location_name = params[:name]
    @loc = Geokit::Geocoders::GoogleGeocoder.geocode(@location_name, :bias => StoreLocsController.bias)
  end

  def show
    @store_loc = StoreLoc.find(params[:id])
  end

  def new
    @store_loc = StoreLoc.new
  end

  def create
    @store_loc = StoreLoc.new(params[:store_loc])
    if @store_loc.save
      redirect_to @store_loc, :notice => "Successfully created store loc."
    else
      render :action => 'new'
    end
  end

  def edit
    @store_loc = StoreLoc.find(params[:id])
  end

  def update
    @store_loc = StoreLoc.find(params[:id])
    if @store_loc.update_attributes(params[:store_loc])
      redirect_to @store_loc, :notice  => "Successfully updated store loc."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @store_loc = StoreLoc.find(params[:id])
    @store_loc.destroy
    redirect_to store_locs_url, :notice => "Successfully destroyed store loc."
  end

  private
  def self.bias
    @bias ||= Geokit::Geocoders::GoogleGeocoder.geocode("Pacific Northwest").suggested_bounds
  end
end
