class ItemsController < ApplicationController
  before_action :set_item, only: %i[ show edit update destroy ]

  # GET /items or /items.json
  def index
    @items = Item.all
  end

  # GET /items/1 or /items/1.json
  def show
    @bag_item = BagItem.new
    # for multiple images in carousel
    @item = Item.find(params[:id])
    @item_images = ItemImage.where(item_id: @item)
    @total_images_size = 1 + @item_images.size
    @tags = @item.tag_items.map(&:tag)

  end

  # GET /items/new
  def new
    @item = Item.new
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items or /items.json
  def create
    @item = Item.new(item_params)
    
    if @item.save
      redirect_to @item
    else
      render :new
    end
  end

  # PATCH/PUT /items/1 or /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item, notice: "Item was successfully updated." }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1 or /items/1.json
  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_url, notice: "Item was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # response is JSON array of colours 
  def get_colours
    @item = Item.find(params[:id])
    @colours = @item.variants_for(:colour, params[:size], nil)
    respond_to do |format|
      format.json { render :json => @colours }
    end
  end
  
  # response is JSON array of sizes
  def get_sizes
    @item = Item.find(params[:id])
    @sizes = @item.variants_for(:size, nil, params[:colour])
    respond_to do |format|
      format.json { render :json => @sizes }
    end
  end

  private
  
    def set_item
      @item = Item.find(params[:id])
    end

    def item_params
      params.require(:item).permit(:name, :description, :image_link, :price, :arrival_date)
    end
end