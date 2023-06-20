import 'package:flutter/material.dart';
import 'package:myshoe/Screens/Login/LoginScreens.dart';
import 'package:myshoe/routes.dart';
import 'package:myshoe/theme.dart';

void main() async {
  runApp(MaterialApp(
      title: "My Shoe",
      theme: theme(),
      initialRoute: LoginScreen.routeName,
      debugShowCheckedModeBanner: false,
      routes: routes));
}
