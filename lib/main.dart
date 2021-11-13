import 'dart:async';

import 'package:flutter/material.dart';
import 'package:learn_flutter/home_screen.dart';
import 'package:learn_flutter/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      final prefs = await SharedPreferences.getInstance();
      runApp(MyApp(prefs: prefs));
    },
    (error, st) => print(error),
  );
}

class MyApp extends StatefulWidget {
  SharedPreferences? prefs;
  MyApp({Key? key, this.prefs}) : super(key: key);
  static const primaryColor = Color(0xFF151026);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      isLoggedIn = widget.prefs?.getBool('isLoggedIn') ?? false;
    });
  }

  setLoggin(value) async {
    widget.prefs?.setBool("isLoggedIn", value);
    setState(() {
      isLoggedIn = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: isLoggedIn
          ? MyHomePage(
              isLoggedIn: isLoggedIn,
              setLoggedIn: setLoggin,
              prefs: widget.prefs)
          : MyLoginPage(isLoggedIn: isLoggedIn, setLoggedIn: setLoggin),
    );
  }
}
