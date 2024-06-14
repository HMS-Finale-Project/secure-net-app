import 'package:flutter/material.dart';
import '../controllers/ssh_logs_controller.dart';
import '../models/log_model.dart';
import 'dart:async';

class ActiveSessionsView extends StatefulWidget {
  @override
  _ActiveSessionsViewState createState() => _ActiveSessionsViewState();
}

class _ActiveSessionsViewState extends State<ActiveSessionsView> {
  List<Log> _logs = [];
  String _ipAddress = '';
  String _searchQuery = '';
  Timer? _timer;

  final SSHLogsController _controller = SSHLogsController();

  @override
  void initState() {
    super.initState();
    _loadIpAddress();
  }

  Future<void> _loadIpAddress() async {
    final ipAddress = await _controller.loadIpAddress();
    setState(() {
      _ipAddress = ipAddress;
    });
    if (_ipAddress.isNotEmpty) {
      _fetchLogs();
      _setupAutoRefresh();
    } else {
      print('No IP Address configured'); // Debugging statement
    }
  }

  Future<void> _fetchLogs() async {
    if (_ipAddress.isEmpty) return;
    try {
      final logs = await _controller.fetchLogs(_ipAddress, true); // Fetch only active sessions
      setState(() {
        _logs = logs;
      });
      print('Fetched Logs: ${_logs.length}'); // Debugging statement
    } catch (e) {
      print('Error fetching logs: $e');
    }
  }

  void _setupAutoRefresh() {
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      _fetchLogs();
    });
  }

  void _filterLogs(String query) {
    setState(() {
      _searchQuery = query;
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer before disposing
    super.dispose(); // Call super.dispose() after canceling the timer
  }

  @override
  Widget build(BuildContext context) {
    final filteredLogs = _logs.where((log) {
      return log.clientIP.contains(_searchQuery) ||
          log.lastActivity.contains(_searchQuery) ||
          log.lastCommand.contains(_searchQuery) ||
          log.sessionStart.contains(_searchQuery) ||
          log.tty.contains(_searchQuery) ||
          log.user.contains(_searchQuery);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('SSH Logs'),
        backgroundColor: Color(0xff223cbf),
      ),
      body: _ipAddress.isEmpty
          ? Center(child: Text('No configurations made'))
          : Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: _filterLogs,
            ),
          ),
          Expanded(
            child: filteredLogs.isEmpty
                ? Center(child: Text('No logs available'))
                : ListView.builder(
              itemCount: filteredLogs.length,
              itemBuilder: (context, index) {
                final log = filteredLogs[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      leading: Icon(
                        Icons.circle,
                        color: Colors.green,
                        size: 14.0,
                      ),
                      title: Text(
                        'User: ${log.user}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('Hacker IP: ${log.clientIP}'),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Session Details'),
                              content: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('Last Activity: ${log.lastActivity}'),
                                  Text('Last Command: ${log.lastCommand}'),
                                  Text('Session Start: ${log.sessionStart}'),
                                  Text('TTY: ${log.tty}'),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Close'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
