import 'package:flutter/material.dart';
import 'package:siapa/dosen/penawaranjudul.dart';
import 'package:siapa/koordinator/detailjudulmahasiswa.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:siapa/koordinator/penawaranjudulkoor.dart';
import 'package:siapa/koordinator/tanggal.dart';
import 'package:siapa/koordinator/rekapstatusdiambil.dart';
import 'package:siapa/login/login.dart';
import 'package:http/http.dart' as http;
import 'package:siapa/login/pilihlogin.dart';
import 'dart:convert' as convert;
import 'dart:async';
import '../models/namadosen.dart';
import '../models/jurusan.dart';
import '../models/program.dart';
import '../models/status.dart';
import 'package:siapa/mahasiswa/penawarantopik.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';

class JudulMahasiswa extends StatefulWidget {
  const JudulMahasiswa({Key? key}) : super(key: key);

  @override
  State<JudulMahasiswa> createState() => _JudulMahasiswaState();
}

class _JudulMahasiswaState extends State<JudulMahasiswa> {
  String? nomordosen1;
  String? nomordosen2;
  String? nomordosen3;
  String? program;
  String? jurusan;
  String? setstatus;
  // var valuefilter;
  TextEditingController searchnrp = TextEditingController();
  String query = "";
  String filterstatus = "";
  // var status;
  //   if (filterstatus == "Diterima") {
  //     status = 1;
  //   } else if (filterstatus == "Ditolak") {
  //     status = 2;
  //   }

  // Future filterJudulMahasiswa(valuefilter) async {
  //   var status;
  //   if (valuefilter == "Diterima") {
  //     status = 1;
  //   } else if (valuefilter == "Ditolak") {
  //     status = 2;
  //   }
  //   print(valuefilter);
  //   // print(program);

  //   http.Response hasil = await http.post(
  //       Uri.https('project.mis.pens.ac.id',
  //           '/mis112/siapa/koordinator/api/content/filterjudulmahasiswa.php'),
  //       body: convert.jsonEncode({
  //         'JURUSAN': jurusan,
  //         'PROGRAM': program,
  //         'STATUS': status,
  //         // 'TANGGAL_AKHIR': dateinputakhir.text,
  //       }),
  //       headers: {
  //         "Accept": "application/json",
  //       });

  //   print(hasil.body);
  //   if (hasil.statusCode == 200) {
  //     print("Berhasil Set Tanggal");
  //     return true;
  //   } else {
  //     print("error status " + hasil.statusCode.toString());
  //     print("Gagal");
  //     return false;
  //   }
  // }

