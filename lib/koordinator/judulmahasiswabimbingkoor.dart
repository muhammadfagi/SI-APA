import 'dart:io';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:siapa/dosen/detailjudulmahasiswabimbing.dart';
import 'package:siapa/koordinator/detailjudulmahasiswabimbingkoor.dart';
import 'package:siapa/koordinator/judulmahasiswa.dart';
import 'package:siapa/koordinator/rekapdosen.dart';
import 'package:siapa/koordinator/rekapstatusdiambil.dart';
import 'package:siapa/koordinator/tanggal.dart';
import 'package:siapa/login/pilihlogin.dart';
import 'package:siapa/mahasiswa/detailjuduldiluartanggal.dart';
import 'package:siapa/mahasiswa/judul.dart';
import 'package:siapa/mahasiswa/juduloranglain.dart';
import 'package:siapa/login/login.dart';
import 'package:siapa/mahasiswa/detailjudul.dart';
import 'package:siapa/mahasiswa/penawarantopik.dart';
import 'package:siapa/mahasiswa/tambahjudul.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'dart:async';
import 'package:flutter_session_manager/flutter_session_manager.dart';

class JudulMahasiswaBimbingKoor extends StatefulWidget {
  const JudulMahasiswaBimbingKoor({Key? key}) : super(key: key);

  @override
  State<JudulMahasiswaBimbingKoor> createState() => _JudulMahasiswaBimbingKoorState();
}

class _JudulMahasiswaBimbingKoorState extends State<JudulMahasiswaBimbingKoor> {
  Future viewJudulOrangLain() async {
    // try {
    int nip = await SessionManager().get('nip');
    String nipQuery = nip.toString();
    var url = Uri.https(
        'project.mis.pens.ac.id',
        '/mis112/siapa/dosen/api/content/judulmahasiswabimbing.php/',
        {'nip': nipQuery});

    var response = await http.get(url);
    var jsonData = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
      print(jsonData['data']);
      return jsonData['data'];
    } else {
      print('No Response');
    }
    // } catch (e) {
    //   print("error catchnya $e");
    //   return null;
    // }
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: const Text(
          "Judul Mahasiswa Dibimbing",
          style: TextStyle(
              color: Color(0xFF578BB8),
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Color(0xFF578BB8)),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              height: 150,
              color: const Color(0xFF578BB8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    // margin: EdgeInsets.only(bottom: 10.0),
                      alignment: Alignment.bottomLeft,
                      child: const Icon(
                        Icons.account_circle_outlined,
                        color: Colors.white,
                        size: 50,
                      )),
                  Container(
                    margin: const EdgeInsets.only(top: 10.0),
                    alignment: Alignment.bottomLeft,
                    child: const Text(
                      "Muhammad Fagi",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomLeft,
                    child: const Text(
                      "2103191020",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ListTile(
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                      return const Tanggal();
                    }));
              },
              leading: const Icon(Icons.calendar_today_outlined),
              title: const Text(
                "Setting Tanggal",
                style: const TextStyle(fontSize: 20),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                      return const JudulMahasiswa();
                    }));
              },
              leading: const Icon(Icons.title),
              title: const Text(
                "Judul Mahasiswa",
                style: TextStyle(fontSize: 20),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                      return const RekapStatusDiambil();
                    }));
              },
              leading: const Icon(Icons.view_list_outlined),
              title: const Text(
                "Rekap Status Diambil",
                style: TextStyle(fontSize: 20),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                      return const RekapDosen();
                    }));
              },
              leading: const Icon(Icons.topic_outlined),
              title: const Text(
                "Rekap Dosen",
                style: TextStyle(fontSize: 20),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                      return const JudulMahasiswaBimbingKoor();
                    }));
              },
              leading: const Icon(Icons.topic_outlined),
              title: const Text(
                "Judul Mahasiswa Dibimbing",
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
                          return const PilihLogin();
                        }));
                  },
                  leading: const Icon(Icons.logout),
                  title: const Text(
                    "Logout",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
            const SizedBox(
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
                FutureBuilder<dynamic>(
                  future: viewJudulOrangLain(),
                  builder: (context, snapshot) {
                    if (snapshot.error != null) {
                      return Text(
                        "${snapshot.error}",
                        style: const TextStyle(fontSize: 20),
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return Container(
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          // new
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, index) {
                            return Container(
                              child: Card(
                                margin:
                                const EdgeInsets.fromLTRB(26, 14, 26, 0),
                                child: Container(
                                  width: MediaQueryWidth * 0.867,
                                  constraints: const BoxConstraints(
                                      maxHeight: double.infinity),
                                  child: SizedBox(
                                    child: Container(
                                      margin: const EdgeInsets.all(20),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Container(
                                                width: 300,
                                                child: Text(
                                                  "${snapshot.data[index]["NAMA"]} - ${snapshot.data[index]["NRP"]}",
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                      FontWeight.w600,
                                                      letterSpacing: 1),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Container(
                                                width: 300,
                                                margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                                child: Text(
                                                  "${snapshot.data[index]["JUDUL"]}",
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                      FontWeight.w600,
                                                      letterSpacing: 1),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            width: 233,
                                            margin: const EdgeInsets.fromLTRB(
                                                0, 11, 0, 11),
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: const Color(0xff578BB8)
                                                    .withOpacity(0.75),
                                                width: 1.0,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.fromLTRB(
                                                0, 4, 0, 0),
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              // "Pembimbing ${snapshot.data[index]} : ${snapshot.data.dosen[index]["NAMA"]}",
                                              "Pembimbing 1 : ${snapshot.data[index]["BIMBING1"]}",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "Pembimbing 2 : ${snapshot.data[index]["BIMBING2"]}",
                                              style: TextStyle(
                                                  color: Colors.black
                                                      .withOpacity(0.5)),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.topLeft,
                                            child: (snapshot.data[index]["BIMBING3"] == null) ?
                                            Text(
                                              "Pembimbing 3 : ",
                                              style: TextStyle(
                                                  color: Colors.black
                                                      .withOpacity(0.5)),
                                            ) :
                                            Text(
                                              "Pembimbing 3 : ${snapshot.data[index]["BIMBING3"]}",
                                              style: TextStyle(
                                                  color: Colors.black
                                                      .withOpacity(0.5)),
                                            ),
                                          ),
                                          Container(
                                            child:
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(),
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                                  children: <Widget>[
                                                    IconButton(
                                                      onPressed: () {
                                                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                                                          return DetailJudulMahasiswaBimbingKoor(nomor: "${snapshot.data[index]["NOMOR"]}");
                                                        }));
                                                      },
                                                      icon: const Icon(Icons.arrow_forward_ios_outlined),
                                                      color: const Color(0xFF578BB8),
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
                            );
                          },
                        ),
                      );
                    }
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
