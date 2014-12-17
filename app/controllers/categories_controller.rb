class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy,:sub_categories]

  respond_to :html

  def index
    @categories = Category.all
    respond_with(@categories)
  end

  def show
    respond_with(@category)
  end

  def new
    @category = Category.new
    respond_with(@category)
  end

  def edit
    @sub_categories=@category.sub_categories
  end

  def create
    @category = Category.new(category_params)
    @category.user=current_user
    @category.save
    respond_with(@category)
  end

  def update
    @category.update(category_params)
    respond_with(@category)
  end

  def destroy
    @category.destroy
    respond_with(@category)
  end

  def sub_categories
    sub_categories=@category.sub_categories    
    sub_categories_json=sub_categories.to_json(:only => [ :slug, :name ])
    respond_to do |format|
      format.js
      format.json {render :json=>sub_categories_json}               
    end
  end

  private
    def set_category
      @category = Category.find_by_slug(params[:id])
    end

    def category_params
      params.require(:category).permit(:name,:sub_categories_create=>{:name=>[]},:sub_categories_update=>{:name=>[],:slug=>[]})
    end
end
