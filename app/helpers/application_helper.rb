module ApplicationHelper
  
  def pending_store_count
    Store.unapproved.count
  end
end
