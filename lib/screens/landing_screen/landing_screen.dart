import 'package:flutter/material.dart';
import 'package:freeforweebs/apis/auth.dart';
import 'package:freeforweebs/models/person.dart';
import 'package:freeforweebs/screens/auth_screen/auth_screen.dart';
import 'package:freeforweebs/screens/home_screen/home_screen.dart';

class LandingScreen extends StatelessWidget {
  LandingScreen({Key? key}) : super(key: key);

  final Auth auth = Auth();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Person?>(
      stream: auth.stream,
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data == null) {
          return AuthScreen(key: key);
        } else {
          Person person = snapshot.data!;
          return HomeScreen(person: person);
        }
      },
    );
  }
}
