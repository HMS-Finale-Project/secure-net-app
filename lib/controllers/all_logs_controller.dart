import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AllLogsController {
  Future<String> loadIpAddress() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('ipAddress') ?? '';
  }

  Future<List<String>> fetchLogFiles(String ipAddress) async {
    final response = await http.get(Uri.parse('http://$ipAddress:5000/list_logs'));

    if (response.statusCode == 200) {
      return List<String>.from(json.decode(response.body));
    } else {
      throw Exception('Failed to load log files');
    }
  }

  Future<String> fetchLogFileContents(String ipAddress, String fileName) async {
    final response = await http.get(Uri.parse('http://$ipAddress:5000/get_log?file=$fileName'));

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load log file contents');
    }
  }
}
