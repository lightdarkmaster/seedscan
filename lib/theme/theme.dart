import "package:flutter/material.dart";

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    background: const Color.fromARGB(255, 255, 255, 255),
    primary: Colors.grey.shade300,
    secondary:  const Color.fromARGB(255, 110, 255, 115),
  )
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    background: Colors.grey.shade900,
    primary: Colors.grey.shade300,
    secondary: Colors.green,
  )
);