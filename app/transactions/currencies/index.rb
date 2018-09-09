module Currencies
  class Index < ApplicationTransaction
    step :load
    step :prepare

    private

    def load
      currencies = Currency.all.map do |currency|
        pulls = Pull
                .where(currency_id: currency.id)
                .order(Sequel.desc(:created_at))
        currency.values
                .slice(:id, :key, :name, :price, :avg_price, :supply)
                .merge(pulls: pulls.to_a)
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
