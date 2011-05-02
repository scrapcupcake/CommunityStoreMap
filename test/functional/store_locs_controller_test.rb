require 'test_helper'

class StoreLocsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => StoreLoc.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    StoreLoc.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    StoreLoc.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to store_loc_url(assigns(:store_loc))
  end

  def test_edit
    get :edit, :id => StoreLoc.first
    assert_template 'edit'
  end

  def test_update_invalid
    StoreLoc.any_instance.stubs(:valid?).returns(false)
    put :update, :id => StoreLoc.first
    assert_template 'edit'
  end

  def test_update_valid
    StoreLoc.any_instance.stubs(:valid?).returns(true)
    put :update, :id => StoreLoc.first
    assert_redirected_to store_loc_url(assigns(:store_loc))
  end

  def test_destroy
    store_loc = StoreLoc.first
    delete :destroy, :id => store_loc
    assert_redirected_to store_locs_url
    assert !StoreLoc.exists?(store_loc.id)
  end
end
