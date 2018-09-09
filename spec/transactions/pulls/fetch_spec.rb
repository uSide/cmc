describe Pulls::Fetch do
  subject(:result) { Pulls::Fetch.perform }
  let!(:invalid_response) { double(body: 'invalid') }
  let!(:valid_response) do
    double(body: Fixture.load('pulls/valid.json'))
  end

  context 'when response from API is incorrect' do
    before do
      expect(Faraday).to receive(:get).once.and_return(invalid_response)
    end

    it 'fails with parse error' do
      expect(result.failure?).to eq(true)
      expect(result.failure).to eq(:parse_error)
    end
  end

  context 'when response from API is correct' do
    before do
      Currency.create(name: 'Bitcoin', key: 'BTC')
      Currency.create(name: 'Ethereum', key: 'ETH')
      expect(Faraday).to receive(:get).and_return(valid_response)
    end

    it 'creates pulls' do
      expect(result.success?).to eq(true)
      expect(Pull.count).to eq(2)
    end

    it 'calculates coin price' do
      expect(result.success?).to eq(true)
      expect(Pull.order(:coin_price).first.currency.key).to eq('ETH')
      expect(Pull.order(:coin_price).first.coin_price).to eq(0.0313829171289461)
    end
  end
end
