import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:intl/intl.dart';
import 'package:siapa/koordinator/judulmahasiswa.dart';
import 'package:siapa/koordinator/tanggal.dart';
import 'package:siapa/koordinator/rekapstatusdiambil.dart';
import 'package:siapa/login/login.dart';
import '../models/jurusan.dart';
import '../models/program.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'dart:async';
import 'package:flutter_session_manager/flutter_session_manager.dart';

class Tanggal extends StatefulWidget {
  const Tanggal({Key? key}) : super(key: key);

  @override
  State<Tanggal> createState() => _TanggalState();
}

class _TanggalState extends State<Tanggal> {
  String? jurusan;
  String? program;

  TextEditingController dateinputawal = TextEditingController();
  TextEditingController dateinputakhir = TextEditingController();
  Future _selectTanggal() async {
    DateTimeRange? newDateRange = await showDateRangePicker(
      context: context,
      initialDateRange: dateRange,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (newDateRange == null) return;

    setState(() => dateRange = newDateRange);
  }

  DateTimeRange dateRange = DateTimeRange(
    start: DateTime.now(),
    end: DateTime.now(),
  );

  Future setTanggal() async {
    // try {
    http.Response hasil = await http.post(
        Uri.https('project.mis.pens.ac.id',
            '/mis112/siapa/koordinator/api/content/tanggal.php'),
        body: convert.jsonEncode({
          'JURUSAN': jurusan,
          'PROGRAM': program,
          'TANGGAL_AWAL': dateinputawal.text,
          'TANGGAL_AKHIR': dateinputakhir.text,
        }),
        headers: {
          "Accept": "application/json",
        });

    print(hasil.body);
    if (hasil.statusCode == 200) {
      print("Berhasil Set Tanggal");
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

  @override
  Widget build(BuildContext context) {
    final start = dateRange.start;
    final end = dateRange.end;
    final MediaQueryHeight = MediaQuery.of(context).size.height;
    final MediaQueryWidth = MediaQuery.of(context).size.width;
    dateinputawal.value =
        TextEditingValue(text: "${start.day}-${start.month}-${start.year}");
    dateinputakhir.value =
        TextEditingValue(text: "${end.day}-${end.month}-${end.year}");
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Text(
            "Setting Tanggal",
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
              margin: EdgeInsets.all(30),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 21),
                    child: Center(
                      child: Text(
                        "Setting Tanggal Pengajuan Judul",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Roboto-Regular"),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 265, 6),
                    child: Text(
                      "Program",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    height: 40.0,
                    child: DropdownSearch<Program>(
                      mode: Mode.MENU,
                      showSearchBox: true,
                      onChanged: (value) => program = value?.nomor,
                      dropdownBuilder: (context, selectedItem) =>
                          Text(selectedItem?.program ?? "Pilih Program"),
                      popupItemBuilder: (context, item, isSelected) => ListTile(
                        title: Text(item.program),
                      ),
                      onFind: (text) async {
                        int nip = await SessionManager().get('nip');
                        String nipQuery = nip.toString();
                        var url = Uri.https(
                            'project.mis.pens.ac.id',
                            '/mis112/siapa/koordinator/api/content/getprogram.php/',
                            {'nip': nipQuery});
                        var response = await http.get(url);
                        if (response.statusCode == 200) {
                          List namaprogram = (convert.jsonDecode(response.body)
                              as Map<String, dynamic>)['data'];
                          List<Program> listprogram = [];
                          namaprogram.forEach((element) {
                            listprogram.add(Program(
                                program: element["PROGRAM"],
                                nomor: element["NOMOR"]));
                          });
                          return listprogram;
                        } else {
                          return [];
                        }
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 17, 269, 6),
                    child: Text(
                      "Jurusan",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    height: 40.0,
                    child: DropdownSearch<Jurusan>(
                      mode: Mode.MENU,
                      showSearchBox: true,
                      onChanged: (value) => jurusan = value?.nomor,
                      dropdownBuilder: (context, selectedItem) =>
                          Text(selectedItem?.jurusan ?? "Pilih Jurusan"),
                      popupItemBuilder: (context, item, isSelected) => ListTile(
                        title: Text(item.jurusan),
                      ),
                      onFind: (text) async {
                        int nip = await SessionManager().get('nip');
                        String nipQuery = nip.toString();
                        var url = Uri.https(
                            'project.mis.pens.ac.id',
                            '/mis112/siapa/koordinator/api/content/getjurusan.php/',
                            {'nip': nipQuery});
                        var response = await http.get(url);
                        if (response.statusCode == 200) {
                          List namajurusan = (convert.jsonDecode(response.body)
                              as Map<String, dynamic>)['data'];
                          List<Jurusan> listjurusan = [];
                          namajurusan.forEach((element) {
                            listjurusan.add(Jurusan(
                                jurusan: element["JURUSAN"],
                                nomor: element["NOMOR"]));
                          });
                          return listjurusan;
                        } else {
                          return [];
                        }
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 17, 0, 6),
                            child: Text(
                              "Tanggal Mulai",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                            ),
                          ),
                          Container(
                            width: 130,
                            // margin: EdgeInsets.only(right: 10.0),
                            child: TextField(
                              readOnly: true,
                              controller: dateinputawal,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: false,
                                hintText: "Pilih Tanggal",
                                hintStyle: TextStyle(fontSize: 12),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5)),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 17, 0, 6),
                            child: Text(
                              "Tanggal Berakhir",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                            ),
                          ),
                          Container(
                            width: 130,
                            child: TextField(
                              readOnly: true,
                              controller: dateinputakhir,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: false,
                                hintText: "Pilih Tanggal",
                                hintStyle: TextStyle(fontSize: 12),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5)),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            height: 41,
                          ),
                          Container(
                            // alignment: Alignment.bottomCenter,
                            width: 55,
                            height: 55,
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _selectTanggal();
                                });
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Color(0xff578BB8)),
                              ),
                              child: Icon(
                                Icons.date_range_outlined,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    width: 508,
                    height: 45,
                    margin: EdgeInsets.only(top: 17.0),
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
                        "Simpan",
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        setTanggal();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
