import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  static const baseUrl = "https://rickandmortyapi.com/api";

  Future<Map<String, dynamic>> get(String endpoint) async {
    final response = await http.get(Uri.parse("$baseUrl$endpoint"));

    if (response.statusCode != 200) {
      throw Exception("Failed to load data");
    }

    return jsonDecode(response.body);
  }
}