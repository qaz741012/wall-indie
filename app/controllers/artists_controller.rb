class ArtistsController < ApplicationController
  before_action :authenticate_user!, only: [:follow, :unfollow, :favorite, :unfavorite]
  before_action :set_artist, only: [:show, :edit, :update, :destroy,
  :follow, :unfollow, :favorite, :unfavorite]

  # GET /artists
  # GET /artists.json
  def index
    @artists = Artist.all
  end

  # GET /artists/1
  # GET /artists/1.json
  def show
    @musics = @artist.musics.limit(5)
    @events = @artist.events
  end

  # GET /artists/new
  def new
    @artist = Artist.new
  end

  # GET /artists/1/edit
  def edit
  end

  # POST /artists
  # POST /artists.json
  def create
    @artist = Artist.new(artist_params)

    respond_to do |format|
      if @artist.save
        format.html { redirect_to @artist, notice: 'Artist was successfully created.' }
        format.json { render :show, status: :created, location: @artist }
      else
        format.html { render :new }
        format.json { render json: @artist.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /artists/1
  # PATCH/PUT /artists/1.json
  def update
    respond_to do |format|
      if @artist.update(artist_params)
        format.html { redirect_to @artist, notice: 'Artist was successfully updated.' }
        format.json { render :show, status: :ok, location: @artist }
      else
        format.html { render :edit }
        format.json { render json: @artist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /artists/1
  # DELETE /artists/1.json
  def destroy
    @artist.destroy
    respond_to do |format|
      format.html { redirect_to artists_url, notice: 'Artist was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

# 追蹤與加入最愛功能
  def follow
    artist_followship = @artist.artist_followships.build(user: current_user)
    if artist_followship.save
      flash[:notice] = "Successfully followed!"
    else
      flash[:alert] = artist_followship.errors.full_messages.to_sentence
    end
    redirect_back(fallback_location: root_path)
  end

  def unfollow
    artist_followship = @artist.artist_followships.where(user_id: current_user.id)[0]
    if artist_followship
      artist_followship.destroy
      flash[:notice] = "Successfully unfollowed!"
    else
      flash[:alert] = "You haven't followed the artist yet"
    end
    redirect_back(fallback_location: root_path)
  end

  def favorite
    favorite = @artist.favorits.build(user: current_user)
    if favorite.save
      flash[:notice] = "Successfully favorited!"
    else
      flash[:alert] = favorite.errors.full_messages.to_sentence
    end
    redirect_back(fallback_location: root_path)
  end

  def unfavorite
    favorite = @artist.favorits.where(user_id: current_user.id)[0]
    if favorite
      favorite.destroy
      flash[:notice] = "Successfully unfavorited!"
    else
      flash[:alert] = "You haven't favorited the artist yet"
    end
    redirect_back(fallback_location: root_path)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_artist
      @artist = Artist.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def artist_params
      params.require(:artist).permit(:name, :photo, :intro)
    end
end
