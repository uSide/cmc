module Pulls
  class Fetch < ApplicationTransaction
    step :fetch
    step :load
    step :parse
    step :sort
    step :process
    step :save

    private

    def fetch
      response = Faraday.get('https://api.coinmarketcap.com/v1/ticker/')
      Success(response: Oj.load(response.body))
    rescue Oj::ParseError
      Failure(:parse_error)
    end

    def load(input)
      Success(input.merge(currencies: Currency.all))
    end

    def parse(input)
      result = input[:currencies].map do |currency|
        pull = input[:response].find { |e| e['symbol'] == currency.key }
        { currency_id: currency.id, place: pull['rank'],
          price: pull['price_usd'], supply: pull['total_supply'],
          market_cap: pull['market_cap_usd'],
          change: pull['percent_change_24h'] }
      end
      Success(pulls: result)
    end

    def sort(input)
      result = input[:pulls].sort do |a, b|
        a[:place].to_i <=> b[:place].to_i
      end.each_with_index.map do |pull, index|
        pull[:place] = index
        pull
      end
      Success(pulls: result)
    end

    def process(input)
      major = input[:pulls].first
      result = input[:pulls].map do |pull|
        pull[:coin_price] = pull[:price].to_f / major[:price].to_f
        pull
      end
      Success(pulls: result)
    end

    def save(input)
      input[:pulls].each do |pull|
        Pull.create(pull.merge(created_at: Time.now.to_i))
      end
      Success({})
    end
  end
end
