import 'package:flutter/material.dart';
import 'package:siapa/login/pilihlogin.dart';
import 'package:siapa/mahasiswa/juduloranglain.dart';
import 'package:siapa/login/login.dart';
import 'package:siapa/mahasiswa/detailjudul.dart';
import 'package:siapa/mahasiswa/penawarantopik.dart';
import 'package:siapa/mahasiswa/tambahjudul.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'dart:async';
// import 'package:flutter_session/flutter_session.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';

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
    int nrp = await SessionManager().get('nrp');
    String nrpQuery = nrp.toString();
    print(nrpQuery);
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

  Future getTanggal() async {
    // try {
    int nrp = await SessionManager().get('nrp');
    String nrpQuery = nrp.toString();
    print(nrpQuery);
    var url = Uri.https(
        'project.mis.pens.ac.id',
        '/mis112/siapa/mahasiswa/api/content/getatanggal.php/',
        {'nrp': nrpQuery});
    var response = await http.get(url);
    if (response.statusCode == 200) {
      dynamic jsonData = convert.jsonDecode(response.body);
      // var nomor = jsonData['data']['NOMOR'];
      // print(nomor);
      // await SessionManager().set('NOMOR', jsonData['data']['NOMOR']);
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
        print(nomor);
        await SessionManager().set('NOMOR', jsonData['data']['NOMOR']);
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

  // Future ambilJudul(nomor) async {
  //   // try {

  //   // var status;
  //   // if (value == "Diterima") {
  //   //   status = 1;
  //   // } else if (value == "Ditolak") {
  //   //   status = 2;
  //   // }
  //   http.Response hasil = await http.post(
  //       Uri.https('project.mis.pens.ac.id',
  //           '/mis112/siapa/mahasiswa/api/content/juduldiambil.php'),
  //       body: convert.jsonEncode({
  //         'NOMOR': nomor,
  //         // 'JUDUL': judul,
  //         // 'DOSEN1': dosen1,
  //         // 'DOSEN2': dosen2,
  //         // 'DOSEN3': dosen3,
  //         // 'NRP': nrp,
  //         // 'TANGGAL_ENTRI': tanggalentri
  //       }),
  //       headers: {
  //         "Accept": "application/json",
  //       });
  //   // var dataUser = convert.jsonDecode(hasil.body);
  //   print(hasil.body);
  //   // print(nomor);
  //   // print(hasil.statusCode);
  //   if (hasil.statusCode == 200) {
  //     print("Judul Berhasil Diambil");
  //     return true;
  //   } else {
  //     print("error status " + hasil.statusCode.toString());
  //     print("Login Gagal");
  //     return false;
  //   }
  //   // } catch (e) {
  //   //   print("error catchnya $e");
  //   //   print("error");
  //   //   return null;
  //   // }
  // }

  Future ambilJudul(nomor) async {
    try {
      var url = Uri.https(
          'project.mis.pens.ac.id',
          '/mis112/siapa/mahasiswa/api/content/juduldiambil.php',
          {'nomor': nomor});
      var response = await http.get(url);
      var jsonData = convert.jsonDecode(response.body);
      if (response.statusCode == 200) {
        print(jsonData['data']);
        print("Judul Berhasil Diambil");
        return jsonData['data'];
      } else {
        print('Gagal');
      }
    } catch (e) {
      print("error catchnya $e");
      print("error");
      return null;
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
        title: const Text(
          "Judul",
          style: const TextStyle(
              color: Color(0xFF578BB8),
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: const Color(0xFF578BB8)),
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
                  return const PenawaranTopik();
                }));
              },
              leading: const Icon(Icons.calendar_today_outlined),
              title: const Text(
                "Penawaran Topik",
                style: const TextStyle(fontSize: 20),
              ),
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
            child: FutureBuilder<dynamic>(
              future: getTanggal(),
              builder: (context, snapshot) {
                if (snapshot.error != null) {
                  return Text(
                    "${snapshot.error}",
                    style: const TextStyle(fontSize: 20),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: const CircularProgressIndicator());
                } else {
                  return Container(
                    child: ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(), // new
                      controller: _controller,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: 1,
                      itemBuilder: (BuildContext context, index) {
                        return Container(
                            child: ("${snapshot.data[index]["TANGGAL_AWAL"]}" !=
                                        null &&
                                    "${snapshot.data[index]["TANGGAL_AKHIR"]}" != null)
                                ? Column(
                                    children: [
                                      Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                              width: 141,
                                              height: 36,
                                              margin: const EdgeInsets.fromLTRB(
                                                  26, 0, 26, 0),
                                              child: ElevatedButton(
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all<
                                                              Color>(
                                                          const Color(
                                                              0xff578BB8)),
                                                  shape: MaterialStateProperty
                                                      .all<RoundedRectangleBorder>(
                                                          RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  )),
                                                ),
                                                child: const Text(
                                                  "Judul Anda",
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                onPressed: () {
                                                  Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) {
                                                    return const Judul();
                                                  }));
                                                },
                                              ),
                                            ),
                                            Container(
                                              width: 141,
                                              height: 36,
                                              margin: const EdgeInsets.fromLTRB(
                                                  0, 0, 26, 0),
                                              child: ElevatedButton(
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all<
                                                              Color>(
                                                          const Color(
                                                              0xffffffff)),
                                                  shape: MaterialStateProperty
                                                      .all<RoundedRectangleBorder>(
                                                          RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  )),
                                                ),
                                                child: const Text(
                                                  "Judul Orang Lain",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.black),
                                                ),
                                                onPressed: () {
                                                  Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) {
                                                    return const JudulOrangLain();
                                                  }));
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      Text(
                                          "Tanggal Pengajuan Judul : ${snapshot.data[index]["TANGGAL_AWAL"]} s/d ${snapshot.data[index]["TANGGAL_AKHIR"]}"),
                                      // ignore: dead_code, unnecessary_null_comparison
                                      // ("${snapshot.data["TANGGAL_AWAL"]}" == true) ?
                                      FutureBuilder<dynamic>(
                                        future: viewJudul(),
                                        builder: (context, snapshot) {
                                          if (snapshot.error != null) {
                                            return Text(
                                              "${snapshot.error}",
                                              style:
                                                  const TextStyle(fontSize: 20),
                                            );
                                          }
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return const Center(
                                                child:
                                                    const CircularProgressIndicator());
                                          } else {
                                            return Container(
                                              child: ListView.builder(
                                                physics:
                                                    const AlwaysScrollableScrollPhysics(), // new
                                                controller: _controller,
                                                scrollDirection: Axis.vertical,
                                                shrinkWrap: true,
                                                itemCount: snapshot.data.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        index) {
                                                  return Container(
                                                    child: Card(
                                                      margin: const EdgeInsets
                                                              .fromLTRB(
                                                          26, 14, 26, 0),
                                                      child: Container(
                                                        width: MediaQueryWidth *
                                                            0.867,
                                                        constraints:
                                                            const BoxConstraints(
                                                                maxHeight: double
                                                                    .infinity),
                                                        child: SizedBox(
                                                          child: Container(
                                                            margin:
                                                                const EdgeInsets
                                                                    .all(20),
                                                            constraints:
                                                                const BoxConstraints(
                                                                    maxHeight: 
                                                                        double
                                                                            .infinity),
                                                            child: Column(
                                                              children: [
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: <
                                                                      Widget>[
                                                                    Container(
                                                                      width:
                                                                          239,
                                                                      child:
                                                                          Text(
                                                                        "${snapshot.data[index]["JUDUL"]}",
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                14,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            letterSpacing: 1),
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      child:
                                                                          SizedBox(
                                                                        width:
                                                                            27,
                                                                        height:
                                                                            27,
                                                                        child:
                                                                            Container(
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(20),
                                                                            border:
                                                                                Border.all(
                                                                              color: const Color(0xFF578BB8),
                                                                              width: 1.0,
                                                                            ),
                                                                          ),
                                                                          child:
                                                                              const Center(
                                                                            child:
                                                                                Text(
                                                                              "1",
                                                                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, letterSpacing: 1),
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
                                                                        width:
                                                                            80,
                                                                        height:
                                                                            23,
                                                                        child: ("${snapshot.data[index]["STATUS"]}" ==
                                                                                '1')
                                                                            ? (("${snapshot.data[index]["AMBIL"]}" == '1')
                                                                                ? const Text("Diambil", style: const TextStyle(fontSize: 14, color: const Color(0xff20B726)))
                                                                                : ("${snapshot.data[index]["AMBIL"]}" == '2')
                                                                                    ? const Text("Tidak Diambil", style: const TextStyle(fontSize: 14, color: Color(0xff20B726)))
                                                                                    : ElevatedButton(
                                                                                        style: ButtonStyle(
                                                                                          backgroundColor: MaterialStateProperty.all<Color>(const Color(0xffc4c4c4)),
                                                                                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                                                                            borderRadius: BorderRadius.circular(5),
                                                                                          )),
                                                                                        ),
                                                                                        child: const Text(
                                                                                          "Ambil",
                                                                                          style: const TextStyle(fontSize: 12, color: Colors.black),
                                                                                        ),
                                                                                        onPressed: () {
                                                                                          showDialog(
                                                                                            context: context,
                                                                                            builder: (BuildContext context) => _buildPopupAmbilJudul(context),
                                                                                          );
                                                                                        },
                                                                                      ))
                                                                            : Text(
                                                                                ("${snapshot.data[index]["STATUS"]}" == '2') ? "Ditolak" : "Belum Diset",
                                                                                style: const TextStyle(fontSize: 14, color: Color(0xff20B726)),
                                                                              ),
                                                                      ),
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: <
                                                                            Widget>[
                                                                          Container(
                                                                            child:
                                                                                IconButton(
                                                                              onPressed: () {
                                                                                deleteJudul(snapshot.data[index]["NOMOR"]);
                                                                                Navigator.push(context, MaterialPageRoute(builder: (_) => const Judul()));
                                                                              },
                                                                              icon: const Icon(Icons.delete_outline),
                                                                              color: const Color(0xFF578BB8),
                                                                            ),
                                                                          ),
                                                                          IconButton(
                                                                            onPressed:
                                                                                () {
                                                                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                                                                return DetailJudul(nomor: "${snapshot.data[index]["NOMOR"]}");
                                                                              }));
                                                                            },
                                                                            icon:
                                                                                const Icon(Icons.arrow_forward_ios_outlined),
                                                                            color:
                                                                                const Color(0xFF578BB8),
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
                                              MaterialStateProperty.all<Color>(
                                                  const Color(0xff578BB8)),
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          )),
                                        ),
                                        child: const Icon(
                                          Icons.add_outlined,
                                        ),
                                        onPressed: () {
                                          Navigator.pushReplacement(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return const TambahJudul();
                                          }));
                                        },
                                      )
                                    ],
                                  )
                                : Text("Tes"));
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

  Future statusAmbil(nomor) async {
    // try {
    http.Response hasil = await http.post(
        Uri.https('project.mis.pens.ac.id',
            '/mis112/siapa/mahasiswa/api/content/statusambil.php'),
        body: convert.jsonEncode({
          'nomor': nomor,
          // 'TAHUN_AJARAN': tahunajaran.text,
        }),
        headers: {
          "Accept": "application/json",
        });
    print(hasil.body);
    if (hasil.statusCode == 200) {
      print("Judul Berhasil Diambil");
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

  Future tahunAjaran(nomor) async {
    // try {
    http.Response hasil = await http.post(
        Uri.https('project.mis.pens.ac.id',
            '/mis112/siapa/mahasiswa/api/content/juduldiambil.php'),
        body: convert.jsonEncode({
          'nomor': nomor,
          'TAHUN_AJARAN': tahunajaran.text,
        }),
        headers: {
          "Accept": "application/json",
        });
    print(hasil.body);
    if (hasil.statusCode == 200) {
      print("Tahun Ajaran Berhasil Ditambahkan");
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

  TextEditingController tahunajaran = TextEditingController();
  Widget _buildPopupAmbilJudul(BuildContext context) {
    return Container(
      child: FutureBuilder<dynamic>(
        future: viewJudul(),
        builder: (context, snapshot) {
          if (snapshot.error != null) {
            return Text(
              "${snapshot.error}",
              style: const TextStyle(fontSize: 20),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: const CircularProgressIndicator());
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
                    child: new AlertDialog(
                      title: const Text(
                        'Tahun Ajaran',
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
                            margin: const EdgeInsets.fromLTRB(0, 5, 0, 6),
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              "Tahun Ajaran",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w200),
                            ),
                          ),
                          SizedBox(
                            width: 340,
                            height: 40,
                            child: TextField(
                              controller: tahunajaran,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: false,
                                hintText: "Masukkan Tahun Ajaran",
                                hintStyle: const TextStyle(
                                    fontSize: 12, letterSpacing: 0.5),
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
                                  primary:
                                      const Color(0xffEF0000), // background
                                  onPrimary: Colors.white, // foreground
                                ),
                                child: const Text('Batal'),
                              ),
                            ),
                            SizedBox(
                              width: 110,
                              child: new ElevatedButton(
                                onPressed: () {
                                  tahunAjaran(snapshot.data[index]["NOMOR"]);
                                  statusAmbil(snapshot.data[index]["NOMOR"]);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => const Judul()));
                                },
                                style: ElevatedButton.styleFrom(
                                  primary:
                                      const Color(0xff20B726), // background
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
                },
              ),
            );
          }
        },
      ),
    );
  }
}
