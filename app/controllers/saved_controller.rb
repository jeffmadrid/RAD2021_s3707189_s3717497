class SavedController < ApplicationController
  include SavedHelper
  before_action :init_saved
  
  
  
  
  def index
    @saved_list = [] #saved.map{|id| Item.find(id)}
    # puts "SAVEDLIST #{saved}"
  end
  
  # PUT saved/1 
  # aka url: saved_path(1), method: put
  # when eg: you click on a popular item button (submitting a form)
  def update
    item = Item.find(params[:id])
    
    if saved.include? item.id
      delete_saved item.id
      item.popularity -= 1
    else
      add_saved item.id
      item.popularity += 1
    end
    
    item.save
  end
  
end
