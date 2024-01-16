class Admin::CategoriesController < ApplicationController
  before_action :require_admin

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
  
    if @category.save
      redirect_to [:admin, :categories], notice: 'Category created!'
    else
      render :new
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  # Add a before_action filter to require admin access
  def require_admin
    unless current_user&.admin?
      flash[:alert] = 'You are not authorized to access this page.'
      redirect_to root_path
    end
  end
end
