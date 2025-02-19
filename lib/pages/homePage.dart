import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:seedscan2/pages/app_descriptions.dart';
import 'package:seedscan2/pages/calculatorPage.dart';
import 'package:seedscan2/pages/detectionPages/history_tab.dart';
import 'package:seedscan2/pages/detectionPages/liveStreamOptions.dart';
import '../pages/homescreen.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<Homepage> {
  int _page = 0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: (_page != 1) // Hide AppBar when on the HistoryPage (index 1)
          ? PreferredSize(
              preferredSize:
                  const Size.fromHeight(65.0), // Set your desired height here
              child: AppBar(
                leading: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/images/logo1.png',
                      height: 30,
                    )),
                title: Text(
                  _getAppBarTitle(
                      _page), // Set the title dynamically based on the selected page
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                backgroundColor: const Color.fromARGB(255, 191, 255, 139),
              ),
            )
          : null, // No AppBar for the HistoryPage
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 0,
        height: 60.0,
        items: <Widget>[
          Image.asset(
            'assets/icons/home.png',
            width: 35,
            height: 35,
          ),
          Image.asset(
            'assets/icons/history.png',
            width: 35,
            height: 35,
          ),
          Image.asset(
            'assets/icons/camera.png',
            width: 35,
            height: 35,
          ),
          Image.asset(
            'assets/icons/calculator.png',
            width: 34,
            height: 34,
          ),
          Image.asset(
            'assets/icons/settings.png',
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

  // Get the page content based on the selected index
  Widget getPage(int page) {
    switch (page) {
      case 0:
        return const HomeWidget();
      case 1:
        return HistoryTab(); //const HelpFeedback();
      case 2:
        return const LiveStreamOptions();
      case 3:
        return CalculatorPage();
      case 4:
        return const AppDescriptions(); //return HistoryPage();
      default:
        return Container(); // Default page, you can replace it with another widget.
    }
  }

  // Get the AppBar title based on the selected page
  String _getAppBarTitle(int page) {
    switch (page) {
      case 0:
        return 'Home'; // Title for the Home page
      case 1:
        return 'User Manual'; // Title for the Instructions page
      case 2:
        return 'Seed Scanner'; // Title for the Live Stream page
      case 3:
        return 'Harvest Calculator'; // Title for the Calculator page
      case 4:
        return 'Settings'; // Title for the History page
      default:
        return 'Seed Scan'; // Default title
    }
  }
}
