module Currencies
  class Index < ApplicationTransaction
    step :load
    step :prepare

    private

    def load
      currencies = Currency.eager_graph(:pulls)
                           .order { pulls[:created_at] }
                           .all.map do |currency|
        currency.values
                .slice(:id, :key, :name, :price, :avg_price, :supply)
                .merge(pulls: currency.pulls.to_a)
      end
      Success(currencies: currencies)
    end

    def prepare(input)
      currencies = input[:currencies].map do |currency|
        latest = currency[:pulls].first.values
        chart = Oj.dump currency[:pulls].reverse.slice(0, 144).map(&:price)
        currency.merge(latest.slice(:place, :market_cap, :coin_price, :change))
                .merge(updated_at: latest[:created_at], chart: chart)
      end
      Success(updated_at: Pull.last.created_at,
              major: currencies.min { |c| c[:place] },
              currencies: currencies)
    end
  end
end
