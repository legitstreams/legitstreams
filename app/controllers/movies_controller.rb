class MoviesController < ApplicationController
  # GET /movies
  # GET /movies.json
  has_scope :language
  has_scope :actor_1
  has_scope :actor_2
  has_scope :year

  def index

   # @movies = apply_scopes(Movie).order("year DESC").paginate(:per_page => 24, :page => params[:page])
    @movies = apply_scopes(Movie).order("(10*year + no_of_platforms) DESC").paginate(:per_page => 24, :page => params[:page])
    #@movies = Movie.search(params[:movie]).order(sort_column + " " + sort_direction)
    respond_to do |format|
      format.html # index.html.erb
      format.js { render :partial => "movies" }
    end
end

  # GET /movies/1
  # GET /movies/1.json
  def show
    @movie = Movie.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @movie }
    end
  end

  private

  def sort_column
    Movie.column_names.include?(params[:sort]) ? params[:sort] : "year"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end

  # GET /movies/new
  # GET /movies/new.json


  # GET /movies/1/edit


  # POST /movies
  # POST /movies.json


  # PUT /movies/1
  # PUT /movies/1.json

  # DELETE /movies/1
  # DELETE /movies/1.json
end
