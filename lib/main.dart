import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:secure_net/views/all_log_view.dart';
import 'package:secure_net/views/main_view.dart';
import '/views/ssh_logs_view.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';


void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'SecureNet',
    theme: ThemeData(
      primarySwatch: Colors.blue,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
    home: SplashScreen(),
    routes: {
      '/ActiveSessionsView': (context) => ActiveSessionsView(),
      '/AllLogsView': (context) => AllLogsView(),
    },
  ));
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      duration: 2000, // 2 seconds
      splash: Stack(
        children: [
          Center(
            child: SvgPicture.asset('assets/splash_screen_logo.svg'),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Container(
              height: 44,
              width: 44, // Blue background color
              child: Center(
                child: SvgPicture.asset('assets/secure_net_below_splash_screen.svg'),
              ),
            ),
          ),
        ],
      ),
      splashIconSize: double.infinity,
      nextScreen: MainView(),
      splashTransition: SplashTransition.scaleTransition,
      pageTransitionType: PageTransitionType.fade,
      backgroundColor: Colors.white,
    );
  }
}
