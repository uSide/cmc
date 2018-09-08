Sequel.migration do
  up do
    create_table :pulls do
      primary_key :id
      foreign_key :currency_id, :currencies
      Integer :place, default: 0
      Float :price, default: 0.0
      Float :coin_price, default: 0.0
      Float :supply, default: 0
      Float :market_cap, default: 0
      Float :change, default: 0.0
      Integer :created_at
    end
  end

  down do
    drop_table :pulls
  end
end
