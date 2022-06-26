import 'package:flutter/material.dart';
import 'package:siapa/login/login.dart';
import 'package:siapa/mahasiswa/judul.dart';

class PenawaranTopik extends StatefulWidget {
  const PenawaranTopik({Key? key}) : super(key: key);

  @override
  State<PenawaranTopik> createState() => _PenawaranTopikState();
}

class _PenawaranTopikState extends State<PenawaranTopik> {
  @override
  Widget build(BuildContext context) {
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
                    alignment: Alignment.bottomLeft,
                    child: Icon(
                      Icons.account_circle_outlined,
                      color: Colors.white,
                      size: 55,
                    ),
                  ),
                  Container(
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
                      style: TextStyle(color: Colors.white, fontSize: 20),
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
                  return PenawaranTopik();
                }));
              },
              leading: Icon(Icons.calendar_today_outlined),
              title: Text(
                "Penawaran Topik",
                style: TextStyle(fontSize: 20),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return Judul();
                }));
              },
              leading: Icon(Icons.title),
              title: Text(
                "Judul Mahasiswa",
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
                  child: SizedBox(
                    width: 340,
                    height: 170,
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
                          Expanded(
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Container(
                                width: 60,
                                height: 23,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Color(0xffc4c4c4)),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    )),
                                  ),
                                  child: Text(
                                    "Ambil",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.black),
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
