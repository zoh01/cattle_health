import 'dart:convert';
import 'package:http/http.dart' as http;

class ThingSpeakService {
  static const String _baseUrl =
      "https://api.thingspeak.com/channels/2769547/fields/4.json?api_key=CLC2P68LXMZ7KDN4&results=1";

  Future<Map<String, dynamic>?> fetchLatestFeed() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final feeds = data["feeds"] as List<dynamic>;

        if (feeds.isNotEmpty) {
          return feeds[0]; // contains field3 + entry_id + timestamp
        }
      }
    } catch (e) {
      print("Error fetching data: $e");
    }
    return null;
  }
}