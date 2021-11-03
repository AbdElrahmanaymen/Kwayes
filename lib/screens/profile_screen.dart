import 'package:flutter/material.dart';
import 'package:kwayes/services/auth.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFE5E5E5),
        body: Column(
          children: [
            IconButton(
                onPressed: () async {
                  await _auth.signOut();
                },
                icon: Icon(Icons.logout))
          ],
        ),
      ),
    );
  }
}
