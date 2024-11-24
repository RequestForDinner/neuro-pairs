import 'package:http/http.dart' as http;

abstract final class InternetStatusChecker {
  static Future<bool> checkInternetStatus() async {
    try {
      const googleUrl = 'https://google.com';

      final response = await http.get(Uri.parse(googleUrl));

      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }
}
