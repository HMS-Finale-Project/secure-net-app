import 'package:flutter/material.dart';
import 'package:secure_net/controllers/ssh_logs_controller.dart';
import 'log_viewer_screen.dart';

class AllLogsView extends StatefulWidget {
  @override
  _AllLogsViewState createState() => _AllLogsViewState();
}

class _AllLogsViewState extends State<AllLogsView> {
  List<String> logFiles = [];
  String ipAddress = '';

  final SSHLogsController _controller = SSHLogsController();

  @override
  void initState() {
    super.initState();
    _loadIpAddress();
  }

  Future<void> _loadIpAddress() async {
    final ip = await _controller.loadIpAddress();
    setState(() {
      ipAddress = ip;
    });
    if (ipAddress.isNotEmpty) {
      _fetchLogFiles();
    } else {
      print('No IP Address configured'); // Debugging statement
    }
  }

  Future<void> _fetchLogFiles() async {
    if (ipAddress.isEmpty) return;
    try {
      final files = await _controller.fetchLogFiles(ipAddress);
      setState(() {
        logFiles = files;
      });
    } catch (e) {
      print('Error fetching log files: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Logs'),
        backgroundColor: Color(0xff223cbf),
      ),
      body: logFiles.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: logFiles.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Card(
              elevation: 3,
              child: ListTile(
                title: Text(logFiles[index]),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LogViewerScreen(logFiles[index], ipAddress),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
