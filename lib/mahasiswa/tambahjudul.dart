import 'dart:convert';
import 'dart:io';
import 'package:textfield_search/textfield_search.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:siapa/mahasiswa/tambahjudul.dart';
import 'package:siapa/mahasiswa/judul.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'dart:async';
import '../models/namadosen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../models/judul.dart';
import '../models/namadosen.dart';
// import '../controller/tambahdokumen.dart';

class TambahJudul extends StatefulWidget {
  const TambahJudul({Key? key}) : super(key: key);

  @override
  State<TambahJudul> createState() => _TambahJudulState();
}

class _TambahJudulState extends State<TambahJudul> {
  List<String> data = ["Brazil", "Italia (Disabled)", "Tunisia", 'Canada'];
  String selectdata = "";
  final tesdropdown = new TextEditingController();
  String? nomordosen1;
  String? nomordosen2;
  String? nomordosen3;
  String? tahun;

  TextEditingController judul = new TextEditingController();
  TextEditingController rangkuman = new TextEditingController();
  TextEditingController dosbing1 = new TextEditingController();
  TextEditingController dosbing2 = new TextEditingController();
  TextEditingController dosbing3 = new TextEditingController();
  TextEditingController prioritas = new TextEditingController();
  TextEditingController dokumen = new TextEditingController();

  List<PlatformFile>? _files;
  String? filename;

