class CurrenciesController < ApplicationController
  def index
    currencies = Currency.all
    render html: 'index', context: {
      major: currencies.find { |c| c.latest.place.zero? },
      currencies: currencies
    }
  end

  def update
    Currency.with_pk!(body['currency_id']).update(body.slice('price', 'supply'))
    render json: { success: true }
  end
end
