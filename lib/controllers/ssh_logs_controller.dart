import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/log_model.dart';

class SSHLogsController {
  Future<String> loadIpAddress() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('honeypot_ip') ?? '';
  }

  Future<List<Log>> fetchLogs(String ipAddress, bool isActiveSession) async {
    if (ipAddress.isEmpty) return [];
    final url = 'http://$ipAddress:5000/active_sessions';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List logs = json.decode(response.body);
      return logs.map((log) => Log.fromJson(log)).toList();
    } else {
      return [];
    }
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
