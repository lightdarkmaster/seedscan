// ignore: file_names
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:local_auth/local_auth.dart';
import 'package:seedscan2/pages/calendar_page.dart';
import 'package:seedscan2/pages/cornSeedLabel.dart';
//import 'package:seedscan2/pages/login.dart';
import '../pages/homescreen.dart';
import 'aboutus.dart';
import 'settings.dart';
import '../pages/capturepage.dart';
import 'aboutApp.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<Homepage> {


  int _page = 0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: PreferredSize(
        preferredSize:
            const Size.fromHeight(65.0), // Set your desired height here
        child: AppBar(
          title: const Text(
            "Seed Scan",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 191, 255, 139),
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 0,
        height: 60.0,
        items: const <Widget>[
          Icon(
            Icons.home,
            size: 30,
            color: Colors.black,
          ),
          Icon(
            Icons.yard_outlined,
            size: 30,
            color: Colors.black,
          ),
          Icon(
            Icons.photo_camera,
            size: 30,
            color: Colors.black,
          ),
          Icon(
            Icons.calendar_month,
            size: 30,
            color: Colors.black,
          ),
          Icon(
            Icons.settings,
            size: 30,
            color: Colors.black,
          ),
        ],
        color: const Color.fromARGB(255, 191, 255, 139),
        buttonBackgroundColor: const Color.fromARGB(255, 191, 255, 139),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
        letIndexChange: (index) => true,
      ),
      body: getPage(_page),
    );
  }

  Widget getPage(int page) {
    switch (page) {
      case 0:
        return const HomeWidget();
      case 1:
        return const CornLabel();
      case 2:
        return const CameraWidget();
      case 3:
        return CalendarPage();
      case 4:
        return const ProfilePage();
      default:
        return Container(); // Default page, you can replace it with another widget.
    }
  }
}
//