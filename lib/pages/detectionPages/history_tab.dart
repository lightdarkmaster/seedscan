import 'package:flutter/material.dart';
import 'package:seedscan2/pages/detectionPages/corntype_history.dart';
import 'package:seedscan2/pages/detectionPages/historyPage.dart';

class HistoryTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 191, 255, 139),
          toolbarHeight: 20, // Set the height of the AppBar
          elevation: 0.0,
          bottom: const TabBar(
            indicatorColor: Colors.black,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.blue,
            tabs: [
              Tab(text: "Corn Viability"),
              Tab(text: "Corn Type"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            HistoryPage(),
            HistoryPage2(),
          ],
        ),
      ),
    );
  }
}
