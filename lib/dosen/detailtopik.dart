import 'package:flutter/material.dart';
import 'package:siapa/dosen/penawaranjudul.dart';
import 'package:siapa/dosen/detailtopik.dart';

class DetailTopik extends StatefulWidget {
  const DetailTopik({Key? key}) : super(key: key);

  @override
  State<DetailTopik> createState() => _DetailTopikState();
}

class _DetailTopikState extends State<DetailTopik> {
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
              return PenawaranJudul();
            }));
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          "Detail Topik",
          style: TextStyle(
              color: Color(0xFF578BB8),
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(26, 10, 26, 0),
            child: Column(
              children: <Widget>[
                // Judul
                Container(
                  child: Row(
                    children: <Widget>[
                      Container(
                        child: Icon(
                          Icons.title_outlined,
                          color: Color(0xFF578BB8),
                          size: 30.0,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(12, 0, 0, 0),
                        width: 250.7,
                        child: Column(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Topik",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w100,
                                    color: Colors.black.withOpacity(0.6)),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 4, 0, 0),
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Aplikasi Administrasi Judul Proyek Berbasis Mobile PENS",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w400),
                              ),
                            )
                          ],
                        ),
                      ),
                      IconButton(
                        alignment: Alignment.topRight,
                        onPressed: () {},
                        icon: Icon(Icons.edit_outlined),
                        color: Color(0xFF578BB8),
                        iconSize: 30.0,
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      width: 298,
                      margin: EdgeInsets.fromLTRB(0, 15, 0, 15),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xff578BB8).withOpacity(0.05),
                          width: 1.0,
                        ),
                      ),
                    ),
                  ),
                ),

                // Dosen Pembimbing
                Container(
                  child: Row(
                    children: <Widget>[
                      Container(
                        child: Icon(
                          Icons.groups_outlined,
                          color: Color(0xFF578BB8),
                          size: 30.0,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(12, 0, 0, 0),
                        width: 250.7,
                        child: Column(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Dosen Pembimbing",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w100,
                                    color: Colors.black.withOpacity(0.6)),
                              ),
                            ),
                            // Container(
                            //   margin: EdgeInsets.fromLTRB(0, 4, 0, 0),
                            //   alignment: Alignment.topLeft,
                            //   child: Text(
                            //     "Aplikasi Administrasi Judul Proyek Berbasis Mobile PENS",
                            //     style: TextStyle(fontSize: 14),
                            //     maxLines: 6,
                            //     overflow: TextOverflow.ellipsis,
                            //   ),
                            // )
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 4, 0, 0),
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Pembimbing 1 : Rengga Asmara, S.Kom., M.T.",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Pembimbing 2 : Nana Ramadijanti, S.Kom, M.Kom",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Pembimbing 3 : ",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        alignment: Alignment.topRight,
                        onPressed: () {},
                        icon: Icon(Icons.edit_outlined),
                        color: Color(0xFF578BB8),
                        iconSize: 30.0,
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      width: 298,
                      margin: EdgeInsets.fromLTRB(0, 15, 0, 15),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xff578BB8).withOpacity(0.05),
                          width: 1.0,
                        ),
                      ),
                    ),
                  ),
                ),
                // Status
                Container(
                  child: Row(
                    children: <Widget>[
                      Container(
                        child: Icon(
                          Icons.info_outlined,
                          color: Color(0xFF578BB8),
                          size: 30.0,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(12, 0, 0, 0),
                        width: 128.5,
                        child: Column(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Status Pengambilan",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w100,
                                    color: Colors.black.withOpacity(0.6)),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 4, 0, 0),
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Diambil",
                                style: TextStyle(
                                    fontSize: 14, color: Color(0xff20B726)),
                                maxLines: 6,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
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
