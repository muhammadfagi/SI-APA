import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:siapa/koordinator/judulmahasiswa.dart';
import 'package:siapa/koordinator/tanggal.dart';
import 'package:siapa/koordinator/rekapstatusdiambil.dart';
import 'package:siapa/login.dart';

class RekapStatusDiambil extends StatefulWidget {
  const RekapStatusDiambil({Key? key}) : super(key: key);

  @override
  State<RekapStatusDiambil> createState() => _RekapStatusDiambilState();
}

class _RekapStatusDiambilState extends State<RekapStatusDiambil> {
  @override
  Widget build(BuildContext context) {
    final MediaQueryHeight = MediaQuery.of(context).size.height;
    final MediaQueryWidth = MediaQuery.of(context).size.width;
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
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.filter_alt_outlined),
            color: Color(0xFF578BB8),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) =>
                    _buildPopUpRekapStatusDiambil(context),
              );
            },
          ),
        ],
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
                Card(
                  margin: EdgeInsets.fromLTRB(26, 14, 26, 0),
                  child: Container(
                    width: MediaQueryWidth * 0.867,
                    constraints: BoxConstraints(maxHeight: double.infinity),
                    child: SizedBox(
                      child: Container(
                        margin: EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(right: 10),
                              child: Icon(
                                Icons.account_circle_outlined,
                                color: Color(0xFF578BB8),
                              ),
                            ),
                            Container(
                              width: 266,
                              child: Column(
                                children: [
                                  Container(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Muhammad Fagi",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 1),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Text(
                                          "2103191020",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              letterSpacing: 1),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          "Disetujui Sudah Diambil",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              letterSpacing: 1,
                                              color: Color(0xff20B726)),
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
                ),
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
