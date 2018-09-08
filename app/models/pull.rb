class Pull < Sequel::Model
  many_to_one :currency
end
