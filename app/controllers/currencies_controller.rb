class CurrenciesController < ApplicationController
  def index
    render html: 'index', context: Currencies::Index.perform.value!
  end

  def update
    Currency.with_pk!(body['currency_id']).update(body.slice('price', 'supply'))
    render json: { success: true }
  end
end
