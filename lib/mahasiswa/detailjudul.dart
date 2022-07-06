import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:siapa/koordinator/judulmahasiswa.dart';
import 'package:siapa/mahasiswa/detailjudul.dart';
import 'package:siapa/mahasiswa/judul.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'dart:async';
import '../models/namadosen.dart';
import '../models/prioritas.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';

class DetailJudul extends StatefulWidget {
  final String nomor;

  const DetailJudul({Key? key, required this.nomor}) : super(key: key);

  @override
  State<DetailJudul> createState() => _DetailJudulState();
}

class _DetailJudulState extends State<DetailJudul> {
  Future viewDetailJudul() async {
    try {
      String nmr = widget.nomor;
      // String nmrQuery = nmr.toString();
      print(nmr);

      var url = Uri.https(
          'project.mis.pens.ac.id',
          '/mis112/siapa/mahasiswa/api/content/detailjudul.php/',
          {'function': 'viewDetailJudul', 'NOMOR': nmr});
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
          '/mis112/siapa/mahasiswa/api/content/viewdosenpembimbing.php/',
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
          '/mis112/siapa/mahasiswa/api/content/viewdosenpembimbing.php/',
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
          '/mis112/siapa/mahasiswa/api/content/viewdosenpembimbing.php/',
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

  final ReceivePort _port = ReceivePort();

  @override
  void initState() {
    super.initState();

    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];
      setState(() {});
    });

