describe Pulls::Refresh do
  subject(:result) { Pulls::Refresh.perform }
  let(:currency) { Currency.create(name: 'Bitcoin', key: 'BTC') }

  it 'calculates average price' do
    Pull.create(currency_id: currency.id,
                price: 10,
                created_at: Time.now.to_i)
    Pull.create(currency_id: currency.id,
                price: 5,
                created_at: Time.now.to_i)

    expect(result.success?).to eq(true)
    expect(Currency.first.avg_price).to eq(7.5)
  end

  it 'ignores old data' do
    Pull.create(currency_id: currency.id,
                price: 10,
                created_at: Time.now.to_i)
    Pull.create(currency_id: currency.id,
                price: 5,
                created_at: Time.now.to_i)
    Pull.create(currency_id: currency.id,
                price: 0,
                created_at: Time.now.to_i - (60 * 60 * 25))

    expect(result.success?).to eq(true)
    expect(Currency.first.avg_price).to eq(7.5)
  end
end
