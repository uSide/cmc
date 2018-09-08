class Currency < Sequel::Model
  one_to_many :pulls

  def latest
    pulls.last
  end
end
