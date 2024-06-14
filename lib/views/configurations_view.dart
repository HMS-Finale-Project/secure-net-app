import 'package:flutter/material.dart';
import '../controllers/configurations_controller.dart';

class ConfigurationsView extends StatefulWidget {
  @override
  _ConfigurationsViewState createState() => _ConfigurationsViewState();
}

class _ConfigurationsViewState extends State<ConfigurationsView> {
  final TextEditingController _ipController = TextEditingController();
  final ConfigurationsController _controller = ConfigurationsController();
  bool _isIpValid = false;
  bool _isSshEnabled = false;
  bool _isLoggingEnabled = false;

  @override
  void initState() {
    super.initState();
    _loadConfigurations();
  }

  Future<void> _loadConfigurations() async {
    final config = await _controller.loadConfigurations();
    setState(() {
      _ipController.text = config['honeypot_ip'];
      _isSshEnabled = config['ssh_enabled'];
      _isLoggingEnabled = config['logging_enabled'];
      _isIpValid = _controller.validateIp(_ipController.text);
    });
  }

  Future<void> _saveConfigurations() async {
    await _controller.saveConfigurations(
      _ipController.text,
      _isSshEnabled,
      _isLoggingEnabled,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Configurations',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xff223cbf),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _ipController,
              decoration: InputDecoration(
                labelText: 'Honeypot IP Address',
                labelStyle: TextStyle(fontWeight: FontWeight.bold),
                errorText: _isIpValid ? null : 'Invalid IP Address',
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  _isIpValid = _controller.validateIp(value);
                });
              },
              style: TextStyle(fontSize: 16),
            ),
            SwitchListTile(
              title: Text(
                'Enable SSH',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              value: _isSshEnabled,
              onChanged: _isIpValid
                  ? (value) async {
                await _controller.toggleSsh(value);
                setState(() {
                  _isSshEnabled = value;
                  _saveConfigurations();
                });
              }
                  : null,
            ),
            SwitchListTile(
              title: Text(
                'Enable SSH Logging',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              value: _isLoggingEnabled,
              onChanged: _isIpValid
                  ? (value) async {
                await _controller.toggleLogging(value);
                setState(() {
                  _isLoggingEnabled = value;
                  _saveConfigurations();
                });
              }
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
