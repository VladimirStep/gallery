class PicturesController < ApplicationController
  def index
    @pictures = Picture.all
  end

  def show
    @picture = Picture.find_by(id: params[:id], category_id: Category.find_by(category_name: params[:category_category_name]).id)
  end
end
