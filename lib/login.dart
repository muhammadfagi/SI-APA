import 'dart:convert' as convert;
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:siapa/dosen/penawaranjudul.dart';
import 'package:siapa/mahasiswa/judul.dart';
import 'package:siapa/koordinator/judulmahasiswa.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_session/flutter_session.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController u = new TextEditingController();
  TextEditingController p = new TextEditingController();

  Future _loginMahasiswa() async {
    print(u.text);
    try {
      http.Response hasil = await http
          .post(Uri.https('project.mis.pens.ac.id', '/mis112/siapa/login.php'),
              body: convert.jsonEncode({
                'netid': u.text,
                'password': p.text,
              }),
              headers: {
            "Accept": "application/json",
          });
      var dataUser = convert.jsonDecode(hasil.body);
      if (hasil.statusCode == 200) {
        if (dataUser['Status'] == 'active') {
          var dataUser = convert.jsonDecode(hasil.body);
          print("Login Berhasil");
          print(dataUser);
          await FlutterSession().set('nrp', dataUser['NRP']);
          Navigator.push(context, MaterialPageRoute(builder: (_) => Judul()));
        } else {
          print("Bukan Mahasiswa Aktif");
        }
        return true;
      } else {
        print("error status " + hasil.statusCode.toString());
        return null;
      }
    } catch (e) {
      print("error catchnya $e");
      return null;
    }
  }

  // Future _loginDosen() async {
  //   print(u.text);
  //   print(p.text);
    
  //   try {
  //     http.Response hasil = await http.post(
  //         Uri.https('project.mis.pens.ac.id','/mis112/siapa/logindosen.php'),
  //         body: convert.jsonEncode({
  //           'netid': u.text,
  //           'password': p.text,
  //         }),
  //         headers: {
  //           "Accept": "application/json",
  //         });
  //     print(hasil.body);
  //     var dataUser = convert.jsonDecode(hasil.body);
  //     if (hasil.statusCode == 200) {
  //       if (dataUser['status'] == 'Koordinator') {
  //         print("Login Berhasil");
  //         Navigator.push(context, MaterialPageRoute(builder: (_) => JudulMahasiswa()));
  //       }else if (dataUser['status'] == 'Dosen') {
  //         print("Login Berhasil");
  //         Navigator.push(context, MaterialPageRoute(builder: (_) => PenawaranJudul()));
  //       }
  //       else {
  //         print("Login Gagal");
  //       }
  //       return true;
  //     } else {
  //       print("error status " + hasil.statusCode.toString());
  //       return null;
  //     }
  //   } catch (e) {
  //     print("error catchnya $e");
  //     return null;
  //   }
  // }

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
                        _loginMahasiswa();
                        // _loginDosen();
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
