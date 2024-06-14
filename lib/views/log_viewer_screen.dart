import 'package:flutter/material.dart';
import '../controllers/all_logs_controller.dart';

class LogViewerScreen extends StatefulWidget {
  final String logFileName;
  final String ipAddress;

  LogViewerScreen(this.logFileName, this.ipAddress);

  @override
  _LogViewerScreenState createState() => _LogViewerScreenState();
}

class _LogViewerScreenState extends State<LogViewerScreen> {
  List<String> logFiles = [];
  bool _isLoading = true;
  bool _hasError = false;
  String _logContent = '';

  final AllLogsController _controller = AllLogsController();

  @override
  void initState() {
    super.initState();
    _fetchLogFileContents();
  }

  Future<void> _fetchLogFileContents() async {
    try {
      final logContent =
      await _controller.fetchLogFileContents(widget.ipAddress, widget.logFileName);
      if (mounted) {
        setState(() {
          _logContent = logContent;
          _isLoading = false;
          _hasError = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _hasError = true;
        });
      }
      print('Error fetching log file contents: $e');
    }
  }

  @override
  void dispose() {
    super.dispose();
    // Cancel any ongoing operations like timers
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.logFileName),
        backgroundColor: Color(0xff223cbf),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _hasError
          ? Center(child: Text('Error fetching log file contents'))
          : SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Text(_logContent.isNotEmpty ? _logContent : 'No content'),
      ),
    );
  }
}
