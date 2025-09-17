import 'dart:convert';
import 'package:http/http.dart' as http;

class ThingSpeakService {
  static const String _url =
      "https://api.thingspeak.com/channels/2769547/feeds.json?api_key=CLC2P68LXMZ7KDN4&results=1";

  Future<Map<String, dynamic>?> fetchLatestData() async {
    try {
      final response = await http.get(Uri.parse(_url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final feeds = data["feeds"] as List<dynamic>;
        if (feeds.isNotEmpty) {
          return feeds[0]; // contains entry_id, field3, field5, created_at
        }
      }
    } catch (e) {
      print("Error fetching data: $e");
    }
    return null;
  }
}
