import 'package:flutter/material.dart';
import 'package:kwayes/model/user.dart';
import 'package:kwayes/screens/home_screen.dart';
import 'package:kwayes/screens/welcome_screen.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Userr>(context);

    if (user == null) {
      return WelcomeScreen();
    } else {
      return HomeScreen();
    }
  }
}
