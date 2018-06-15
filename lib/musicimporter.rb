class MusicImporter

  def initialize(path)
    @path = path
  end

  def path
    @path
  end

  def files
    Dir.entries(@path).select {|m| !File.directory? m}
  end

  def import
    files.each {|file_name| Song.create_from_filename(file_name)}
  end
end
