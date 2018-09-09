class Currency < Sequel::Model
  plugin :tactical_eager_loading
  one_to_many :pulls
end
