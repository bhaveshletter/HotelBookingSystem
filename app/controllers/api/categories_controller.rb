class Api::CategoriesController < Api::ApplicationController

  def index
    categories = Category.all
    @categories = { success: true, message: '', code: 200, data: categories }
  end

end
