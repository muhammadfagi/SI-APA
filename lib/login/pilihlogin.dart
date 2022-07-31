import 'dart:convert' as convert;
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:siapa/koordinator/judulmahasiswa.dart';
import 'package:siapa/login/login.dart';
import 'package:siapa/login/loginkoordinator.dart';
import 'package:siapa/mahasiswa/judul.dart';

class PilihLogin extends StatefulWidget {
  const PilihLogin({Key? key}) : super(key: key);

  @override
  State<PilihLogin> createState() => _PilihLoginState();
}

class _PilihLoginState extends State<PilihLogin> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(30),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 200, 0, 0),
                    child: Center(
                      child: Text(
                        "LOGIN",
                        style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Roboto-Regular"),
                      ),
                    ),
                  ),
                  Container(
                    width: 508,
                    height: 45,
                    margin: EdgeInsets.only(top: 11.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Color(0xff578BB8)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                      ),
                      child: Text(
                        "Login Mahasiswa",
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => Login()));
                      },
                    ),
                  ),
                  Container(
                    width: 508,
                    height: 45,
                    margin: EdgeInsets.only(top: 20.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Color(0xff578BB8)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                      ),
                      child: Text(
                        "Login Dosen & Koordinator",
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => LoginKoordinator()));
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