  Future viewStatus() async {
    var url = Uri.https('project.mis.pens.ac.id',
        '/mis112/siapa/koordinator/api/content/getstatus.php');
    var response = await http.get(url);
    var jsonData = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
      return jsonData['data'];
    } else {
      print('No Response');
    }
  }

    Future viewJudulMahasiswa() async {
      var status;
    if (filterstatus == "Diterima") {
      status = 1;
    } else if (filterstatus == "Ditolak") {
      status = 2;
    }
    int nip = await SessionManager().get('nip');
    String nipQuery = nip.toString();
    var url = Uri.https(
        'project.mis.pens.ac.id',
        '/mis112/siapa/koordinator/api/content/judulmahasiswa.php');
    var response = await http.post(url, body: convert.jsonEncode({
          'nip': nipQuery,
          'STATUS': status,
        }));
    var jsonData = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
      return jsonData['data'];
    } else {
      print('No Response');
    }
  }

  Future setStatus(value, nomor) async {
    // try {

    var status;
    if (value == "Diterima") {
      status = 1;
    } else if (value == "Ditolak") {
      status = 2;
    }
    http.Response hasil = await http.post(
        Uri.https('project.mis.pens.ac.id',
            '/mis112/siapa/koordinator/api/content/setstatus.php'),
        body: convert.jsonEncode({
          'NOMOR': nomor,
          'STATUS': status,
        }),
        headers: {
          "Accept": "application/json",
        });
    // var dataUser = convert.jsonDecode(hasil.body);
    print(hasil.body);
    print(value);
    print(nomor);
    // print(hasil.statusCode);
    if (hasil.statusCode == 200) {
      print("Status Berhasil di Set");
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

  @override
  Widget build(BuildContext context) {
    final MediaQueryHeight = MediaQuery.of(context).size.height;
    final MediaQueryWidth = MediaQuery.of(context).size.width;
    final MyAppBar = AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      title: const Text(
        "Judul Mahasiswa Diterima",
        style: const TextStyle(
            color: Color(0xFF578BB8),
            fontSize: 20,
            fontWeight: FontWeight.bold),
      ),
      iconTheme: const IconThemeData(color: Color(0xFF578BB8)),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.filter_alt_outlined),
          color: const Color(0xFF578BB8),
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
                  return const PenawaranJudulKoor();
                }));
              },
              leading: const Icon(Icons.topic_outlined),
              title: const Text(
                "Penawaran Topik",
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
                Container(
                  width: MediaQueryWidth * 0.867,
                  height: MediaQueryHeight * 0.052,
                  child: TextField(
                    controller: searchnrp,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: false,
                      prefixIcon: const Icon(Icons.search_outlined),
                      hintText: "Pilih Tahun",
                      hintStyle:
                          const TextStyle(fontSize: 12, letterSpacing: 0.5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        query = value;
                        // viewJudulMahasiswa(value);
                      });
                    },
                  ),
                ),
                Row(
                  children: [
                    FutureBuilder<dynamic>(
                        future: viewStatus(),
                        builder: (context, snapshot) {
                          if (snapshot.error != null) {
                            return Text(
                              "${snapshot.error}",
                              style: const TextStyle(fontSize: 20),
                            );
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else {
                            return Container(
                              width: MediaQueryWidth * 0.467,
                                    height: MediaQueryHeight * 0.052,
                              child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: snapshot.data.length,
                                itemBuilder: (BuildContext context, index) {
                                  return Container(
                                    child: DropdownSearch<String>(
                                      mode: Mode.MENU,
                                      items: ["Diterima", "Ditolak"],
                                      hint: "Pilih Status",
                                      onChanged: (valuestatus) {
                                        setState(() {
                                          filterstatus = valuestatus!;
                                          // viewJudulMahasiswa(value);
                                        });
                                      },
                                    ),
                                  );
                                },
                              ),
                            );
                          }
                        }),
                    Container(
                      width: MediaQueryWidth * 0.467,
                      height: MediaQueryHeight * 0.052,
                      child: TextField(
                        // controller: searchnrp,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: false,
                          prefixIcon: const Icon(Icons.search_outlined),
                          hintText: "Cari NRP Mahasiswa",
                          hintStyle:
                              const TextStyle(fontSize: 12, letterSpacing: 0.5),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        // onChanged: (value) {
                        //   setState(() {
                        //     query = value;
                        //     // viewJudulMahasiswa(value);
                        //   });
                        // },
                      ),
                    ),
                  ],
                ),
                FutureBuilder<dynamic>(
                  future: viewJudulMahasiswa(),
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
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, index) {
                            return snapshot.data[index]["NRP"].contains(query)
                                ? Card(
                                    margin: const EdgeInsets.fromLTRB(
                                        26, 14, 26, 0),
                                    child: Container(
                                      width: MediaQueryWidth * 0.867,
                                      constraints: const BoxConstraints(
                                          maxHeight: double.infinity),
                                      child: SizedBox(
                                        child: Container(
                                          margin: const EdgeInsets.all(20),
                                          constraints: const BoxConstraints(
                                              maxHeight: double.infinity),
                                          child: Column(
                                            children: [
                                              Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: <Widget>[
                                                      Container(
                                                        width: 190,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            const Icon(
                                                              Icons
                                                                  .person_outlined,
                                                              color: const Color(
                                                                  0xFF578BB8),
                                                            ),
                                                            Container(
                                                              width: 150,
                                                              child: Text(
                                                                "${snapshot.data[index]["MAHASISWA"]} - ${snapshot.data[index]["NRP"]}",
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    letterSpacing:
                                                                        1),
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
                                                            decoration:
                                                                BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20),
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color: const Color(
                                                                          0xFF578BB8),
                                                                      width:
                                                                          1.0,
                                                                    )),
                                                            child: const Center(
                                                              child: const Text(
                                                                "1",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    letterSpacing:
                                                                        1),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      const Icon(
                                                        Icons.title_outlined,
                                                        color: const Color(
                                                            0xFF578BB8),
                                                      ),
                                                      Container(
                                                        width: 260,
                                                        child: Text(
                                                          "${snapshot.data[index]["JUDUL"]}",
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  letterSpacing:
                                                                      1),
                                                        ),
                                                      ),
                                                    ],
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
                                                      height: 40,
                                                      width: 150.0,
                                                      child: DropdownSearch<
                                                          String>(
                                                        mode: Mode.MENU,
                                                        // showSelectedItem: true,
                                                        items: [
                                                          "Diterima",
                                                          "Ditolak"
                                                        ],
                                                        hint: ("${snapshot.data[index]["STATUS"]}" ==
                                                                '1')
                                                            ? "$filterstatus"
                                                            : ("${snapshot.data[index]["STATUS"]}" ==
                                                                    '2')
                                                                ? "$filterstatus"
                                                                : "Pilih Status",
                                                        // valuestatus = value,
                                                        onChanged: (value) =>
                                                            setStatus(value,
                                                                "${snapshot.data[index]["NOMOR"]}"),
                                                      ),
                                                    ),
                                                    IconButton(
                                                      onPressed: () {
                                                        Navigator.push(context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) {
                                                          return DetailJudulMahasiswa(
                                                              nomor:
                                                                  "${snapshot.data[index]["NOMOR"]}");
                                                        }));
                                                      },
                                                      icon: const Icon(Icons
                                                          .arrow_forward_ios_outlined),
                                                      color: const Color(
                                                          0xFF578BB8),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : Container();
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

  List<String> data = ["Brazil", "Italia (Disabled)", "Tunisia", 'Canada'];
  Widget _buildPopUpJudulMahasiswa(BuildContext context) {
    // ignore: unnecessary_new
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
            margin: const EdgeInsets.fromLTRB(0, 5, 0, 6),
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                const Text(
                  "Tahun Ajaran",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w200),
                ),
                const Text(
                  "*",
                  style: TextStyle(color: Colors.red, fontSize: 20),
                )
              ],
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
          // Container(
          //   margin: const EdgeInsets.fromLTRB(0, 5, 0, 6),
          //   alignment: Alignment.centerLeft,
          //   child: Row(
          //     children: [
          //       const Text(
          //         "Program",
          //         style: const TextStyle(
          //             fontSize: 20, fontWeight: FontWeight.w200),
          //       ),
          //       const Text(
          //         "*",
          //         style: TextStyle(color: Colors.red, fontSize: 20),
          //       )
          //     ],
          //   ),
          // ),
          // Container(
          //   height: 40.0,
          //   child: DropdownSearch<Program>(
          //     mode: Mode.MENU,
          //     showSearchBox: true,
          //     onChanged: (value) => program = value?.nomor,
          //     dropdownBuilder: (context, selectedItem) =>
          //         Text(selectedItem?.program ?? "Pilih Program"),
          //     popupItemBuilder: (context, item, isSelected) => ListTile(
          //       title: Text(item.program),
          //     ),
          //     onFind: (text) async {
          //       int nip = await SessionManager().get('nip');
          //       String nipQuery = nip.toString();
          //       var url = Uri.https(
          //           'project.mis.pens.ac.id',
          //           '/mis112/siapa/koordinator/api/content/getprogram.php/',
          //           {'nip': nipQuery});
          //       var response = await http.get(url);
          //       if (response.statusCode == 200) {
          //         List namaprogram = (convert.jsonDecode(response.body)
          //             as Map<String, dynamic>)['data'];
          //         List<Program> listprogram = [];
          //         namaprogram.forEach((element) {
          //           listprogram.add(Program(
          //               program: element["PROGRAM"], nomor: element["NOMOR"]));
          //         });
          //         return listprogram;
          //       } else {
          //         return [];
          //       }
          //     },
          //   ),
          // ),
          // Container(
          //   margin: const EdgeInsets.fromLTRB(0, 5, 0, 6),
          //   alignment: Alignment.centerLeft,
          //   child: Row(
          //     children: [
          //       const Text(
          //         "Jurusan",
          //         style: TextStyle(fontSize: 20, fontWeight: FontWeight.w200),
          //       ),
          //       const Text(
          //         "*",
          //         style: TextStyle(color: Colors.red, fontSize: 20),
          //       )
          //     ],
          //   ),
          // ),
          // Container(
          //   height: 40.0,
          //   child: DropdownSearch<Jurusan>(
          //     mode: Mode.MENU,
          //     showSearchBox: true,
          //     onChanged: (value) => jurusan = value?.nomor,
          //     dropdownBuilder: (context, selectedItem) =>
          //         Text(selectedItem?.jurusan ?? "Pilih Jurusan"),
          //     popupItemBuilder: (context, item, isSelected) => ListTile(
          //       title: Text(item.jurusan),
          //     ),
          //     onFind: (text) async {
          //       int nip = await SessionManager().get('nip');
          //       String nipQuery = nip.toString();
          //       var url = Uri.https(
          //           'project.mis.pens.ac.id',
          //           '/mis112/siapa/koordinator/api/content/getjurusan.php/',
          //           {'nip': nipQuery});
          //       var response = await http.get(url);
          //       if (response.statusCode == 200) {
          //         List namajurusan = (convert.jsonDecode(response.body)
          //             as Map<String, dynamic>)['data'];
          //         List<Jurusan> listjurusan = [];
          //         namajurusan.forEach((element) {
          //           listjurusan.add(Jurusan(
          //               jurusan: element["JURUSAN"], nomor: element["NOMOR"]));
          //         });
          //         return listjurusan;
          //       } else {
          //         return [];
          //       }
          //     },
          //   ),
          // ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 5, 0, 6),
            alignment: Alignment.centerLeft,
            child: Row(
              children: const [
                Text(
                  "Status Persetujuan",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w200),
                ),
                Text(
                  "*",
                  style: TextStyle(color: Colors.red, fontSize: 20),
                )
              ],
            ),
          ),
          // Container(
          //   height: 40.0,
          //   child: DropdownSearch<String>(
          //     mode: Mode.MENU,
          //     // showSelectedItem: true,
          //     items: ["Diterima", "Ditolak"],
          //     // valuestatus = value,
          //     onChanged: (valuefilter) => filterJudulMahasiswa(valuefilter),
          //     // onChanged: (valuefilter),
          //   ),
          // )
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
                  primary: const Color(0xffEF0000), // background
                  onPrimary: Colors.white, // foreground
                ),
                child: const Text('Batal'),
              ),
            ),
            SizedBox(
              width: 110,
              child: new ElevatedButton(
                onPressed: () {
                  // filterJudulMahasiswa();
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xff20B726), // background
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
}

// pop up dosbing
