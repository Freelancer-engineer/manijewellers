import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class RateService {
  static const String baseUrl = "https://manijewellers.onrender.com/api/rates";

  static Future<Map<String, dynamic>?> getTodayRates() async {
    final url = Uri.parse("$baseUrl/get");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        return jsonDecode(response.body)['rate'];
      } else {
        print("❌ Failed to fetch today's rates: ${response.body}");
        return null;
      }
    } catch (e) {
      print("⚠️ Error: $e");
      return null;
    }
  }

  static Future<bool> updateRates({
    required double gold24k,
    required double gold22k,
    required double gold20k,
    required double gold18k,
    required double silver,
    required String date,
  }) async {
    final url = Uri.parse("$baseUrl/update");
    final String today = DateFormat('yyyy-MM-dd').format(DateTime.now());

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "date": today,
          "gold24k": gold24k,
          "gold22k": gold22k,
          "gold20k": gold20k,
          "gold18k": gold18k,
          "silver": silver,
        }),
      );

      if (response.statusCode == 200) {
        print("✅ Rates updated.");
        return true;
      } else {
        print("❌ Update failed: ${response.body}");
        return false;
      }
    } catch (e) {
      print("⚠️ Error: $e");
      return false;
    }
  }

  // ✅ NEW: Fetch rates by selected date
  static Future<Map<String, dynamic>?> fetchRatesByDate(String date) async {
    final url = Uri.parse("$baseUrl/get?date=$date");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['rate'];
      } else {
        print("❌ Failed to fetch rates for $date: ${response.body}");
        return null;
      }
    } catch (e) {
      print("⚠️ Error fetching rates for $date: $e");
      return null;
    }
  }
}
