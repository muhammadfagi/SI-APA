import 'dart:convert' as convert;
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:siapa/koordinator/judulmahasiswa.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:siapa/login/pilihlogin.dart';

class LoginKoordinator extends StatefulWidget {
  const LoginKoordinator({Key? key}) : super(key: key);

  @override
  State<LoginKoordinator> createState() => _LoginKoordinatorState();
}

class _LoginKoordinatorState extends State<LoginKoordinator> {
  TextEditingController u = new TextEditingController();
  TextEditingController p = new TextEditingController();

  Future _loginKoordinator() async {
    print(u.text);
    // try {
    http.Response hasil = await http.post(
        Uri.https(
            'project.mis.pens.ac.id', '/mis112/siapa/loginkoordinator.php'),
        body: convert.jsonEncode({
          'netid': u.text,
          'password': p.text,
        }),
        headers: {
          "Accept": "application/json",
        });
    var dataUser = convert.jsonDecode(hasil.body);

    if (hasil.statusCode == 200) {
      if (dataUser['data'] == 'Koordinator') {
        var dataUser = convert.jsonDecode(hasil.body);
        print("Login Berhasil");
        print(dataUser);
        // print(dataUser);
        // print(dataUser['NIP']);
        await SessionManager().set('nip', dataUser["NIP"]);
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => const JudulMahasiswa()));
      } else {
        print("Bukan Koordinator");
      }
      return true;
    } else {
      print("error status " + hasil.statusCode.toString());
      return null;
    }
    // } catch (e) {
    //   print("error catchnya $e");
    //   return null;
    // }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_outlined),
            color: Color(0xFF578BB8),
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return PilihLogin();
              }));
            },
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          iconTheme: IconThemeData(color: Color(0xFF578BB8)),
        ),
        body: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(30),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 150, 0, 30),
                    child: Center(
                      child: Text(
                        "LOGIN KOORDINATOR",
                        style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Roboto-Regular"),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 289, 6),
                    child: Text(
                      "NetID",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ),
                  TextField(
                    controller: u,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: false,
                      hintText: "Masukkan NetID",
                      hintStyle: TextStyle(fontSize: 12),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 17, 256, 6),
                    child: Text(
                      "Password",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ),
                  TextField(
                    controller: p,
                    obscureText: true,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: false,
                      hintText: "Masukkan Password",
                      hintStyle: TextStyle(fontSize: 12),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
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
                        "Login",
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        _loginKoordinator();
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
