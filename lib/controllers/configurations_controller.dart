import 'package:shared_preferences/shared_preferences.dart';

class ConfigurationsController {
  Future<void> saveConfigurations(String ip, bool sshEnabled, bool loggingEnabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('honeypot_ip', ip);
    await prefs.setBool('ssh_enabled', sshEnabled);
    await prefs.setBool('logging_enabled', loggingEnabled);
  }

  Future<Map<String, dynamic>> loadConfigurations() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'honeypot_ip': prefs.getString('honeypot_ip') ?? '',
      'ssh_enabled': prefs.getBool('ssh_enabled') ?? false,
      'logging_enabled': prefs.getBool('logging_enabled') ?? false,
    };
  }

  bool validateIp(String ip) {
    final regex = RegExp(r'^(\d{1,3}\.){3}\d{1,3}$');
    return regex.hasMatch(ip) && ip.split('.').every((octet) => int.parse(octet) <= 255);
  }

  Future<void> toggleSsh(bool enable) async {
    // Call your Python script to enable/disable SSH here
  }

  Future<void> toggleLogging(bool enable) async {
    // Call your Python script to enable/disable logging here
  }
}
