import 'package:flutter/material.dart';
import 'package:siapa/dosen/penawaranjudul.dart';
import 'package:siapa/dosen/tambahtopik.dart';

class TambahTopik extends StatefulWidget {
  const TambahTopik({Key? key}) : super(key: key);

  @override
  State<TambahTopik> createState() => _TambahTopikState();
}

class _TambahTopikState extends State<TambahTopik> {
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
          "Tambah Topik",
          style: TextStyle(
              color: Color(0xFF578BB8),
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(30, 2, 30, 0),
            child: Column(
              children: <Widget>[
                // Topik
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 289, 6),
                  child: Text(
                    "Topik",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                  ),
                ),
                Container(
                  width: 340,
                  height: 40,
                  child: TextField(
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: false,
                      hintText: "Masukkan Topik",
                      hintStyle: TextStyle(fontSize: 12, letterSpacing: 0.5),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
                // Dosen Pembimbing
                Container(
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 6),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Dosen Pembimbing",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 5, 0, 6),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Dosen Pembimbing 1",
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w200),
                      ),
                    ),
                    Text(
                      "*",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w200,
                          color: Color(0xffEF0000)),
                    ),
                  ],
                ),
                SizedBox(
                  width: 340,
                  height: 40,
                  child: TextField(
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: false,
                      hintText: "Pilih Dosen",
                      hintStyle: TextStyle(fontSize: 12, letterSpacing: 0.5),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 5, 0, 6),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Dosen Pembimbing 2",
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w200),
                      ),
                    ),
                    Text(
                      "*",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w200,
                          color: Color(0xffEF0000)),
                    ),
                  ],
                ),
                SizedBox(
                  width: 340,
                  height: 40,
                  child: TextField(
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: false,
                      hintText: "Pilih Dosen",
                      hintStyle: TextStyle(fontSize: 12, letterSpacing: 0.5),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 5, 0, 6),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Dosen Pembimbing 3",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w200),
                  ),
                ),
                SizedBox(
                  width: 340,
                  height: 40,
                  child: TextField(
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: false,
                      hintText: "Pilih Dosen",
                      hintStyle: TextStyle(fontSize: 12, letterSpacing: 0.5),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
                // Konfirmasi
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: 141,
                        height: 36,
                        margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color(0xffEF0000)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            )),
                          ),
                          child: Text(
                            "Batal",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                          onPressed: () {},
                        ),
                      ),
                      Container(
                        width: 141,
                        height: 36,
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color(0xff20B726)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            )),
                          ),
                          child: Text(
                            "Simpan",
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w600),
                          ),
                          onPressed: () {},
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
