import 'package:flutter/material.dart';
import '../models/option_model.dart';
import '../models/ssh_log_options_model.dart';

class SshLogOptions extends StatelessWidget {
  final List<Option> options = [
    Option(
      title: 'Active Sessions',
      description: 'View currently active SSH sessions.',
      route: '/ActiveSessionsView',
    ),
    Option(
      title: 'All Logs',
      description: 'View all available SSH logs.',
      route: '/AllLogsView',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SecureNet'),
        backgroundColor: Color(0xff223cbf),
      ),
      body: ListView.builder(
        itemCount: options.length,
        itemBuilder: (context, index) {
          final option = options[index];
          return Card(
            child: ListTile(
              leading: Icon(
                index == 0 ? Icons.desktop_mac : Icons.list,
                color: const Color(0xff223cbf),
              ),
              title: Text(option.title),
              subtitle: Text(option.description),
              onTap: () {
                Navigator.pushNamed(context, option.route);
              },
            ),
          );
        },
      ),
    );
  }
}
