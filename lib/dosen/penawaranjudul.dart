import 'package:flutter/material.dart';
import 'package:siapa/dosen/tambahtopik.dart';
import 'package:siapa/dosen/detailtopik.dart';
import 'package:siapa/login.dart';

class PenawaranJudul extends StatefulWidget {
  const PenawaranJudul({Key? key}) : super(key: key);

  @override
  State<PenawaranJudul> createState() => _PenawaranJudulState();
}

class _PenawaranJudulState extends State<PenawaranJudul> {
  @override
  Widget build(BuildContext context) {
    final MediaQueryHeight = MediaQuery.of(context).size.height;
    final MediaQueryWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_outlined),
          color: Color(0xFF578BB8),
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return Login();
            }));
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          "Penawaran Judul",
          style: TextStyle(
              color: Color(0xFF578BB8),
              fontSize: 20,
              fontWeight: FontWeight.bold),
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
