class Fixture
  def self.load(filename)
    path = File.join(File.dirname(__FILE__), '/fixtures', filename)
    File.read(path)
  end
end
