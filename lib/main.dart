import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:siapa/login.dart';
import 'dart:io';

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
void main() {
  HttpOverrides.global = MyHttpOverrides();
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