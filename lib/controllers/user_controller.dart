// controllers/user_controller.dart

import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/user_model.dart';

class UserController {
  final String apiUrl = 'http://192.168.16.118:5000';

  Future<List<User>> fetchUsers() async {
    try {
      final response = await http.get(Uri.parse('$apiUrl/users'));
      if (response.statusCode == 200) {
        final List<dynamic> usersJson = json.decode(response.body);
        return usersJson.map((json) => User.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load users: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error loading users: $e');
    }
  }

  Future<void> addUser(User user) async {
    final response = await http.post(
      Uri.parse('$apiUrl/users'),
      body: json.encode(user.toJson()),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to add user');
    }
  }

  Future<void> updateUser(int index, User user) async {
    final response = await http.put(
      Uri.parse('$apiUrl/users/$index'),
      body: json.encode(user.toJson()),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update user');
    }
  }

  Future<void> deleteUser(int index) async {
    final response = await http.delete(Uri.parse('$apiUrl/users/$index'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete user');
    }
  }
}