  Future _openFile() async {
    _files = (await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']))!
        .files;
    setState(() {
      _files!.first.name;
    });
  }

  Future tambahJudul() async {
    // try {

    int nomor = await SessionManager().get('NOMOR');
    String nomorQuery = nomor.toString();
    // print(judul.text);
    print(nomorQuery);
    var dosen3;
    if (nomordosen3 == null) {
      dosen3 = "";
    } else {
      dosen3 = nomordosen3;
    }

    var uri = Uri.https('project.mis.pens.ac.id',
        '/mis112/siapa/mahasiswa/api/content/tambahjudul.php');
    var request = http.MultipartRequest('POST', uri);
    request.files.add(await http.MultipartFile.fromPath(
        'DOKUMEN', _files!.first.path.toString()));
    request.fields['JUDUL'] = judul.text;
    request.fields['RANGKUMAN'] = rangkuman.text;
    request.fields['PEMBIMBING1'] = nomordosen1!;
    request.fields['PEMBIMBING2'] = nomordosen2!;
    request.fields['PEMBIMBING3'] = dosen3;
    // request.fields['PRIORITAS'] = prioritas.text;
    request.fields['MAHASISWA'] = nomorQuery;
    var response = await request.send();
    final responsed = await http.Response.fromStream(response);
    final responsedata = jsonDecode(responsed.body);
    print(responsedata['data']);

    final path = responsedata['data'];
    final extention = '${_files!.first.extension}';
    final file = File(_files!.first.path!);

    final ref = FirebaseStorage.instance.ref().child("$path.$extention");
    ref.putFile(file);
    // } catch (e) {
    //   print("error catchnya $e");
    //   print("error");
    //   return null;
    // }
  }

  Future getNomor() async {
    try {
      int nrp = await SessionManager().get('nrp');
      String nrpQuery = nrp.toString();
      var url = Uri.https(
          'project.mis.pens.ac.id',
          '/mis112/siapa/mahasiswa/api/content/getnomor.php/',
          {'nrp': nrpQuery});
      var response = await http.get(url);
      if (response.statusCode == 200) {
        dynamic jsonData = convert.jsonDecode(response.body);
        var nomor = jsonData['data']['NOMOR'];
        await SessionManager().set('NOMOR', jsonData['data']['NOMOR']);
        print(jsonData['data']['NOMOR']);
        return jsonData['data']['NOMOR'];
      } else {
        print('No Response');
      }
    } catch (e) {
      print("error catchnya $e");
      return null;
    }
  }

  Future getNamaPegawai() async {
    try {
      var url = Uri.https(
        'project.mis.pens.ac.id',
        '/mis112/siapa/mahasiswa/api/content/getnamapegawai.php/',
      );
      var response = await http.get(url);
      if (response.statusCode == 200) {
        dynamic jsonData = convert.jsonDecode(response.body);
        var namapegawai = jsonData['data'].toString();
        await SessionManager().set('NAMA', jsonData['data']);
        print(namapegawai);
        return jsonData['data'];
      } else {
        print('No Response');
      }
    } catch (e) {
      print("error catchnya $e");
      return null;
    }
  }

  // FilePickerResult? _file;
  // Future getFile() async {
  //   FilePickerResult? result = await FilePicker.platform
  //       .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
  //   if (result != null) {
  //     PlatformFile file = result.files.first;
  //     print(file.name);
  //     print(file.path);
  //     // var multipartFile = await MultipartFile.fromFile(_filepath.path);
  //   } else {
  //     // User canceled the picker
  //   }
  //   // setState(() {
  //   //   _file = ;
  //   // });
  // }



  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {
      tambahJudul();
    });
  }

  @override
  Widget build(BuildContext context) {
    dokumen.value = (_files?.first.path == null)
        ? TextEditingValue(text: "Masukkan Dokumen")
        : TextEditingValue(text: _files!.first.name);
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
          "Tambah Judul",
          style: TextStyle(
              color: Color(0xFF578BB8),
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(30, 2, 30, 0),
            child: FutureBuilder<dynamic>(
                future: getNomor(),
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
                      child: Column(
                        children: <Widget>[
                          // Judul
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 289, 6),
                            child: Text(
                              "Judul",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w400),
                            ),
                          ),
                          Container(
                            width: 340,
                            height: 40,
                            child:
                            // TextFieldSearch(
                            //   label: "",
                            //   controller: judul,
                            //   future: () {
                            //     return
                            //
                            //   },
                            // ),
                            // TextField(
                            //   controller: judul,
                            //   decoration: InputDecoration(
                            //     fillColor: Colors.white,
                            //     filled: false,
                            //     hintText: "Masukkan Judul",
                            //     hintStyle:
                            //         TextStyle(fontSize: 12, letterSpacing: 0.5),
                            //     border: OutlineInputBorder(
                            //         borderRadius: BorderRadius.circular(5)),
                            //   ),
                            // ),
                            TypeAheadField<ListJudul?>(
                              suggestionsCallback: ApiJudul.viewJudulOrangLain,
                              itemBuilder: (context, ListJudul? suggestion) {
                                final tes = suggestion!;

                                return ListTile(
                                  title: Text(tes.judul),
                                );
                              },
                              onSuggestionSelected: (ListJudul? suggestion){
                                final tes = suggestion!;
                                ScaffoldMessenger.of(context)
                                ..removeCurrentSnackBar()
                                ..showSnackBar(SnackBar(content: Text(tes.judul),));
                              },
                              textFieldConfiguration: TextFieldConfiguration(
                                controller: judul,
                                decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: false,
                                    hintText: "Masukkan Judul",
                                    hintStyle:
                                        TextStyle(fontSize: 12, letterSpacing: 0.5),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                  ),
                              ),
                              noItemsFoundBuilder: (context) => Center(
                                child: Text("Judul Berbeda", style: TextStyle(fontSize: 24),),
                              ),
                            )
                          ),
                          // Rangkuman
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 20, 0, 6),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Rangkuman",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w400),
                            ),
                          ),
                          SizedBox(
                            width: 340,
                            height: 150,
                            child: TextField(
                              controller: rangkuman,
                              maxLines: 10,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: false,
                                hintText: "Masukkan Rangkuman",
                                hintStyle:
                                    TextStyle(fontSize: 12, letterSpacing: 0.5),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5)),
                              ),
                            ),
                          ),
                          // File
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 20, 0, 6),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Dokumen Usulan",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w400),
                            ),
                          ),
                          SizedBox(
                            width: 340,
                            height: 40,
                            child: TextField(
                              readOnly: true,
                              controller: dokumen,
                              onTap: () {
                                _openFile();
                                // openFile();
                                // controller.openfile()
                              },
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: false,
                                hintText: "Masukkan File",
                                hintStyle:
                                    TextStyle(fontSize: 12, letterSpacing: 0.5),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5)),
                              ),
                            ),
                          ),
                          // Dosen Pembimbing
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 20, 0, 6),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Dosen Pembimbing",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w400),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 5, 0, 6),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Dosen Pembimbing 1",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w200),
                            ),
                          ),
                          Container(
                            height: 40.0,
                            child: DropdownSearch<NamaDosen>(
                              mode: Mode.MENU,
                              showSearchBox: true,
                              // items: [],
                              // readOnly: true,
                              // searchBoxController: dosbing3,
                              // popupItemDisabled: (String s) => s.startsWith('I'),

                              hint: "Pilih Dosen",
                              onChanged: (value) => nomordosen1 = value?.nomor,
                              dropdownBuilder: (context, selectedItem) => Text(
                                  selectedItem?.nama ?? "Belum Memilih Dosen"),
                              popupItemBuilder: (context, item, isSelected) =>
                                  ListTile(
                                title: Text(item.nama),
                              ),
                              onFind: (text) async {
                                var url = Uri.https('project.mis.pens.ac.id',
                                    '/mis112/siapa/mahasiswa/api/content/getnamapegawai.php/');
                                var response = await http.get(url);
                                if (response.statusCode == 200) {
                                  List namadosen =
                                      (convert.jsonDecode(response.body)
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
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w200),
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
                              dropdownBuilder: (context, selectedItem) => Text(
                                  selectedItem?.nama ?? "Belum Memilih Dosen"),
                              popupItemBuilder: (context, item, isSelected) =>
                                  ListTile(
                                title: Text(item.nama),
                              ),
                              onFind: (text) async {
                                var url = Uri.https('project.mis.pens.ac.id',
                                    '/mis112/siapa/mahasiswa/api/content/getnamapegawai.php/');
                                var response = await http.get(url);
                                if (response.statusCode == 200) {
                                  List namadosen =
                                      (convert.jsonDecode(response.body)
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
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w200),
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
                              dropdownBuilder: (context, selectedItem) => Text(
                                  selectedItem?.nama ?? "Belum Memilih Dosen"),
                              popupItemBuilder: (context, item, isSelected) =>
                                  ListTile(
                                title: Text(item.nama),
                              ),
                              onFind: (text) async {
                                var url = Uri.https('project.mis.pens.ac.id',
                                    '/mis112/siapa/mahasiswa/api/content/getnamapegawai.php/');
                                var response = await http.get(url);
                                if (response.statusCode == 200) {
                                  List namadosen =
                                      (convert.jsonDecode(response.body)
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

                          // Konfirmasi
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: 141,
                                  height: 36,
                                  margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Color(0xffEF0000)),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      )),
                                    ),
                                    child: Text(
                                      "Batal",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white),
                                    ),
                                    onPressed: () {},
                                  ),
                                ),
                                Container(
                                  width: 141,
                                  height: 36,
                                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Color(0xff20B726)),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      )),
                                    ),
                                    child: Text(
                                      "Simpan",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    onPressed: () {
                                      if (nomordosen1 == null) {
                                        showDialog<String>(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                            title: const Text('Data Kosong'),
                                            content: const Text(
                                                'Dosen Pembimbing 1 Tidak Boleh Kosong!'),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    context, 'Ok'),
                                                child: const Text('OK'),
                                              ),
                                            ],
                                          ),
                                        );
                                      } else if (nomordosen2 == null) {
                                        showDialog<String>(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                            title: const Text('Data Kosong'),
                                            content: const Text(
                                                'Dosen Pembimbing 2 Tidak Boleh Kosong!'),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    context, 'Ok'),
                                                child: const Text('OK'),
                                              ),
                                            ],
                                          ),
                                        );
                                      } else if (_files!.first.path == null) {
                                        showDialog<String>(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                            title: const Text('Data Kosong'),
                                            content: const Text(
                                                'Dokumen Tidak Boleh Kosong!'),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    context, 'Ok'),
                                                child: const Text('OK'),
                                              ),
                                            ],
                                          ),
                                        );
                                      } else if (judul.text == null) {
                                        showDialog<String>(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                            title: const Text('Data Kosong'),
                                            content: const Text(
                                                'Judul Tidak Boleh Kosong!'),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    context, 'Ok'),
                                                child: const Text('OK'),
                                              ),
                                            ],
                                          ),
                                        );
                                      } else if (rangkuman.text == null) {
                                        showDialog<String>(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                            title: const Text('Data Kosong'),
                                            content: const Text(
                                                'Rangkuman Tidak Boleh Kosong!'),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    context, 'Ok'),
                                                child: const Text('OK'),
                                              ),
                                            ],
                                          ),
                                        );
                                      } else if (nomordosen1 == nomordosen2) {
                                        showDialog<String>(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                            title: const Text('Data Error!!'),
                                            content: const Text(
                                                'Dosen Tidak Boleh Sama!'),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    context, 'Ok'),
                                                child: const Text('OK'),
                                              ),
                                            ],
                                          ),
                                        );
                                      } else if (nomordosen1 == nomordosen3) {
                                        showDialog<String>(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                            title: const Text('Data Error!!'),
                                            content: const Text(
                                                'Dosen Tidak Boleh Sama!'),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    context, 'Ok'),
                                                child: const Text('OK'),
                                              ),
                                            ],
                                          ),
                                        );
                                      } else if (nomordosen3 == nomordosen2) {
                                        showDialog<String>(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                            title: const Text('Data Error!!'),
                                            content: const Text(
                                                'Dosen Tidak Boleh Sama!'),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    context, 'Ok'),
                                                child: const Text('OK'),
                                              ),
                                            ],
                                          ),
                                        );
                                      } else {
                                        setState(() {
                                          tambahJudul();
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      const Judul()));
                                        });
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                }),
          ),
        ],
      ),
    );
  }
}