    FlutterDownloader.registerCallback(downloadCallback);
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort send =
        IsolateNameServer.lookupPortByName('downloader_send_port')!;
    send.send([id, status, progress]);
  }

  Future openfile(String url) async {
    var status = await Permission.storage.request();
    if (status.isGranted) {
      final baseStorage = await getExternalStorageDirectory();

      await FlutterDownloader.enqueue(
        url: url,
        savedDir: baseStorage!.path,
        showNotification:
            true, // show download progress in status bar (for Android)
        openFileFromNotification:
            true, // click on notification to open downloaded file (for Android)
      );
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
              future: viewDetailJudul(),
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
                                              _buildPopupDialog(context),
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
                                    IconButton(
                                      alignment: Alignment.topRight,
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              _buildPopupRangkuman(context),
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
                                              _buildPopupPembimbing(context),
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
                                                  ("${snapshot.data["STATUS"]}" ==
                                                          '1')
                                                      ? "Diterima"
                                                      : ("${snapshot.data["STATUS"]}" ==
                                                              '2')
                                                          ? "Ditolak"
                                                          : "Belum Diset",
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
                              // // Catatan
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
                                            child: (snapshot.data["CATATAN"] != null) ?  Text(
                                              "${snapshot.data["CATATAN"]}",
                                              style: TextStyle(fontSize: 14),
                                              maxLines: 6,
                                              overflow: TextOverflow.ellipsis,
                                            ) : Text(
                                              "Belum Ada Catatan",
                                              style: TextStyle(fontSize: 14),
                                              maxLines: 6,
                                              overflow: TextOverflow.ellipsis,
                                            )
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

                              // // Prioritas
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
                                              "Prioritas",
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
                                              "${snapshot.data["PRIORITAS"]}",
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
                                              _buildPopupPrioritas(context),
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
                                                        MaterialStateProperty
                                                            .all<Color>(Color(
                                                                0xffc4c4c4)),
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
                                                  }
                                                  
                                                  ),
                                            ),
                                          ),
                                          // Text("${snapshot.data["NOMOR"]}.pdf"),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      alignment: Alignment.topRight,
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              _buildPopupFile(context),
                                        );
                                      },
                                      icon: Icon(Icons.edit_outlined),
                                      color: Color(0xFF578BB8),
                                      iconSize: 30.0,
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

  Future updateJudul() async {
    // try {

    String nmr = widget.nomor;
    // String nmrQuery = nmr.toString();
    print(nmr);
    // print(judul.text);
    http.Response hasil = await http.post(
        Uri.https(
            'project.mis.pens.ac.id',
            '/mis112/siapa/mahasiswa/api/content/detailjudul.php',
            {'function': 'editJudul'}),
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
  Widget _buildPopupDialog(BuildContext context) {
    return Center(
      child: Container(
        child: FutureBuilder<dynamic>(
          future: viewDetailJudul(),
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
                            hintText: "Masukkan Judul Baru",
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
                              updateJudul();
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) => Judul()));
                              // Navigator.push(context, MaterialPageRoute(builder: (_) => DetailJudul()));
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
            '/mis112/siapa/mahasiswa/api/content/detailjudul.php',
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
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => Judul()));
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

  String prioritas = "";
  // pop up catatan
  Future updatePrioritas() async {
    // try {
    String nmr = widget.nomor;
    // String nmrQuery = nmr.toString();
    print(nmr);
    // print(judul.text);
    http.Response hasil = await http.post(
        Uri.https(
            'project.mis.pens.ac.id',
            '/mis112/siapa/mahasiswa/api/content/detailjudul.php',
            {'function': 'editPrioritas'}),
        body: convert.jsonEncode({
          'NOMOR': nmr,
          'PRIORITAS': prioritas,
        }),
        headers: {
          "Accept": "application/json",
        });
    // var dataUser = convert.jsonDecode(hasil.body);
    print(hasil.body);
    // print(hasil.statusCode);
    if (hasil.statusCode == 200) {
      print("Prioritas Berhasil Diedit");
      return true;
    } else {
      print("error status " + hasil.statusCode.toString());
      print("Gagal");
      return false;
    }
    // } catch (e) {
    //   print("error catchnya $e");
    //   print("error");
    //   return null;
    // }
  }

  // TextEditingController catatan = new TextEditingController();
  Widget _buildPopupPrioritas(BuildContext context) {
    return Container(
      // child: FutureBuilder<dynamic>(
      //   future: updateCatatan(),
      //   builder: (context, snapshot) {
      //     if (snapshot.error != null) {
      //       return Text(
      //         "${snapshot.error}",
      //         style: TextStyle(fontSize: 20),
      //       );
      //     }
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return Center(child: CircularProgressIndicator());
      //     } else {
      //       // catatan.value = TextEditingValue(text: "tes");
      //       return
      //         Container(
              child: new AlertDialog(
                title: const Text(
                  'Edit Prioritas',
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
                        "Prioritas",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w200),
                      ),
                    ),
                    Container(
                      child: DropdownSearch<String>(
                        mode: Mode.MENU,
                        items: ["1", "2"],
                        hint: "Pilih Prioritas",
                        onChanged: (valueprioritas) {
                          setState(() {
                            prioritas = valueprioritas!;
                            // viewJudulMahasiswa(value);
                          });
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
                            updatePrioritas();
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => Judul()));
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
      //       );
      //     }
      //   },
      // ),
    );
  }

  // pop up rangkuman
  Future updateRangkuman() async {
    // try {

    String nmr = widget.nomor;
    // String nmrQuery = nmr.toString();
    print(nmr);
    // print(judul.text);
    http.Response hasil = await http.post(
        Uri.https(
            'project.mis.pens.ac.id',
            '/mis112/siapa/mahasiswa/api/content/detailjudul.php',
            {'function': 'editRangkuman'}),
        body: convert.jsonEncode({
          'NOMOR': nmr,
          'RANGKUMAN': rangkuman.text,
        }),
        headers: {
          "Accept": "application/json",
        });
    // var dataUser = convert.jsonDecode(hasil.body);
    print(hasil.body);
    // print(hasil.statusCode);
    if (hasil.statusCode == 200) {
      print("Rangkuman Berhasil Diedit");
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

  TextEditingController rangkuman = new TextEditingController();
  Widget _buildPopupRangkuman(BuildContext context) {
    return Container(
      // child: FutureBuilder<dynamic>(
      //   future: viewDetailJudul(),
      //   builder: (context, snapshot) {
      //     if (snapshot.error != null) {
      //       return Text(
      //         "${snapshot.error}",
      //         style: TextStyle(fontSize: 20),
      //       );
      //     }
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return Center(child: CircularProgressIndicator());
      //     } else {
      //       rangkuman.value =
      //           TextEditingValue(text: "${snapshot.data["RANGKUMAN"]}");
      //       return Container(
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
                        "Rangkuman",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w200),
                      ),
                    ),
                    SizedBox(
                      width: 340,
                      height: 350,
                      child: TextField(
                        // controller: rangkuman,
                        maxLines: 20,
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
                            updateRangkuman();
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => Judul()));
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
      //       );
      //     }
      //   },
      // ),
    );
  }

  // pop up catatan
  List<PlatformFile>? _files;

  void _openFile() async {
    _files = (await FilePicker.platform
            .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']))!
        .files;
  }

  Future updateFile() async {
    // try {
    String nmr = widget.nomor;

    var uri = Uri.https(
        'project.mis.pens.ac.id',
        '/mis112/siapa/mahasiswa/api/content/detailjudul.php',
        {'function': 'editDokumen'});
    var request = http.MultipartRequest('POST', uri);
    request.files.add(await http.MultipartFile.fromPath(
        'DOKUMEN', _files!.first.path.toString()));
    request.fields['MAHASISWA'] = nmr;
    var response = await request.send();
    final respStr = await response.stream.bytesToString();
    print(respStr);
    // } catch (e) {
    //   print("error catchnya $e");
    //   print("error");
    //   return null;
    // }
  }

  // TextEditingController catatan = new TextEditingController();
  Widget _buildPopupFile(BuildContext context) {
    return Container(
      // child: FutureBuilder<dynamic>(
      //   future: updateCatatan(),
      //   builder: (context, snapshot) {
      //     if (snapshot.error != null) {
      //       return Text(
      //         "${snapshot.error}",
      //         style: TextStyle(fontSize: 20),
      //       );
      //     }
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return Center(child: CircularProgressIndicator());
      //     } else {
      //       // catatan.value = TextEditingValue(text: "tes");
      //       return Container(
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
                        // controller: catatan,
                        readOnly: true,
                        onTap: _openFile,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: false,
                          hintText: "Pilih Dokumen",
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
                            updateFile();
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => Judul()));
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
      //       );
      //     }
      //   },
      // ),
    );
  }
}
