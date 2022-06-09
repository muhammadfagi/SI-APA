import 'package:flutter/material.dart';
import 'package:siapa/mahasiswa/juduloranglain.dart';
import 'package:siapa/login.dart';
import 'package:siapa/mahasiswa/detailjudul.dart';
import 'package:siapa/mahasiswa/penawarantopik.dart';
import 'package:siapa/mahasiswa/tambahjudul.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'dart:async';
import 'package:flutter_session/flutter_session.dart';

class Judul extends StatefulWidget {
  const Judul({Key? key}) : super(key: key);

  @override
  State<Judul> createState() => _JudulState();
}

class _JudulState extends State<Judul> {
  ScrollController _controller = new ScrollController();

  String? idJudul;
  Future viewJudul() async {
    // try {
    int nrp = await FlutterSession().get('nrp');
    String nrpQuery = nrp.toString();
    var url = Uri.https('project.mis.pens.ac.id',
        '/mis112/siapa/mahasiswa/api/content/judul.php/', {'nrp': nrpQuery});
    // var response =
    //     await http.get(url, headers: {"Accept": "application/json"});]

    var response = await http.get(url);
    var jsonData = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
      // print(jsonData['data']);
      return jsonData['data'];
    } else {
      print('No Response');
    }
    // } catch (e) {
    //   print("error catchnya $e");
    //   return null;
    // }
  }

  Future getNomorJudul() async {
    try {
      var url = Uri.https(
        'project.mis.pens.ac.id',
        '/mis112/siapa/mahasiswa/api/content/getnomorjudul.php/',
      );
      var response = await http.get(url);
      if (response.statusCode == 200) {
        dynamic jsonData = convert.jsonDecode(response.body);
        var nomor = jsonData['data']['NOMOR'];
        await FlutterSession().set('NOMOR', jsonData['data']['NOMOR']);
        return jsonData['data']['NOMOR'];
      } else {
        print('No Response');
      }
    } catch (e) {
      print("error catchnya $e");
      return null;
    }
  }

  Future deleteJudul(id) async {
    var url = Uri.https('project.mis.pens.ac.id',
        '/mis112/siapa/mahasiswa/api/content/hapusjudul.php', {'id': id});
    var response = await http.get(url);
    var jsonData = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
      print(jsonData['data']);
      return jsonData['data'];
    } else {
      print('No Response');
    }
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryHeight = MediaQuery.of(context).size.height;
    final MediaQueryWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          "Judul",
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
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: 141,
                        height: 36,
                        margin: EdgeInsets.fromLTRB(26, 0, 26, 0),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color(0xff578BB8)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            )),
                          ),
                          child: Text(
                            "Judul Anda",
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w600),
                          ),
                          onPressed: () {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) {
                              return Judul();
                            }));
                          },
                        ),
                      ),
                      Container(
                        width: 141,
                        height: 36,
                        margin: EdgeInsets.fromLTRB(0, 0, 26, 0),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color(0xffffffff)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            )),
                          ),
                          child: Text(
                            "Judul Orang Lain",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                          onPressed: () {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) {
                              return JudulOrangLain();
                            }));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                FutureBuilder<dynamic>(
                  future: viewJudul(),
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
                          physics: const AlwaysScrollableScrollPhysics(), // new
                          controller: _controller,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, index) {
                            return Container(
                              child: Card(
                                margin: EdgeInsets.fromLTRB(26, 14, 26, 0),
                                child: Container(
                                  width: MediaQueryWidth * 0.867,
                                  constraints: BoxConstraints(
                                      maxHeight: double.infinity),
                                  child: SizedBox(
                                    child: Container(
                                      margin: EdgeInsets.all(20),
                                      constraints: BoxConstraints(
                                          maxHeight: double.infinity),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Container(
                                                width: 239,
                                                child: Text(
                                                  "${snapshot.data[index]["JUDUL"]}",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      letterSpacing: 1),
                                                ),
                                              ),
                                              Container(
                                                child: SizedBox(
                                                  width: 27,
                                                  height: 27,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      border: Border.all(
                                                        color:
                                                            Color(0xFF578BB8),
                                                        width: 1.0,
                                                      ),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        "1",
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            letterSpacing: 1),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  width: 60,
                                                  height: 23,
                                                  child: ElevatedButton(
                                                    style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all<Color>(Color(
                                                                  0xffc4c4c4)),
                                                      shape: MaterialStateProperty.all<
                                                              RoundedRectangleBorder>(
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      )),
                                                    ),
                                                    child: Text(
                                                      "Ambil",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.black),
                                                    ),
                                                    onPressed: () {},
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    Container(
                                                      child: IconButton(
                                                        onPressed: () {
                                                          deleteJudul(snapshot
                                                                  .data[index]
                                                              ["NOMOR"]);
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (_) =>
                                                                      Judul()));
                                                        },
                                                        icon: Icon(Icons
                                                            .delete_outline),
                                                        color:
                                                            Color(0xFF578BB8),
                                                      ),
                                                    ),
                                                    IconButton(
                                                      onPressed: () {
                                                        Navigator.push(context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) {
                                                          return DetailJudul(
                                                              nomor:
                                                                  "${snapshot.data[index]["NOMOR"]}");
                                                        }));
                                                      },
                                                      icon: Icon(Icons
                                                          .arrow_forward_ios_outlined),
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
                            );
                          },
                        ),
                      );
                    }
                  },
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
                      return TambahJudul();
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
