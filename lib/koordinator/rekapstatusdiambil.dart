import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:siapa/koordinator/judulmahasiswa.dart';
import 'package:siapa/koordinator/tanggal.dart';
import 'package:siapa/koordinator/rekapstatusdiambil.dart';
import 'package:siapa/login/login.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'dart:async';
import '../models/tahun.dart';
import '../models/statusmahasiswa.dart';

class RekapStatusDiambil extends StatefulWidget {
  const RekapStatusDiambil({Key? key}) : super(key: key);

  @override
  State<RekapStatusDiambil> createState() => _RekapStatusDiambilState();
}

class _RekapStatusDiambilState extends State<RekapStatusDiambil> {
  TextEditingController searchnrp = TextEditingController();
  String query = "";
  String? kodekelas;
  String? nomorkelas;
  String? tahun;
  String? statusmahasiswa;

  Future viewRekap() async {
    int nip = await SessionManager().get('nip');
    String nipQuery = nip.toString();
    var url = Uri.https(
        'project.mis.pens.ac.id',
        '/mis112/siapa/koordinator/api/content/rekapjudulmahasiswa.php',
        {'nip': nipQuery});
    var response = await http.get(url);
    var jsonData = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
      print(jsonData['data']);
      return jsonData['data'];
    } else {
      print('No Response');
    }
  }

  Future viewRekapFilter() async {
    var status;
    if (statusmahasiswa == "Mahasiswa Luar Negeri") {
      status = 'E';
    } else if (statusmahasiswa == "Tanpa Keterangan") {
      status = 'T';
    } else if (statusmahasiswa == "Aktif") {
      status = 'A';
    } else if (statusmahasiswa == "Lulus") {
      status = 'L';
    } else if (statusmahasiswa == "Cuti") {
      status = 'C';
    } else if (statusmahasiswa == "DO") {
      status = 'D';
    } else if (statusmahasiswa == "Mengundurkan Diri") {
      status = 'K';
    } else if (statusmahasiswa == "Meninggal") {
      status = 'M';
    } else if (statusmahasiswa == "Pendaftar") {
      status = 'P';
    } else if (statusmahasiswa == "Mahasiswa Baru") {
      status = 'B';
    }
    print(status);
    int nip = await SessionManager().get('nip');
    String nipQuery = nip.toString();
    var url = Uri.https('project.mis.pens.ac.id',
        '/mis112/siapa/koordinator/api/content/rekapfilter.php');
    var response = await http.post(url,
        body: convert.jsonEncode({
          'nip': nipQuery,
          'STATUS_MAHASISWA': status,
          'PARAREL' : kodekelas,
          'KELAS' : nomorkelas,
        }));
    var jsonData = convert.jsonDecode(response.body);
    // print(jsonData['data']);
    if (response.statusCode == 200) {
      return jsonData['data'];
    } else {
      print('No Response');
    }
  }

  // Future viewRekapStatusMahasiswa() async {
  //   var status;
  //   if (statusmahasiswa == "Mahasiswa Luar Negeri") {
  //     status = 'E';
  //   } else if (statusmahasiswa == "Tanpa Keterangan") {
  //     status = 'T';
  //   } else if (statusmahasiswa == "Aktif") {
  //     status = 'A';
  //   } else if (statusmahasiswa == "Lulus") {
  //     status = 'L';
  //   } else if (statusmahasiswa == "Cuti") {
  //     status = 'C';
  //   } else if (statusmahasiswa == "DO") {
  //     status = 'D';
  //   } else if (statusmahasiswa == "Mengundurkan Diri") {
  //     status = 'K';
  //   } else if (statusmahasiswa == "Meninggal") {
  //     status = 'M';
  //   } else if (statusmahasiswa == "Pendaftar") {
  //     status = 'P';
  //   } else if (statusmahasiswa == "Mahasiswa Baru") {
  //     status = 'B';
  //   }
  //   print(status);
  //   int nip = await SessionManager().get('nip');
  //   String nipQuery = nip.toString();
  //   var url = Uri.https('project.mis.pens.ac.id',
  //       '/mis112/siapa/koordinator/api/content/rekapstatusmahasiswa.php');
  //   var response = await http.post(url,
  //       body: convert.jsonEncode({
  //         'nip': nipQuery,
  //         'STATUS_MAHASISWA': status,
  //       }));
  //   var jsonData = convert.jsonDecode(response.body);
  //   if (response.statusCode == 200) {
  //     return jsonData['data'];
  //   } else {
  //     print('No Response');
  //   }
  // }

  // Future viewRekapKodeKelas() async {
  //   // var kode;
  //   // if (kodekelas == "A") {
  //   //   kode = 1;
  //   // } else if (filterstatus == "Ditolak") {
  //   //   status = 2;
  //   // }
  //   int nip = await SessionManager().get('nip');
  //   String nipQuery = nip.toString();
  //   var url = Uri.https('project.mis.pens.ac.id',
  //       '/mis112/siapa/koordinator/api/content/rekapkodekelas.php');
  //   var response = await http.post(url,
  //       body: convert.jsonEncode({
  //         'nip': nipQuery,
  //         'PARALEL': kodekelas,
  //       }));
  //   var jsonData = convert.jsonDecode(response.body);
  //   if (response.statusCode == 200) {
  //     return jsonData['data'];
  //   } else {
  //     print('No Response');
  //   }
  // }
  //
  // Future viewRekapNomorKelas() async {
  //   int nip = await SessionManager().get('nip');
  //   String nipQuery = nip.toString();
  //   var url = Uri.https('project.mis.pens.ac.id',
  //       '/mis112/siapa/koordinator/api/content/rekapnomorkelas.php');
  //   var response = await http.post(url,
  //       body: convert.jsonEncode({
  //         'nip': nipQuery,
  //         'KELAS': nomorkelas,
  //       }));
  //   var jsonData = convert.jsonDecode(response.body);
  //   if (response.statusCode == 200) {
  //     return jsonData['data'];
  //   } else {
  //     print('No Response');
  //   }
  // }

  Future viewStatus() async {
    // int nrp = await SessionManager().get('NRP');
    // String nrpQuery = nrp.toString();
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

  @override
  Widget build(BuildContext context) {
    final MediaQueryHeight = MediaQuery
        .of(context)
        .size
        .height;
    final MediaQueryWidth = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          "Rekap Status Diambil",
          style: TextStyle(
              color: Color(0xFF578BB8),
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
        iconTheme: IconThemeData(color: Color(0xFF578BB8)),
        // actions: <Widget>[
        //   IconButton(
        //     icon: Icon(Icons.filter_alt_outlined),
        //     color: Color(0xFF578BB8),
        //     onPressed: () {
        //       showDialog(
        //         context: context,
        //         builder: (BuildContext context) =>
        //             _buildPopUpRekapStatusDiambil(context),
        //       );
        //     },
        //   ),
        // ],
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
                      size: 50,
                    ),
                  ),
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
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 14),
                  width: MediaQueryWidth * 0.867,
                  height: MediaQueryHeight * 0.052,
                  child: TextField(
                    controller: searchnrp,
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
                    onChanged: (value) {
                      setState(() {
                        query = value;
                        // viewJudulMahasiswa(value);
                      });
                    },
                  ),
                ),
                Column(
                  children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("Kelas: "),
                        Container(
                          width: MediaQueryWidth * 0.153,
                          height: MediaQueryHeight * 0.050,
                          child: DropdownSearch<String>(
                            mode: Mode.MENU,
                            items: ["1", "2", "3", "4"],
                            // hint: "Pilih Status",
                            onChanged: (valuenomorkelas) => nomorkelas = valuenomorkelas,
                          ),
                        ),
                        Container(
                          width: MediaQueryWidth * 0.153,
                          height: MediaQueryHeight * 0.050,
                          child: DropdownSearch<String>(
                            mode: Mode.MENU,
                            items: ["A", "B"],
                            // hint: "Pilih Status",
                            onChanged: (valuekodekelas) => kodekelas = valuekodekelas,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 40.0,
                      width: 125.0,
                      child: DropdownSearch<String>(
                        mode: Mode.MENU,
                        items: [
                          "Mahasiswa Luar Negeri",
                          "Tanpa Keterangan",
                          "Aktif",
                          "Lulus",
                          "Cuti",
                          "DO",
                          "Mengundurkan Diri",
                          "Meninggal",
                          "Pendaftar",
                          "Mahasiswa Baru"
                        ],
                        hint: "Pilih Status",
                        onChanged: (valuestatus) => statusmahasiswa = valuestatus,
                      ),
                    ),
                  ],
                ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 14, 0, 0),
                      height: 30.0,
                      width: 75.0,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.all<Color>(Color(0xff578BB8)),
                          shape:
                          MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              )),
                        ),
                        child: Text(
                          "Cari",
                          style: TextStyle(fontSize: 14),
                        ),
                        onPressed: () {
                          setState(() {
                            viewRekapFilter();
                          });
                          // _loginKoordinator();
                        },
                      ),
                    ),
                ],
                ),
                // Text("$statusmahasiswa"),
                // Text("$nomorkelas"),
                // Text("$kodekelas"),
                (statusmahasiswa != null && kodekelas != null && nomorkelas != null)
                    ? FutureBuilder<dynamic>(
                  future: viewRekapFilter(),
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
                      // List<dynamic> value = snapshot.data;
                      return
                        SizedBox(
                          child: ConstrainedBox(
                              constraints:
                              BoxConstraints(maxHeight: double.infinity),
                              child: SingleChildScrollView(
                                child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (BuildContext context, index) {
                                    var stringContains = false;
                                    if (snapshot.data[index] != null) {
                                      var snapIndex = snapshot.data[index];
                                      stringContains = snapIndex["NRP"]?.contains(query);
                                    } else {
                                      stringContains = false;
                                    }
                                    // return snapshot.data![index]["NRP"]!
                                    //     .contains(query)
                                    return stringContains
                                        ? (snapshot.data != null) ? Card(
                                      margin: EdgeInsets.fromLTRB(
                                          26, 14, 26, 0),
                                      child: Container(
                                        width: MediaQueryWidth * 0.867,
                                        constraints: BoxConstraints(
                                            maxHeight: double.infinity),
                                        child: SizedBox(
                                          child: Container(
                                            margin: EdgeInsets.all(20),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      right: 10),
                                                  child: Icon(
                                                    Icons
                                                        .account_circle_outlined,
                                                    color:
                                                    Color(0xFF578BB8),
                                                  ),
                                                ),
                                                // Text("${snapshot.data.length}"),
                                                Container(
                                                  width: 266,
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        alignment:
                                                        Alignment
                                                            .topLeft,
                                                        child: Text(
                                                          "${snapshot
                                                              .data![index]["NAMA"]}",
                                                          style: TextStyle(
                                                              fontSize:
                                                              14,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w600,
                                                              letterSpacing:
                                                              1),
                                                        ),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                        children: [
                                                          Container(
                                                            child: Text(
                                                              "${snapshot .data![index]["NRP"]}",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                  14,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                                  letterSpacing:
                                                                  1),
                                                            ),
                                                          ),
                                                          Container(
                                                            child: (snapshot
                                                                .data![index]
                                                            [
                                                            "STATUS"] ==
                                                                '0')
                                                                ? Text(
                                                              "Pengajuan Baru",
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight: FontWeight
                                                                      .w600,
                                                                  letterSpacing: 1,
                                                                  color: Color(
                                                                      0xff20B726)),
                                                            )
                                                                : (snapshot
                                                                .data![index]["STATUS"] ==
                                                                '1')
                                                                ? (snapshot.data![index]["AMBIL"] == '1')
                                                                ? Text(
                                                              "Diterima Sudah Diambil",
                                                              style: TextStyle(
                                                                fontSize: 14,
                                                                fontWeight: FontWeight
                                                                    .w600,
                                                                letterSpacing: 1,
                                                                color: Color(
                                                                    0xff20B726),
                                                              ),
                                                            )
                                                                : Text(
                                                              "Diterima Belum Diambil",
                                                              style: TextStyle(
                                                                fontSize: 14,
                                                                fontWeight: FontWeight
                                                                    .w600,
                                                                letterSpacing: 1,
                                                                color: Color(
                                                                    0xff20B726),
                                                              ),
                                                            )
                                                                : (snapshot
                                                                .data![index]["STATUS"] ==
                                                                '2')
                                                                ? Text(
                                                              "Ditolak",
                                                              style: TextStyle(
                                                                fontSize: 14,
                                                                fontWeight: FontWeight
                                                                    .w600,
                                                                letterSpacing: 1,
                                                                color: Color(
                                                                    0xff20B726),
                                                              ),
                                                            )
                                                                : (snapshot
                                                                .data![index]["STATUS"] ==
                                                                '3')
                                                                ? Text(
                                                              "Pending",
                                                              style: TextStyle(
                                                                fontSize: 14,
                                                                fontWeight: FontWeight
                                                                    .w600,
                                                                letterSpacing: 1,
                                                                color: Color(
                                                                    0xff20B726),
                                                              ),
                                                            )
                                                                : Text(
                                                              "Belum Pengajuan Judul",
                                                              style: TextStyle(
                                                                fontSize: 14,
                                                                fontWeight: FontWeight
                                                                    .w600,
                                                                letterSpacing: 1,
                                                                color: Color(
                                                                    0xff20B726),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ) : Container()
                                        : Container();
                                    // FutureBuilder<dynamic>(
                                  },
                                ),
                              )));
                    }
                  },
                )
                    :
                Container()

              ],
            ),
          ),
        ],
      ),
    );
  }
}

// pop up rekap status diambil
List<String> data = ["Brazil", "Italia (Disabled)", "Tunisia", 'Canada'];

Widget _buildPopUpRekapStatusDiambil(BuildContext context) {
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
          child: Text(
            "Status Mahasiswa",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w200),
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
          child: Text(
            "Program",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w200),
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
          child: Text(
            "Jurusan",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w200),
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0, 5, 0, 6),
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Kelas",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w200),
                  ),
                ),
                Container(
                  height: 40.0,
                  width: 100.0,
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
            Column(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0, 5, 0, 6),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Kelas",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w200),
                  ),
                ),
                Container(
                  height: 40.0,
                  width: 100.0,
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
          ],
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
