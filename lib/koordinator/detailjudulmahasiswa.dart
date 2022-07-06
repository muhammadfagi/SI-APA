import 'package:flutter/material.dart';
import 'package:siapa/koordinator/judulmahasiswa.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'dart:async';
import '../models/namadosen.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailJudulMahasiswa extends StatefulWidget {
  final String nomor;
  const DetailJudulMahasiswa({Key? key, required this.nomor}) : super(key: key);

  @override
  State<DetailJudulMahasiswa> createState() => _DetailJudulMahasiswaState();
}

class _DetailJudulMahasiswaState extends State<DetailJudulMahasiswa> {
  Future viewDetailJudulMahasiswa() async {
    try {
      // var widget;
      // var widget;
      String nmr = widget.nomor;
      // String nmrQuery = nmr.toString();
      print(nmr);

      var url = Uri.https(
          'project.mis.pens.ac.id',
          '/mis112/siapa/koordinator/api/content/detailjudulmahasiswa.php/',
          {'function': 'viewDetailJudulMahasiswa', 'NOMOR': nmr});
      // var response =
      //     await http.get(url, headers: {"Accept": "application/json"});
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var jsonData = convert.jsonDecode(response.body);

        return jsonData['data'];
      } else {
        print('No Response');
      }
    } catch (e) {
      print("error catchnya $e");
      return null;
    }
  }

  Future viewDospem1() async {
    try {
      String nmr = widget.nomor;
      // String nmrQuery = nmr.toString();
      print(nmr);

      var url = Uri.https(
          'project.mis.pens.ac.id',
          '/mis112/siapa/koordinator/api/content/viewdosenpembimbingkoordinator.php/',
          {'function': 'viewDosen1', 'NOMOR': nmr});
      // var response =
      //     await http.get(url, headers: {"Accept": "application/json"});
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var jsonData = convert.jsonDecode(response.body);

        return jsonData['data'];
      } else {
        print('No Response');
      }
    } catch (e) {
      print("error catchnya $e");
      return null;
    }
  }

  Future viewDospem2() async {
    try {
      String nmr = widget.nomor;
      // String nmrQuery = nmr.toString();
      print(nmr);

      var url = Uri.https(
          'project.mis.pens.ac.id',
          '/mis112/siapa/koordinator/api/content/viewdosenpembimbingkoordinator.php/',
          {'function': 'viewDosen2', 'NOMOR': nmr});
      // var response =
      //     await http.get(url, headers: {"Accept": "application/json"});
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var jsonData = convert.jsonDecode(response.body);

        return jsonData['data'];
      } else {
        print('No Response');
      }
    } catch (e) {
      print("error catchnya $e");
      return null;
    }
  }

  Future viewDospem3() async {
    try {
      String nmr = widget.nomor;
      // String nmrQuery = nmr.toString();
      print(nmr);

      var url = Uri.https(
          'project.mis.pens.ac.id',
          '/mis112/siapa/koordinator/api/content/viewdosenpembimbingkoordinator.php/',
          {'function': 'viewDosen3', 'NOMOR': nmr});
      // var response =
      //     await http.get(url, headers: {"Accept": "application/json"});
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var jsonData = convert.jsonDecode(response.body);

        return jsonData['data'];
      } else {
        print('No Response');
      }
    } catch (e) {
      print("error catchnya $e");
      return null;
    }
  }

  Future opendokumen() async {
    String nmr = widget.nomor;
    print(nmr);
    final url =  'https://project.mis.pens.ac.id/mis112/contents/fileberkas/' + nmr + ".pdf";
    if(await canLaunch(url)){
      await launch(url);
    }else {
      throw 'Could not launch $url';
    }
    // OpenFile.open("project.mis.pens.ac.id/mis112/contents/fileberkas/80.pdf");
  }

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
              return JudulMahasiswa();
            }));
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          "Detail Judul Anda",
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
            child: FutureBuilder<dynamic>(
              future: viewDetailJudulMahasiswa(),
              builder: (context, snapshot) {
                if (snapshot.error != null) {
                  return Text(
                    "${snapshot.error}",
                    style: TextStyle(fontSize: 20),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return Container(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: 1,
                      itemBuilder: (BuildContext context, index) {
                        return Container(
                          child: Column(
                            children: <Widget>[
                              // Nama
                              Container(
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      child: Icon(
                                        Icons.person_outlined,
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
                                              "Mahasiswa",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w100,
                                                  color: Colors.black
                                                      .withOpacity(0.6)),
                                            ),
                                          ),
                                          Container(
                                            margin:
                                                EdgeInsets.fromLTRB(0, 4, 0, 0),
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "${snapshot.data["MAHASISWA"]} - ${snapshot.data["NRP"]}",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          )
                                        ],
                                      ),
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
                                        color:
                                            Color(0xff578BB8).withOpacity(0.05),
                                        width: 1.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
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
                                              "Judul",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w100,
                                                  color: Colors.black
                                                      .withOpacity(0.6)),
                                            ),
                                          ),
                                          Container(
                                            margin:
                                                EdgeInsets.fromLTRB(0, 4, 0, 0),
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "${snapshot.data["JUDUL"]}",
                                              style: TextStyle(fontSize: 14),
                                              maxLines: 6,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      alignment: Alignment.topRight,
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              _buildPopupJudul(context),
                                        );
                                      },
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
                                        color:
                                            Color(0xff578BB8).withOpacity(0.05),
                                        width: 1.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              // Rangkuman
                              Container(
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      child: Icon(
                                        Icons.description_outlined,
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
                                              "Rangkuman",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w100,
                                                  color: Colors.black
                                                      .withOpacity(0.6)),
                                            ),
                                          ),
                                          Container(
                                            margin:
                                                EdgeInsets.fromLTRB(0, 4, 0, 0),
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "${snapshot.data["RANGKUMAN"]}",
                                              style: TextStyle(fontSize: 14),
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
                              Container(
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                    width: 298,
                                    margin: EdgeInsets.fromLTRB(0, 15, 0, 15),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color:
                                            Color(0xff578BB8).withOpacity(0.05),
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
                                                  color: Colors.black
                                                      .withOpacity(0.6)),
                                            ),
                                          ),
                                          Container(
                                            margin:
                                                EdgeInsets.fromLTRB(0, 4, 0, 0),
                                            alignment: Alignment.topLeft,
                                            child: FutureBuilder<dynamic>(
                                              future: viewDospem1(),
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
                                                  return Text(
                                                    "Pembimbing 1 : ${snapshot.data["NAMA"]}",
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  );
                                                }
                                              },
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.topLeft,
                                            child: FutureBuilder<dynamic>(
                                              future: viewDospem2(),
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
                                                  return Text(
                                                    "Pembimbing 2 : ${snapshot.data["NAMA"]}",
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  );
                                                }
                                              },
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.topLeft,
                                            child: FutureBuilder<dynamic>(
                                              future: viewDospem3(),
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
                                                  if (snapshot.data != null) {
                                                    return Text(
                                                      "Pembimbing 3 : ${snapshot.data["NAMA"]}",
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                    );
                                                  } else {
                                                    return Text(
                                                      "Pembimbing 3 : ",
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                    );
                                                  }
                                                }
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      alignment: Alignment.topRight,
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              _buildPopupPembimbing(
                                                  context),
                                        );
                                      },
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
                                        color:
                                            Color(0xff578BB8).withOpacity(0.05),
                                        width: 1.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              // Status
                              Row(
                                children: [
                                  // Status Persetujuan
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
                                          margin:
                                              EdgeInsets.fromLTRB(12, 0, 0, 0),
                                          width: 128.2,
                                          child: Column(
                                            children: <Widget>[
                                              Container(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  "Status Persetujuan",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w100,
                                                      color: Colors.black
                                                          .withOpacity(0.6)),
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    0, 4, 0, 0),
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  ("${snapshot.data["STATUS"]}" == '1') ? "Diterima" : ("${snapshot.data["STATUS"]}" == '2') ? "Ditolak" : "Belum Diset",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Color(0xff20B726)),
                                                  maxLines: 6,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Status Pengambilan
                                  (snapshot.data["ÄMBIL"] != null) ?
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
                                          margin:
                                              EdgeInsets.fromLTRB(12, 0, 0, 0),
                                          width: 128.5,
                                          child: Column(
                                            children: <Widget>[
                                              Container(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  "Status Pengambilan",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w100,
                                                      color: Colors.black
                                                          .withOpacity(0.6)),
                                                ),
                                              ),
                                              (snapshot.data["AMBIL"] == '1') ?
                                              Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    0, 4, 0, 0),
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  "Diambil",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Color(0xff20B726)),
                                                  maxLines: 6,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ) :
                                              Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    0, 4, 0, 0),
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  "Tidak Diambil",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Color(0xff20B726)),
                                                  maxLines: 6,
                                                  overflow:
                                                  TextOverflow.ellipsis,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ) : Container()
                                ],
                              ),
                              Container(
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                    width: 298,
                                    margin: EdgeInsets.fromLTRB(0, 15, 0, 15),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color:
                                            Color(0xff578BB8).withOpacity(0.05),
                                        width: 1.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              // Catatan
                              Container(
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      child: Icon(
                                        Icons.notes_outlined,
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
                                              "Catatan",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w100,
                                                  color: Colors.black
                                                      .withOpacity(0.6)),
                                            ),
                                          ),
                                          Container(
                                            margin:
                                                EdgeInsets.fromLTRB(0, 4, 0, 0),
                                            alignment: Alignment.topLeft,
                                            child: snapshot.data["CATATAN"] != null ? Text(
                                              "${snapshot.data["CATATAN"]}",
                                              style: TextStyle(fontSize: 14),
                                              maxLines: 6,
                                              overflow: TextOverflow.ellipsis,
                                            ) : Text("Belum Ada Catatan", style: TextStyle(fontSize: 14),
                                              maxLines: 6,
                                              overflow: TextOverflow.ellipsis,)
                                          )
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      alignment: Alignment.topRight,
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              _buildPopupCatatan(context),
                                        );
                                      },
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
                                        color:
                                            Color(0xff578BB8).withOpacity(0.05),
                                        width: 1.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              // File
                              Container(
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      child: Icon(
                                        Icons.history_edu_outlined,
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
                                              "Dokumen Pendukung",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w100,
                                                  color: Colors.black
                                                      .withOpacity(0.6)),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Container(
                                              width: 96,
                                              height: 26,
                                              margin: EdgeInsets.fromLTRB(
                                                  0, 4, 0, 0),
                                              child: ElevatedButton(
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all<
                                                              Color>(
                                                          Color(0xffc4c4c4)),
                                                  shape: MaterialStateProperty
                                                      .all<RoundedRectangleBorder>(
                                                          RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  )),
                                                ),
                                                child: Text(
                                                  "Open File",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black),
                                                ),
                                                onPressed: () {
                                                  opendokumen();
                                                },
                                              ),
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
                      },
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Future updateJudulMahasiswa() async {
    // try {

    String nmr = widget.nomor;
    // String nmrQuery = nmr.toString();
    print(nmr);
    // print(judul.text);
    http.Response hasil = await http.post(
        Uri.https(
            'project.mis.pens.ac.id',
            '/mis112/siapa/koordinator/api/content/detailjudulmahasiswa.php',
            {'function': 'editJudulMahasiswa'}),
        body: convert.jsonEncode({
          'NOMOR': nmr,
          'JUDUL': judul.text,
        }),
        headers: {
          "Accept": "application/json",
        });
    // var dataUser = convert.jsonDecode(hasil.body);
    print(hasil.body);
    // print(hasil.statusCode);
    if (hasil.statusCode == 200) {
      print("Judul Berhasil Diedit");
      return true;
    } else {
      print("error status " + hasil.statusCode.toString());
      print("Login Gagal");
      return false;
    }
    // } catch (e) {
    //   print("error catchnya $e");
    //   print("error");
    //   return null;
    // }
  }

  TextEditingController judul = new TextEditingController();
