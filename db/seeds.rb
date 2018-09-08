[
  { "name": 'Bitcoin', "key": 'BTC' },
  { "name": 'Ethereum', "key": 'ETH' },
  { "name": 'XRP', "key": 'XRP' },
  { "name": 'Bitcoin Cash', "key": 'BCH' },
  { "name": 'EOS', "key": 'EOS' },
  { "name": 'Stellar', "key": 'XLM' },
  { "name": 'Litecoin', "key": 'LTC' },
  { "name": 'Tether', "key": 'USDT' },
  { "name": 'Cardano', "key": 'ADA' },
  { "name": 'Monero', "key": 'XMR' },
  { "name": 'IOTA', "key": 'MIOTA' },
  { "name": 'Dash', "key": 'DASH' },
  { "name": 'TRON', "key": 'TRX' },
  { "name": 'NEO', "key": 'NEO' },
  { "name": 'Ethereum Classic', "key": 'ETC' },
  { "name": 'Binance Coin', "key": 'BNB' },
  { "name": 'NEM', "key": 'XEM' },
  { "name": 'Tezos', "key": 'XTZ' },
  { "name": 'Dogecoin', "key": 'DOGE' },
  { "name": 'Zilliqa', "key": 'ZIL' }
].each { |currency| Currency.create(currency) }
