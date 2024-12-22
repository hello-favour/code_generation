import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/public.dart';

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  Future<List<Public>> fetchPublics() async {
    final url = Uri.parse('$baseUrl/publics');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Public.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch publics');
    }
  }
}
