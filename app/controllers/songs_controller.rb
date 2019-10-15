
class SongsController < ApplicationController
  def index
    @songs = Song.all
  end

  def show
    @song = Song.find(params[:id])
  end

  def new
    @song = Song.new
  end

  def create
    @song = Song.create({
        title: params[:song][:title], 
        artist_name: params[:song][:artist_name],
        genre_id: params[:song][:genre_id],
        note_contents: params["song_notes"]
      })
  
    # params["song_notes"].each do |note|
    #   if note != ""
    #     @song.notes << Note.create(content: note, song_id: @song.id)
    #   end
    # end

    if @song.save
      redirect_to @song
    else
      render :new
    end
  end

  def edit
    @song = Song.find(params[:id])
  end

  def update
    @song = Song.find(params[:id])

    @song.update(song_params)

    if @song.save
      redirect_to @song
    else
      render :edit
    end
  end

  def destroy
    @song = Song.find(params[:id])
    @song.destroy
    flash[:notice] = "Song deleted."
    redirect_to songs_path
  end

  private

  def song_params
    params.require(:song).permit(:title)
  end
end

