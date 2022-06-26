import 'package:flutter/material.dart';
import 'package:siapa/dosen/tambahtopik.dart';
import 'package:siapa/dosen/detailtopik.dart';
import 'package:siapa/koordinator/judulmahasiswa.dart';
import 'package:siapa/koordinator/rekapstatusdiambil.dart';
import 'package:siapa/koordinator/tanggal.dart';
import 'package:siapa/login/login.dart';

class PenawaranJudulKoor extends StatefulWidget {
  const PenawaranJudulKoor({Key? key}) : super(key: key);

  @override
  State<PenawaranJudulKoor> createState() => _PenawaranJudulKoorState();
}

class _PenawaranJudulKoorState extends State<PenawaranJudulKoor> {
  @override
  Widget build(BuildContext context) {
    final MediaQueryHeight = MediaQuery.of(context).size.height;
    final MediaQueryWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          "Penawaran Judul",
          style: TextStyle(
              color: Color(0xFF578BB8),
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
        iconTheme: IconThemeData(color: Color(0xFF578BB8)), 
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              height: 150,
              color: Color(0xFF578BB8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                      // margin: EdgeInsets.only(bottom: 10.0),
                      alignment: Alignment.bottomLeft,
                      child: Icon(
                        Icons.account_circle_outlined,
                        color: Colors.white,
                        size: 50,
                      )),
                  Container(
                    margin: EdgeInsets.only(top: 10.0),
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      "Muhammad Fagi",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      "2103191020",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return Tanggal();
                }));
              },
              leading: Icon(Icons.calendar_today_outlined),
              title: Text(
                "Setting Tanggal",
                style: TextStyle(fontSize: 20),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return JudulMahasiswa();
                }));
              },
              leading: Icon(Icons.title),
              title: Text(
                "Judul Mahasiswa",
                style: TextStyle(fontSize: 20),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return RekapStatusDiambil();
                }));
              },
              leading: Icon(Icons.view_list_outlined),
              title: Text(
                "Rekap Status Diambil",
                style: TextStyle(fontSize: 20),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return PenawaranJudulKoor();
                }));
              },
              leading: Icon(Icons.topic_outlined),
              title: Text(
                "Penawaran Topik",
                style: TextStyle(fontSize: 20),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomLeft,
                child: ListTile(
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return Login();
                    }));
                  },
                  leading: Icon(Icons.logout),
                  title: Text(
                    "Logout",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            child: Column(
              children: [
                Card(
                  margin: EdgeInsets.fromLTRB(26, 5, 26, 0),
                  child: Container(
                    width: MediaQueryWidth * 0.867,
                    constraints: BoxConstraints(maxHeight: double.infinity),
                    child: SizedBox(
                      child: Container(
                        margin: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: 300,
                                  child: Text(
                                    "Aplikasi Administrasi Judul Proyek Berbasis Mobile PENS",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 1),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              width: 233,
                              margin: EdgeInsets.fromLTRB(0, 11, 0, 11),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color(0xff578BB8).withOpacity(0.75),
                                  width: 1.0,
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Pembimbing 1 : Rengga Asmara, S.Kom., M.T.",
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.5)),
                              ),
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Pembimbing 2 : Nana Ramadijanti, S.Kom, M.Kom",
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.5)),
                              ),
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Pembimbing 3 : ",
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.5)),
                              ),
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // Container(
                                  //   width: 60,
                                  //   height: 23,
                                  //   child: ElevatedButton(
                                  //     style: ButtonStyle(
                                  //       backgroundColor:
                                  //           MaterialStateProperty.all<Color>(
                                  //               Color(0xffc4c4c4)),
                                  //       shape: MaterialStateProperty.all<
                                  //               RoundedRectangleBorder>(
                                  //           RoundedRectangleBorder(
                                  //         borderRadius: BorderRadius.circular(5),
                                  //       )),
                                  //     ),
                                  //     child: Text(
                                  //       "Ambil",
                                  //       style: TextStyle(
                                  //           fontSize: 12, color: Colors.black),
                                  //     ),
                                  //     onPressed: () {},
                                  //   ),
                                  // ),
                                  Text(
                                    "Diambil",
                                    style: TextStyle(color: Color(0xff20B726)),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.delete_outline),
                                        color: Color(0xFF578BB8),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          Navigator.pushReplacement(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return DetailTopik();
                                          }));
                                        },
                                        icon: Icon(
                                            Icons.arrow_forward_ios_outlined),
                                        color: Color(0xFF578BB8),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xff578BB8)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    )),
                  ),
                  child: Icon(
                    Icons.add_outlined,
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return TambahTopik();
                    }));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
