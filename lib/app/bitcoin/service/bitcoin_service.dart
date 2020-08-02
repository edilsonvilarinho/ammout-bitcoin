import 'package:http/http.dart' as http;

class BitCoinService {
  Future<http.Response> requestApiBitCoin() async {
    try {
      http.Response response = await http.get("https://blockchain.info/ticker");
      return response;
    } catch (e) {
      return null;
    }
  }
}
