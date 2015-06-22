class MoviesController < ApplicationController
 
  def index
    # @movies = Movie.all
    @movies = recent_or_search
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def new
    @movie = Movie.new
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def create
    @movie = Movie.new(movie_params)

    if @movie.save
      redirect_to movies_path, notice: "#{@movie.title} was submitted successfully!"
    else
      render :new
    end
  end

  def update
    @movie = Movie.find(params[:id])

    if @movie.update_attributes(movie_params)
      redirect_to movies_path
    else
      render :edit
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_path
  end

  def recent_or_search
    relation = Movie.all
    relation = 
    if params[:search]
      search = params[:search]
      relation = relation.where(director: search[:director]) unless search[:director].empty?
      relation = relation.where(title: search[:title]) unless search[:title].empty?
      if !search[:duration].empty? then
        runtime = case search[:duration]
        when '<=90' then '<= 90'
        when '90><120' then 'between 90 and 120'
        else '>=120'
        end
        relation = relation.where("runtime_in_minutes #{runtime}")
      end
      relation
    else
      relation.order(:created_at).limit(5)
    end
  end

  protected

  def movie_params
    params.require(:movie).permit(
      :title, :release_date, :director, :runtime_in_minutes, :poster_image_url, :description, :poster_image)
  end

end
