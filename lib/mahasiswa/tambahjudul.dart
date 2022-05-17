import 'dart:ui';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:siapa/mahasiswa/tambahjudul.dart';
import 'package:siapa/mahasiswa/judul.dart';

class TambahJudul extends StatefulWidget {
  const TambahJudul({Key? key}) : super(key: key);

  @override
  State<TambahJudul> createState() => _TambahJudulState();
}

class _TambahJudulState extends State<TambahJudul> {
  List<String> data = ["Brazil", "Italia (Disabled)", "Tunisia", 'Canada'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_outlined),
          color: Color(0xFF578BB8),
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return Judul();
            }));
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          "Tambah Judul",
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
                // Judul
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 289, 6),
                  child: Text(
                    "Judul",
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
                      hintText: "Masukkan Judul",
                      hintStyle: TextStyle(fontSize: 12, letterSpacing: 0.5),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)),
                    ),
                  ),
                ),
                // Rangkuman
                Container(
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 6),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Rangkuman",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(
                  width: 340,
                  height: 150,
                  child: TextField(
                    maxLines: 10,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: false,
                      hintText: "Masukkan Rangkuman",
                      hintStyle: TextStyle(fontSize: 12, letterSpacing: 0.5),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)),
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
                Container(
                  margin: EdgeInsets.fromLTRB(0, 5, 0, 6),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Dosen Pembimbing 1",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w200),
                  ),
                ),
                Container(
                  height: 40.0,
                  child: DropdownSearch<String>(
                      mode: Mode.MENU,
                      showSelectedItem: true,
                      items: data,
                      hint: "country in menu mode",
                      popupItemDisabled: (String s) => s.startsWith('I'),
                      onChanged: print,
                      selectedItem: "Brazil"),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 5, 0, 6),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Dosen Pembimbing 2",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w200),
                  ),
                ),
                Container(
                  height: 40.0,
                  child: DropdownSearch<String>(
                      mode: Mode.MENU,
                      showSelectedItem: true,
                      items: data,
                      hint: "country in menu mode",
                      popupItemDisabled: (String s) => s.startsWith('I'),
                      onChanged: print,
                      selectedItem: "Brazil"),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 5, 0, 6),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Dosen Pembimbing 3",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w200),
                  ),
                ),
                Container(
                  height: 40.0,
                  child: DropdownSearch<String>(
                      mode: Mode.MENU,
                      showSelectedItem: true,
                      items: data,
                      hint: "country in menu mode",
                      popupItemDisabled: (String s) => s.startsWith('I'),
                      onChanged: print,
                      selectedItem: "Brazil"),
                ),
                // File
                Container(
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 6),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Dokumen Usulan",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(
                  width: 340,
                  height: 40,
                  child: TextField(
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: false,
                      hintText: "Masukkan File",
                      hintStyle: TextStyle(fontSize: 12, letterSpacing: 0.5),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)),
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
