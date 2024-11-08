import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seedscan2/pages/authenticate.dart';
//import 'package:seedscan2/pages/homePage.dart';
import 'package:seedscan2/theme/theme_provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => ThemeProvider(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SeedScan',
      debugShowCheckedModeBanner: false,
      home: const AuthenticateBiometric(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}

//Homepage(),
      //home: Homepage(),