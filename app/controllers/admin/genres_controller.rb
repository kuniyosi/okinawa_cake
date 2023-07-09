class Admin::GenresController < ApplicationController
  before_action :authenticate_admin!

  def index
    @genre = Genre.new
    @genres = Genre.all
  end

  def create
    @genre = Genre.new(genre_params)
    if  @genre.save
      redirect_to admin_genres_path, notice: "You have created genre successfully."
    else
      @genres = Genre.all
      render :index
    end
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      redirect_to edit_admin_genre_path(@genre), notice: "You have updated genre successfully."
    else
      render :edit
    end
  end

  def destroy
    @genre = Genre.find(params[:id])
    if @genre.destroy
      redirect_to admin_genres_path
    else
      @genres = Genre.all
      render admin_genres_path
    end
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end
end
