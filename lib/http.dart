import 'package:http/http.dart' as dartHttp;
import 'dart:convert';

class Http {
  Future<dynamic> get(url, header) async {
    dartHttp.Response response = await dartHttp.get(
      url,
      headers: header,
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    print(response.statusCode);
    return null;
  }
}
