module Pulls
  class Refresh < ApplicationTransaction
    step :load
    step :group
    step :process
    step :update

    private

    def load
      now = Time.now.to_i
      Success(pulls: Pull.where(created_at: (now - 60 * 60 * 24)..now))
    end

    def group(input)
      result = input[:pulls].to_a.group_by(&:currency_id)
      Success(currencies: result)
    end

    def process(input)
      result = input[:currencies].each_pair.map do |currency_id, pulls|
        pulls.max_by(&:created_at).values.slice(:price, :supply).merge(
          id: currency_id,
          avg_price: pulls.map(&:price).sum / pulls.count
        )
      end
      Success(currencies: result)
    end

    def update(input)
      input[:currencies].each do |currency|
        Currency.where(id: currency[:id]).update(currency)
      end
      Success({})
    end
  end
end
