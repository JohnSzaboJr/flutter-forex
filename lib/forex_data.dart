import 'package:forex_ticker/http.dart';

const List<String> currenciesList = [
  'EUR',
  'USD',
  'HUF',
  'GBP',
  'CNY',
  'JPY',
  'HKD',
  'INR',
];

const exchangeURL = 'https://api.apilayer.com/fixer/convert';
const apiKey = '';

class ForexData {
  Http http = Http();

  Future<dynamic> getExchangeRate(to, from) async {
    if (to == from) {
      return 1;
    }
    var data = await http.get(
      '$exchangeURL?to=$to&from=$from&amount=1',
      {
        'apikey': apiKey,
      },
    );
    return data == null ? 0 : data['result'];
  }
}
