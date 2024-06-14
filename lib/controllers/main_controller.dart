import '../models/option_model.dart';
import 'package:flutter/material.dart';

class MainController {
  List<OptionModel> getOptions() {
    return [
      OptionModel('Honeypots', 'Monitor and manage honeypots to detect and analyze unauthorized access attempts.', Icons.security),
      OptionModel('Firewalls', 'Configure and maintain firewalls to protect the network from unauthorized access and threats.', Icons.fireplace),
      OptionModel('Network Administrators', 'Receive alerts and monitor honeypots to ensure network security and manage incidents.', Icons.supervisor_account),
      OptionModel('About', 'Learn more about the application and its features.', Icons.info),
    ];
  }
}
