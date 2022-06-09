import 'package:flutter/material.dart';
import 'package:siapa/mahasiswa/detailjudul.dart';
import 'package:siapa/mahasiswa/judul.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'dart:async';

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
                                              "${snapshot.data[index]["JUDUL"]}",
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
                                              "Aplikasi Administrasi Judul Proyek Berbasis Mobile PENS adskasdka daknd kasnd kand kasndkaskdn aksdn aksdnk anskdnaksdn kasdn kajndkasndkjanskdj nakdnakdnkandk andkansdkansdk nasdknakd nakdn kadka kandk ans dk ankan kdna kdnak dkan ka dansdk akdnaks dka da kakd kad kadn kadkadka dka kdn ak dakd akdn kadn kad ka dkad kad ka ndkand ka dkad ka dkan dkand kasdkka aksdn ask",
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
                                      onPressed: () {},
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
                                            child: Text(
                                              "Pembimbing 1 : Rengga Asmara, S.Kom., M.T.",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "Pembimbing 2 : Nana Ramadijanti, S.Kom, M.Kom",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "Pembimbing 3 : ",
                                              style: TextStyle(
                                                  color: Colors.black),
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
                                                  "Diterima",
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
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
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
                              // Catatan
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
                                            child: Text(
                                              "bla bal balbalbablabasbablbnalbnalsn ",
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
                                              _buildPopupCatatan(context),
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
                                                      MaterialStateProperty.all<
                                                              Color>(
                                                          Color(0xffc4c4c4)),
                                                  shape: MaterialStateProperty
                                                      .all<RoundedRectangleBorder>(
                                                          RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  )),
                                                ),
                                                child: Text(
                                                  "Download",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black),
                                                ),
                                                onPressed: () {},
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
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
        Uri.https('project.mis.pens.ac.id',
            '/mis112/siapa/mahasiswa/api/content/detailjudul.php', {'function' : 'editJudul'}),
        body: convert.jsonEncode({
          'NOMOR': nmr,
          'JUDUL': TextEditingController,
        }),
        headers: {
          "Accept": "application/json",
        });
    // var dataUser = convert.jsonDecode(hasil.body);
    print(hasil.body);
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


  // TextEditingController judul = new TextEditingController();
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
              return Container(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: 1,
                  itemBuilder: (BuildContext context, index) {
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
                                controller: TextEditingController(text: "${snapshot.data[index]["JUDUL"]}"),
                                decoration: InputDecoration(
                                  // prefixText: "${snapshot.data[index]["JUDUL"]}",
                                  fillColor: Colors.white,
                                  filled: false,
                                  hintText: "Masukkan Judul",
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
                                    // Navigator.of(context).pop();
                                    updateJudul();
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
                      ),
                    );
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

// pop up dosbing
List<String> data = ["Brazil", "Italia (Disabled)", "Tunisia", 'Canada'];
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
            "Dosen Pembimbing 2",
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
            "Dosen Pembimbing 3",
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

// pop up catatan
Widget _buildPopupCatatan(BuildContext context) {
  return new AlertDialog(
    title: const Text(
      'Edit Catatan',
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
            "Catatan",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w200),
          ),
        ),
        SizedBox(
          width: 340,
          height: 40,
          child: TextField(
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: false,
              hintText: "Masukkan Catatan",
              hintStyle: TextStyle(fontSize: 12, letterSpacing: 0.5),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
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
