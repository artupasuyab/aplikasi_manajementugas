import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {

  final String baseUrl = "http://192.168.1.108:8000/api";

  // ================= LOGIN =================
  Future<dynamic> login(
    String email,
    String password,
  ) async {

    final response = await http.post(

      Uri.parse('$baseUrl/login'),

      headers: {
        'Accept': 'application/json',
      },

      body: {
        'email': email,
        'password': password,
      },
    );

    return jsonDecode(response.body);
  }

  // ================= GET TASKS =================
  Future<List<dynamic>> getTasks(
    String token,
  ) async {

    final response = await http.get(

      Uri.parse('$baseUrl/tasks'),

      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {

      final data = jsonDecode(response.body);

      // kalau response berbentuk:
      // { success:true, data:[...] }

      if (data is Map<String, dynamic>) {

        return data['data'] ?? [];
      }

      // kalau langsung array
      if (data is List) {

        return data;
      }

      return [];

    } else {

      throw Exception("Gagal mengambil data");
    }
  }

  // ================= ADD TASK =================
  Future<dynamic> addTask(
    String token,
    Map<String, String> data,
  ) async {

    final response = await http.post(

      Uri.parse('$baseUrl/tasks'),

      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },

      body: data,
    );

    return jsonDecode(response.body);
  }

  // ================= UPDATE TASK =================
  Future<dynamic> updateTask(
    String token,
    int id,
    Map<String, String> data,
  ) async {

    final response = await http.put(

      Uri.parse('$baseUrl/tasks/$id'),

      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },

      body: data,
    );

    return jsonDecode(response.body);
  }

  // ================= DELETE TASK =================
  Future<dynamic> deleteTask(
    String token,
    int id,
  ) async {

    final response = await http.delete(

      Uri.parse('$baseUrl/tasks/$id'),

      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    return jsonDecode(response.body);
  }

  // ================= LOGOUT =================
  Future<dynamic> logout(
    String token,
  ) async {

    final response = await http.post(

      Uri.parse('$baseUrl/logout'),

      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    return jsonDecode(response.body);
  }
}