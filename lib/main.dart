import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:siapa/login.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp
  ]);
  runApp(const SIAPA());
}

class SIAPA extends StatelessWidget {
  const SIAPA({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Login(),
    );
  }
}