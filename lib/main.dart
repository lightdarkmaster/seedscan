import 'package:flutter/material.dart';
import 'package:seedscan2/pages/authenticate.dart';
import 'package:seedscan2/pages/homePage.dart';
import 'package:seedscan2/theme/theme.dart';

void main() => runApp( MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthenticateBiometric(),
      theme: lightMode,
      darkTheme: darkMode,
    ));



//Homepage(),
      //home: Homepage(),
