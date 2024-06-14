import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'About',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xff223cbf),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 339.52,
                  height: 278.31,
                  child: Opacity(
                    opacity: 0.9,
                    child: SvgPicture.asset('assets/splash_screen_logo.svg'), // Your SVG image
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Text(
                  'SecureNet',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff223cbf),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: Text(
                  'Version 1.0.0',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[600],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'About SecureNet',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'SecureNet is a state-of-the-art cybersecurity application designed to monitor network security and detect unauthorized access through honeypots. Our app provides real-time logging and detailed insights to help network administrators secure their environments.',
                style: TextStyle(
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Features',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                '• Real-time network monitoring\n'
                    '• Honeypot integration\n'
                    '• Detailed logging and reporting\n'
                    '• User-friendly interface\n'
                    '• Customizable alerts and notifications',
                style: TextStyle(
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Network Administrators',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              _buildAdminCard('Rejoice Banda', 'Lead Network Administrator'),
              SizedBox(height: 10),
              _buildAdminCard('Christian Nkanauena', 'Senior Network Administrator'),
              SizedBox(height: 10),
              _buildAdminCard('Wyness Chide', 'Network Security Specialist'),
              SizedBox(height: 10),
              _buildAdminCard('Joseph Wotcheni', 'Junior Network Administrator'),
              SizedBox(height: 20),
              Text(
                'Contact Us',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'If you have any questions or feedback, please contact us at:',
                style: TextStyle(
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Icon(Icons.email, color: Color(0xff223cbf)),
                  SizedBox(width: 10),
                  Text(
                    'support@securenet.com',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xff223cbf),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Icon(Icons.phone, color: Color(0xff223cbf)),
                  SizedBox(width: 10),
                  Text(
                    '+1 234 567 8900',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xff223cbf),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Center(
                child: Text(
                  '© 2024 SecureNet Inc.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAdminCard(String name, String title) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage('assets/admin_placeholder.png'), // Placeholder image
            ),
            SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
