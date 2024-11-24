import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:seedscan2/pages/Instructions.dart';
import 'package:seedscan2/pages/calculatorPage.dart';
import 'package:seedscan2/pages/detectionPages/historyPage.dart';
import 'package:seedscan2/pages/detectionPages/liveStreamOptions.dart';
import '../pages/homescreen.dart';

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
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65.0), // Set your desired height here
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
        items: <Widget>[
          Image.asset(
            'assets/icons/home.png', // Path to your downloaded image
            width: 35,
            height: 35,
          ),
          Image.asset(
            'assets/icons/instructions.png', // Path to your downloaded image
            width: 35,
            height: 35,
          ),
          Image.asset(
            'assets/icons/camera.png', // Path to your downloaded image
            width: 35,
            height: 35,
          ),
          Image.asset(
            'assets/icons/corn3d.png', // Path to your downloaded image
            width: 35,
            height: 35,
          ),
          Image.asset(
            'assets/icons/history.png', // Path to your downloaded image
            width: 35,
            height: 35,
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
        return const HelpFeedback();
      case 2:
        return const LiveStreamOptions ();
      case 3:
        return CalculatorPage();
      case 4:
        return const HistoryPage(readings: [],);//ProfilePage();
      default:
        return Container(); // Default page, you can replace it with another widget.
    }
  }
}
