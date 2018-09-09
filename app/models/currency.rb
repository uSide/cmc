class Currency < Sequel::Model
  one_to_many :pulls
end
