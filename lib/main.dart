import 'package:flutter/material.dart';
import 'package:flutter_socket_io_chat/service_locator.dart';
import 'package:flutter_socket_io_chat/ui/join_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocators();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Socket IO Chat',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.teal,
          accentColor: Colors.pink.withOpacity(.8),
          textTheme: TextTheme(
            title: TextStyle(color: Colors.white),
          ),
        ),
        home: JoinScreen());
  }

  @override
  void dispose() {
    disposeBlocs();
    super.dispose();
  }
}
