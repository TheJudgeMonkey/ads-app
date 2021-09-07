# frozen_string_literal: true

class CategoriesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
    @advertisements = @category.advertisements.pagination(params[:page])
  end

  def new
    @category = Category.new
    authorize @category
  end

  def create
    @category = Category.new(category_params)
    authorize @category
    if @category.save
      redirect_to categories_path, notice: t('.notice')
    else
      render :new
    end
  end

  def edit
    @category = Category.find(params[:id])
    authorize @category
  end

  def update
    @category = Category.find(params[:id])
    authorize @category

    if @category.update(category_params)
      redirect_to categories_path, notice: t('.notice')
    else
      render :edit
    end
  end

  def destroy
    @category = Category.find(params[:id])
    authorize @category

    @category.destroy

    redirect_to categories_path, notice: t('.notice')
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
