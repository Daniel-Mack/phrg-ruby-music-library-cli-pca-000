class Song
  attr_accessor :name, :genre
  attr_reader :artist
  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist = artist
    self.genre = genre
  end

  def self.all
    @@all
  end

  def self.destroy_all
    all.clear
  end

  def artist=(artist)
    @artist = artist
    if artist != nil
      artist.add_song(self)
    else
    end
  end

  def genre=(genre)
       @genre = genre
    if genre != nil
      genre.songs << self unless
      genre.songs.include? self
    else
    end
  end

  def save
    Song.all << self
  end

  def self.create(name)
    song = Song.new(name)
    song.save
    song
  end

  def self.find_by_name(name)
    self.all.detect {|song| song.name == name}
  end

  def self.new_from_filename(file_name)
    song_name = file_name.split(" - ").slice(1..1).join(" ")
    artist_name = file_name.split(" - ").slice(0)
    genre_name = file_name.split(" - ").slice(2).gsub!(".mp3", "")

    song = self.new(name)
    artist = Artist.find_or_create_by_name(artist_name)
    genre = Genre.find_or_create_by_name(genre_name)
    song.artist = artist
    song.name = song_name
    song.genre = genre
    song
  end

  def self.create_from_filename(file_name)
    song = self.new_from_filename(file_name)
    song.save
    song
  end

  def self.find_or_create_by_name(name)
    song_name = self.find_by_name(name)
    if song_name
      song_name
    else
      self.create(name)
    end
  end
end

