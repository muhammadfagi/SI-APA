import 'package:flutter/material.dart';
import 'package:siapa/mahasiswa/judul.dart';
import 'package:siapa/login/login.dart';
import 'package:siapa/mahasiswa/penawarantopik.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'dart:async';
import 'package:flutter_session_manager/flutter_session_manager.dart';

class JudulOrangLain extends StatefulWidget {
  const JudulOrangLain({Key? key}) : super(key: key);

  @override
  State<JudulOrangLain> createState() => _JudulOrangLainState();
}

Future viewJudulOrangLain() async {
  // try {
  int nrp = await SessionManager().get('nrp');
  String nrpQuery = nrp.toString();
  var url = Uri.https(
      'project.mis.pens.ac.id',
      '/mis112/siapa/mahasiswa/api/content/juduloranglain.php/',
      {'nrp': nrpQuery});

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

class _JudulOrangLainState extends State<JudulOrangLain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: const Text(
          "Judul",
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
                    alignment: Alignment.bottomLeft,
                    child: const Icon(
                      Icons.account_circle_outlined,
                      color: Colors.white,
                      size: 55,
                    ),
                  ),
                  Container(
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
                      style: TextStyle(color: Colors.white, fontSize: 20),
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
                  return const Judul();
                }));
              },
              leading: const Icon(Icons.title),
              title: const Text(
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
                      return const Login();
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
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: 141,
                        height: 36,
                        margin: const EdgeInsets.fromLTRB(26, 0, 26, 0),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color(0xffffffff)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            )),
                          ),
                          child: const Text(
                            "Judul Anda",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                          onPressed: () {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) {
                              return const Judul();
                            }));
                          },
                        ),
                      ),
                      Container(
                        width: 141,
                        height: 36,
                        margin: const EdgeInsets.fromLTRB(0, 0, 26, 0),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color(0xff578BB8)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            )),
                          ),
                          child: const Text(
                            "Judul Orang Lain",
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w600),
                          ),
                          onPressed: () {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) {
                              return const JudulOrangLain();
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
                                child: SizedBox(
                                  width: 340,
                                  height: 134,
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
                                                "${snapshot.data[index]["JUDUL"]}",
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
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
                                            style:
                                                TextStyle(color: Colors.black),
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
                                          child: Text(
                                            "Pembimbing 3 : ${snapshot.data[index]["BIMBING3"]}",
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
