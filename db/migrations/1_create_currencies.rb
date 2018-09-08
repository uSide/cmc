Sequel.migration do
  up do
    create_table :currencies do
      primary_key :id
      String :name, unique: true
      String :key, unique: true
      Float :price, default: 0.0
      Float :avg_price, default: 0.0
      Float :supply, default: 0.0
    end
  end

  down do
    drop_table :currencies
  end
end
