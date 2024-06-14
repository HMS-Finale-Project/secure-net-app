import 'package:flutter/material.dart';
import 'package:secure_net/views/ssh_log_options.dart';
import 'configurations_view.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SSHHoneypotView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'SSHHoneypot',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xff223cbf),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              width: 339.52,
              height: 278.31,
              child: Opacity(
                opacity: 0.9,
                child: SvgPicture.asset(
                  'assets/lady.svg', // Replace 'assets/lady.svg' with your SVG image path
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ConfigurationsView(),
                    ),
                  );
                },
                child: Text('Configurations'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SshLogOptions(),
                    ),
                  );
                },
                child: Text('SSH Logs'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
