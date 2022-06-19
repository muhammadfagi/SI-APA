import 'package:flutter/material.dart';
import 'package:siapa/mahasiswa/judul.dart';
import 'package:siapa/login.dart';
import 'package:siapa/mahasiswa/penawarantopik.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'dart:async';
import 'package:flutter_session/flutter_session.dart';

class JudulOrangLain extends StatefulWidget {
  const JudulOrangLain({Key? key}) : super(key: key);

  @override
  State<JudulOrangLain> createState() => _JudulOrangLainState();
}

Future viewJudulOrangLain() async {
  // try {
  int nrp = await FlutterSession().get('nrp');
  String nrpQuery = nrp.toString();
  var url = Uri.https(
      'project.mis.pens.ac.id',
      '/mis112/siapa/mahasiswa/api/content/juduloranglain.php/',
      {'nrp': nrpQuery});

  var response = await http.get(url);
  var jsonData = convert.jsonDecode(response.body);
  if (response.statusCode == 200) {
    return jsonData['data'];
  } else {
    print('No Response');
  }
  // } catch (e) {
  //   print("error catchnya $e");
  //   return null;
  // }
}

// Future viewDospem1() async {
//   try {
//     // String nmr = widget.nomor;
//     // String nmrQuery = nmr.toString();
//     // print(nmr);

//     var url = Uri.https(
//         'project.mis.pens.ac.id',
//         '/mis112/siapa/mahasiswa/api/content/viewdosenpembimbingoranglain.php/',
//         {'function': 'viewDosen1'});
//     // var response =
//     //     await http.get(url, headers: {"Accept": "application/json"});
//     var response = await http.get(url);
//     if (response.statusCode == 200) {
//       var jsonData = convert.jsonDecode(response.body);

//       return jsonData['data'];
//     } else {
//       print('No Response');
//     }
//   } catch (e) {
//     print("error catchnya $e");
//     return null;
//   }
// }

// Future viewDospem2() async {
//   try {
//     String nmr = widget.nomor;
//     // String nmrQuery = nmr.toString();
//     print(nmr);

//     var url = Uri.https(
//         'project.mis.pens.ac.id',
//         '/mis112/siapa/mahasiswa/api/content/viewdosenpembimbing.php/',
//         {'function': 'viewDosen2', 'NOMOR': nmr});
//     // var response =
//     //     await http.get(url, headers: {"Accept": "application/json"});
//     var response = await http.get(url);
//     if (response.statusCode == 200) {
//       var jsonData = convert.jsonDecode(response.body);

//       return jsonData['data'];
//     } else {
//       print('No Response');
//     }
//   } catch (e) {
//     print("error catchnya $e");
//     return null;
//   }
// }

// Future viewDospem3() async {
//   try {
//     String nmr = widget.nomor;
//     // String nmrQuery = nmr.toString();
//     print(nmr);

//     var url = Uri.https(
//         'project.mis.pens.ac.id',
//         '/mis112/siapa/mahasiswa/api/content/viewdosenpembimbing.php/',
//         {'function': 'viewDosen3', 'NOMOR': nmr});
//     // var response =
//     //     await http.get(url, headers: {"Accept": "application/json"});
//     var response = await http.get(url);
//     if (response.statusCode == 200) {
//       var jsonData = convert.jsonDecode(response.body);

//       return jsonData['data'];
//     } else {
//       print('No Response');
//     }
//   } catch (e) {
//     print("error catchnya $e");
//     return null;
//   }
// }

class _JudulOrangLainState extends State<JudulOrangLain> {
  @override
  Widget build(BuildContext context) {
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
                                Color(0xffffffff)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            )),
                          ),
                          child: Text(
                            "Judul Anda",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
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
                                Color(0xff578BB8)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            )),
                          ),
                          child: Text(
                            "Judul Orang Lain",
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w600),
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
                  future: viewJudulOrangLain(),
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
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, index) {
                            return Container(
                              child: Card(
                                margin: EdgeInsets.fromLTRB(26, 14, 26, 0),
                                child: SizedBox(
                                  width: 340,
                                  height: 134,
                                  child: Container(
                                    margin: EdgeInsets.all(20),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                              width: 300,
                                              child: Text(
                                                "${snapshot.data[index]["JUDUL"]}",
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
                                          margin:
                                              EdgeInsets.fromLTRB(0, 11, 0, 11),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Color(0xff578BB8)
                                                  .withOpacity(0.75),
                                              width: 1.0,
                                            ),
                                          ),
                                        ),
                                        Container(
                                            margin:
                                                EdgeInsets.fromLTRB(0, 4, 0, 0),
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "Pembimbing 1 : tes",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            )),
                                        Container(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            "Pembimbing 2 : Nana Ramadijanti, S.Kom, M.Kom",
                                            style: TextStyle(
                                                color: Colors.black
                                                    .withOpacity(0.5)),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            "Pembimbing 3 : ",
                                            style: TextStyle(
                                                color: Colors.black
                                                    .withOpacity(0.5)),
                                          ),
                                        ),
                                      ],
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
