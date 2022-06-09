import 'package:flutter/material.dart';
import 'package:siapa/koordinator/detailjudulmahasiswa.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:siapa/koordinator/tanggal.dart';
import 'package:siapa/koordinator/rekapstatusdiambil.dart';
import 'package:siapa/login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'dart:async';

class JudulMahasiswa extends StatefulWidget {
  const JudulMahasiswa({Key? key}) : super(key: key);

  @override
  State<JudulMahasiswa> createState() => _JudulMahasiswaState();
}

class _JudulMahasiswaState extends State<JudulMahasiswa> {
  Future viewJudulMahasiswa() async {
    var url = Uri.https(
        'project.mis.pens.ac.id',
        '/mis112/siapa/koordinator/api/content/judulmahasiswa.php',
        {'function': 'viewJudulMahasiswa'});

    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonData = convert.jsonDecode(response.body);
      // print(jsonData['data']['JUDUL']);

      return jsonData['data'];
    } else {
      print('No Response');
    }
  }

  Future viewJudulMahasiswaDosen1() async {
    var url = Uri.https(
        'project.mis.pens.ac.id',
        '/mis112/siapa/koordinator/api/content/judulmahasiswa.php',
        {'function': 'viewJudulMahasiswaDosen1'});

    var response = await http.get(url);

    if (response.statusCode == 200) {
      dynamic jsonData = convert.jsonDecode(response.body);
      // print(jsonData['data']);

      return jsonData['data'];
    } else {
      print('No Response');
    }
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryHeight = MediaQuery.of(context).size.height;
    final MediaQueryWidth = MediaQuery.of(context).size.width;
    final MyAppBar = AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      title: Text(
        "Judul Mahasiswa Diterima",
        style: TextStyle(
            color: Color(0xFF578BB8),
            fontSize: 20,
            fontWeight: FontWeight.bold),
      ),
      iconTheme: IconThemeData(color: Color(0xFF578BB8)),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.filter_alt_outlined),
          color: Color(0xFF578BB8),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) =>
                  _buildPopUpJudulMahasiswa(context),
            );
          },
        ),
      ],
    );
    final BodyHeight = MediaQueryHeight -
        MyAppBar.preferredSize.height -
        MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: MyAppBar,
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
                Container(
                  width: MediaQueryWidth * 0.867,
                  height: MediaQueryHeight * 0.052,
                  child: TextField(
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: false,
                      prefixIcon: Icon(Icons.search_outlined),
                      hintText: "Cari NRP Mahasiswa",
                      hintStyle: TextStyle(fontSize: 12, letterSpacing: 0.5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                Card(
                  margin: EdgeInsets.fromLTRB(0, 14, 0, 0),
                  child: Container(
                    width: MediaQueryWidth * 0.867,
                    constraints: BoxConstraints(maxHeight: double.infinity),
                    child: SizedBox(
                      child: Container(
                        margin: EdgeInsets.all(20),
                        constraints: BoxConstraints(maxHeight: double.infinity),
                        child: Column(
                          children: [
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      width: 190,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Icon(
                                            Icons.person_outlined,
                                            color: Color(0xFF578BB8),
                                          ),
                                          Container(
                                            width: 150,
                                            child: FutureBuilder<dynamic>(
                                              future: viewJudulMahasiswa(),
                                              builder: (context, snapshot) {
                                                if (snapshot.error != null) {
                                                  return Text(
                                                    "${snapshot.error}",
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  );
                                                }
                                                if (snapshot.connectionState ==
                                                    ConnectionState.waiting) {
                                                  return Center(
                                                      child:
                                                          CircularProgressIndicator());
                                                } else {
                                                  return Container(
                                                      child: ListView.builder(
                                                          scrollDirection:
                                                              Axis.vertical,
                                                          shrinkWrap: true,
                                                          itemCount: 1,
                                                          itemBuilder:
                                                              (BuildContext
                                                                      context,
                                                                  index) {
                                                            return Text(
                                                              "${snapshot.data[index]["MAHASISWA"]}",
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  letterSpacing:
                                                                      1),
                                                            );
                                                          }));
                                                }
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      child: SizedBox(
                                        width: 27,
                                        height: 27,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              border: Border.all(
                                                color: Color(0xFF578BB8),
                                                width: 1.0,
                                              )),
                                          child: Center(
                                            child: Text(
                                              "1",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  letterSpacing: 1),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(
                                      Icons.title_outlined,
                                      color: Color(0xFF578BB8),
                                    ),
                                    Container(
                                      width: 260,
                                      child: FutureBuilder<dynamic>(
                                        future: viewJudulMahasiswa(),
                                        builder: (context, snapshot) {
                                          if (snapshot.error != null) {
                                            return Text(
                                              "${snapshot.error}",
                                              style: TextStyle(fontSize: 20),
                                            );
                                          }
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return Center(
                                                child:
                                                    CircularProgressIndicator());
                                          } else {
                                            return Container(
                                                child: ListView.builder(
                                                    scrollDirection:
                                                        Axis.vertical,
                                                    shrinkWrap: true,
                                                    itemCount: 1,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            index) {
                                                      return Text(
                                                        "${snapshot.data[index]["JUDUL"]}",
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            letterSpacing: 1),
                                                      );
                                                    }));
                                          }
                                        },
                                      ),
                                    ),
                                  ],
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
                              child: FutureBuilder<dynamic>(
                                future: viewJudulMahasiswaDosen1(),
                                builder: (context, snapshot) {
                                  if (snapshot.error != null) {
                                    return Text(
                                      "${snapshot.error}",
                                      style: TextStyle(fontSize: 20),
                                    );
                                  }
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                        child: CircularProgressIndicator());
                                  } else {
                                    return Text(
                                      "Pembimbing 1 : ${snapshot.data["NAMA"]}",
                                      style: TextStyle(
                                          color: Colors.black.withOpacity(0.5)),
                                    );
                                  }
                                },
                              ),
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
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
                                          borderRadius:
                                              BorderRadius.circular(5),
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
                                  IconButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(context,
                                          MaterialPageRoute(builder: (context) {
                                        return DetailJudulMahasiswa();
                                      }));
                                    },
                                    icon:
                                        Icon(Icons.arrow_forward_ios_outlined),
                                    color: Color(0xFF578BB8),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// pop up dosbing
List<String> data = ["Brazil", "Italia (Disabled)", "Tunisia", 'Canada'];
Widget _buildPopUpJudulMahasiswa(BuildContext context) {
  return new AlertDialog(
    title: const Text(
      'Filter',
      style: TextStyle(
          fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 0.5),
      textAlign: TextAlign.center,
    ),
    content: new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(0, 5, 0, 6),
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Text(
                "Tahun Ajaran",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w200),
              ),
              Text("*", style: TextStyle(color: Colors.red, fontSize: 20),)
            ],
          ),
        ),
        Container(
          height: 40.0,
          child: DropdownSearch<String>(
              mode: Mode.MENU,
              // showSelectedItem: true,
              items: data,
              hint: "country in menu mode",
              popupItemDisabled: (String s) => s.startsWith('I'),
              onChanged: print,
              selectedItem: "Brazil"),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(0, 5, 0, 6),
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Text(
                "Semester",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w200),
              ),
              Text("*", style: TextStyle(color: Colors.red, fontSize: 20),)
            ],
          ),
        ),
        Container(
          height: 40.0,
          child: DropdownSearch<String>(
              mode: Mode.MENU,
              // showSelectedItem: true,
              items: data,
              hint: "country in menu mode",
              popupItemDisabled: (String s) => s.startsWith('I'),
              onChanged: print,
              selectedItem: "Brazil"),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(0, 5, 0, 6),
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Text(
                "Program",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w200),
              ),
              Text("*", style: TextStyle(color: Colors.red, fontSize: 20),)
            ],
          ),
        ),
        Container(
          height: 40.0,
          child: DropdownSearch<String>(
              mode: Mode.MENU,
              // showSelectedItem: true,
              items: data,
              hint: "country in menu mode",
              popupItemDisabled: (String s) => s.startsWith('I'),
              onChanged: print,
              selectedItem: "Brazil"),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(0, 5, 0, 6),
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Text(
                "Jurusan",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w200),
              ),
              Text("*", style: TextStyle(color: Colors.red, fontSize: 20),)
            ],
          ),
        ),
        Container(
          height: 40.0,
          child: DropdownSearch<String>(
              mode: Mode.MENU,
              // showSelectedItem: true,
              items: data,
              hint: "country in menu mode",
              popupItemDisabled: (String s) => s.startsWith('I'),
              onChanged: print,
              selectedItem: "Brazil"),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(0, 5, 0, 6),
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Text(
                "Status Persetujuan",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w200),
              ),
              Text("*", style: TextStyle(color: Colors.red, fontSize: 20),)
            ],
          ),
        ),
        Container(
          height: 40.0,
          child: DropdownSearch<String>(
              mode: Mode.MENU,
              // showSelectedItem: true,
              items: data,
              hint: "country in menu mode",
              popupItemDisabled: (String s) => s.startsWith('I'),
              onChanged: print,
              selectedItem: "Brazil"),
        ),
      ],
    ),
    actions: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: 110,
            child: new ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                primary: Color(0xffEF0000), // background
                onPrimary: Colors.white, // foreground
              ),
              child: const Text('Batal'),
            ),
          ),
          SizedBox(
            width: 110,
            child: new ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                primary: Color(0xff20B726), // background
                onPrimary: Colors.white, // foreground
              ),
              child: const Text('Simpan'),
            ),
          ),
        ],
      ),
    ],
  );
}
