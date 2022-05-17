import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:siapa/dosen/penawaranjudul.dart';
import 'package:siapa/mahasiswa/judul.dart';
import 'package:siapa/koordinator/judulmahasiswa.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController u = new TextEditingController();
  TextEditingController p = new TextEditingController();
  String url = "https://project.mis.pens.ac.id/mis112/siapa/login.php";

  String msg = '';
  Future<dynamic> _login() async {
    final response = await http.post(
        Uri.parse(url),
        body: {
          "netid": u.text,
          "password": p.text,
        });
    print(response.body);
    var datauser = json.decode(response.body.toString());
    if (datauser.length == 0) {
      setState(() {
        msg = "Login Gagal";
      });
    }else{
      if(datauser[0]['status']=='active'){
        Navigator.pushReplacementNamed(context, '/judul');
      }else{
        print("Bukan Mahasiswa Aktif");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: <String, WidgetBuilder>{
        '/judul': (BuildContext context) => new Judul(),
      },
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
                        "Mahasiswa",
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        _login();
                        // log(u.text);
                        // log(p.text);
                      },
                    ),
                  ),
                  Text(
                    msg,
                    style: TextStyle(fontSize: 20, color: Colors.red),
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
                        "Koordinator",
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return JudulMahasiswa();
                        }));
                      },
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
                        "Dosen",
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return PenawaranJudul();
                        }));
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
