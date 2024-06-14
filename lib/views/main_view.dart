import 'package:flutter/material.dart';
import '../controllers/main_controller.dart';
import 'about.dart';
import 'ssh_honeypot_view.dart';
import 'user_list_page.dart'; // Import UserListPage

class MainView extends StatelessWidget {
  final MainController controller = MainController();

  @override
  Widget build(BuildContext context) {
    final options = controller.getOptions();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'SecureNet',
          style: TextStyle(color: Colors.white), // White text for AppBar
        ),
        backgroundColor: Color(0xff223cbf),
      ),
      body: ListView.builder(
        itemCount: options.length,
        itemBuilder: (context, index) {
          final option = options[index];
          return Card(
            child: ListTile(
              leading: Icon(option.icon, color: Color(0xff223cbf)),
              title: Text(
                option.title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900, // Heavy font weight
                  color: Color(0xff223cbf), // Color matching the theme
                ),
              ),
              subtitle: Text(
                option.description,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              onTap: () {
                if (option.title == 'Honeypots') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SSHHoneypotView(),
                    ),
                  );
                } else if (option.title == 'Network Administrators') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserListPage(),
                    ),
                  );
                } else if (option.title == 'About') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AboutPage(),
                    ),
                  );
                }
                // Add more navigation for other options if needed
              },
            ),
          );
        },
      ),
    );
  }
}