// popup judul
  Widget _buildPopupJudul(BuildContext context) {
    return Container(
      child: FutureBuilder<dynamic>(
        future: viewDetailJudulMahasiswa(),
        builder: (context, snapshot) {
          if (snapshot.error != null) {
            return Text(
              "${snapshot.error}",
              style: TextStyle(fontSize: 20),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            judul.value = TextEditingValue(text: "${snapshot.data["JUDUL"]}");
            return Container(
              child: new AlertDialog(
                title: const Text(
                  'Edit Judul',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5),
                  textAlign: TextAlign.center,
                ),
                content: new Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 5, 0, 6),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Judul",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w200),
                      ),
                    ),
                    SizedBox(
                      width: 340,
                      height: 40,
                      child: TextField(
                        controller: judul,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: false,
                          hintText: "tes tes",
                          hintStyle:
                              TextStyle(fontSize: 12, letterSpacing: 0.5),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5)),
                        ),
                      ),
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
                            updateJudulMahasiswa();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => JudulMahasiswa()));
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
              ),
            );
          }
        },
      ),
    );
  }

  // pop up dosbing
  String? nomordosen1;
  String? nomordosen2;
  String? nomordosen3;

  Future updateDosbing() async {
    // try {

    String nmr = widget.nomor;
    // String nmrQuery = nmr.toString();
    print(nmr);
    // print(judul.text);
    http.Response hasil = await http.post(
        Uri.https(
            'project.mis.pens.ac.id',
            '/mis112/siapa/koordinator/api/content/detailjudulmahasiswa.php',
            {'function': 'editDosenPembimbing'}),
        body: convert.jsonEncode({
          'NOMOR': nmr,
          'PEMBIMBING1': nomordosen1,
          'PEMBIMBING2': nomordosen2,
          'PEMBIMBING3': nomordosen3,
        }),
        headers: {
          "Accept": "application/json",
        });
    // var dataUser = convert.jsonDecode(hasil.body);
    print(hasil.body);
    // print(hasil.statusCode);
    if (hasil.statusCode == 200) {
      print("Dosen Berhasil Diedit");
      return true;
    } else {
      print("error status " + hasil.statusCode.toString());
      print("Login Gagal");
      return false;
    }
    // } catch (e) {
    //   print("error catchnya $e");
    //   print("error");
    //   return null;
    // }
  }

  Widget _buildPopupPembimbing(BuildContext context) {
    return new AlertDialog(
      title: const Text(
        'Edit Dosen Pembimbing',
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
            child: Text(
              "Dosen Pembimbing 1",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w200),
            ),
          ),
          Container(
            height: 40.0,
            child: DropdownSearch<NamaDosen>(
              mode: Mode.MENU,
              showSearchBox: true,
              // searchBoxController: dosbing3,
              hint: "Pilih Dosen",
              onChanged: (value) => nomordosen1 = value?.nomor,
              dropdownBuilder: (context, selectedItem) =>
                  Text(selectedItem?.nama ?? "Belum Memilih Dosen"),
              popupItemBuilder: (context, item, isSelected) => ListTile(
                title: Text(item.nama),
              ),
              onFind: (text) async {
                var url = Uri.https('project.mis.pens.ac.id',
                    '/mis112/siapa/mahasiswa/api/content/getnamapegawai.php/');
                var response = await http.get(url);
                if (response.statusCode == 200) {
                  List namadosen = (convert.jsonDecode(response.body)
                      as Map<String, dynamic>)['data'];
                  List<NamaDosen> dosen = [];
                  namadosen.forEach((element) {
                    dosen.add(NamaDosen(
                        nomor: element["NOMOR"],
                        nama: element["NAMA"],
                        gelarDpn: element["GELAR_DPN"],
                        gelarBlk: element["GELAR_BLK"]));
                  });
                  return dosen;
                } else {
                  return [];
                }
              },
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 5, 0, 6),
            alignment: Alignment.centerLeft,
            child: Text(
              "Dosen Pembimbing 2",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w200),
            ),
          ),
          Container(
            height: 40.0,
            child: DropdownSearch<NamaDosen>(
              mode: Mode.MENU,
              showSearchBox: true,
              // searchBoxController: dosbing3,
              hint: "Pilih Dosen",
              onChanged: (value) => nomordosen2 = value?.nomor,
              dropdownBuilder: (context, selectedItem) =>
                  Text(selectedItem?.nama ?? "Belum Memilih Dosen"),
              popupItemBuilder: (context, item, isSelected) => ListTile(
                title: Text(item.nama),
              ),
              onFind: (text) async {
                var url = Uri.https('project.mis.pens.ac.id',
                    '/mis112/siapa/mahasiswa/api/content/getnamapegawai.php/');
                var response = await http.get(url);
                if (response.statusCode == 200) {
                  List namadosen = (convert.jsonDecode(response.body)
                      as Map<String, dynamic>)['data'];
                  List<NamaDosen> dosen = [];
                  namadosen.forEach((element) {
                    dosen.add(NamaDosen(
                        nomor: element["NOMOR"],
                        nama: element["NAMA"],
                        gelarDpn: element["GELAR_DPN"],
                        gelarBlk: element["GELAR_BLK"]));
                  });
                  return dosen;
                } else {
                  return [];
                }
              },
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 5, 0, 6),
            alignment: Alignment.centerLeft,
            child: Text(
              "Dosen Pembimbing 3",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w200),
            ),
          ),
          Container(
            height: 40.0,
            child: DropdownSearch<NamaDosen>(
              mode: Mode.MENU,
              showSearchBox: true,
              // searchBoxController: dosbing3,
              hint: "Pilih Dosen",
              onChanged: (value) => nomordosen3 = value?.nomor,
              dropdownBuilder: (context, selectedItem) =>
                  Text(selectedItem?.nama ?? "Belum Memilih Dosen"),
              popupItemBuilder: (context, item, isSelected) => ListTile(
                title: Text(item.nama),
              ),
              onFind: (text) async {
                var url = Uri.https('project.mis.pens.ac.id',
                    '/mis112/siapa/mahasiswa/api/content/getnamapegawai.php/');
                var response = await http.get(url);
                if (response.statusCode == 200) {
                  List namadosen = (convert.jsonDecode(response.body)
                      as Map<String, dynamic>)['data'];
                  List<NamaDosen> dosen = [];
                  namadosen.forEach((element) {
                    dosen.add(NamaDosen(
                        nomor: element["NOMOR"],
                        nama: element["NAMA"],
                        gelarDpn: element["GELAR_DPN"],
                        gelarBlk: element["GELAR_BLK"]));
                  });
                  return dosen;
                } else {
                  return [];
                }
              },
            ),
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
                  updateDosbing();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => JudulMahasiswa()));
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

  Future updateCatatan() async {
    // try {

    String nmr = widget.nomor;
    // String nmrQuery = nmr.toString();
    print(nmr);
    // print(judul.text);
    http.Response hasil = await http.post(
        Uri.https(
            'project.mis.pens.ac.id',
            '/mis112/siapa/mahasiswa/api/content/detailjudul.php',
            {'function': 'editCatatan'}),
        body: convert.jsonEncode({
          'NOMOR': nmr,
          'CATATAN': catatan.text,
        }),
        headers: {
          "Accept": "application/json",
        });
    // var dataUser = convert.jsonDecode(hasil.body);
    print(hasil.body);
    // print(hasil.statusCode);
    if (hasil.statusCode == 200) {
      print("Judul Berhasil Diedit");
      return true;
    } else {
      print("error status " + hasil.statusCode.toString());
      print("Login Gagal");
      return false;
    }
    // } catch (e) {
    //   print("error catchnya $e");
    //   print("error");
    //   return null;
    // }
  }

  TextEditingController catatan = new TextEditingController();
  Widget _buildPopupCatatan(BuildContext context) {
    return Container(
      child: FutureBuilder<dynamic>(
        future: updateCatatan(),
        builder: (context, snapshot) {
          if (snapshot.error != null) {
            return Text(
              "${snapshot.error}",
              style: TextStyle(fontSize: 20),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            catatan.value = TextEditingValue(text: "tes");
            return Container(
              child: new AlertDialog(
                title: const Text(
                  'Edit Catatan',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5),
                  textAlign: TextAlign.center,
                ),
                content: new Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 5, 0, 6),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Catatan",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w200),
                      ),
                    ),
                    SizedBox(
                      width: 340,
                      height: 40,
                      child: TextField(
                        controller: catatan,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: false,
                          hintText: "Masukkan Catatan",
                          hintStyle:
                              TextStyle(fontSize: 12, letterSpacing: 0.5),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5)),
                        ),
                      ),
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
                            updateCatatan();
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => JudulMahasiswa()));
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
              ),
            );
          }
        },
      ),
    );
  }
}