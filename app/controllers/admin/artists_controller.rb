# artists manager for admin
class Admin::ArtistsController < Admin::BaseController
  def index
    @artists = Artist.all
  end

  def create
    @artist = Artist.new(artist_params)
    if @artist.save
      flash[:notice] = 'artist was successfully create'
      redirect_to admin_artists_path
    else
      flash[:alert] = 'artist was failed to create'
      render :new
    end
  end

  def edit
    @artist = Artist.find(params[:id])
  end

  def update
    @artist = Artist.find(params[:id])
    if @artist.update(artist_params)
      flash[:notice] = 'artist was successfully update'
      redirect_to admin_artists_path
    else
      flash[:alert] = 'artist was failed to create'
      render :edit
    end
  end

  private

  def artist_params
    params.require(:artist).permit(:name, :photo, :youtube_link, :intro)
  end
end
