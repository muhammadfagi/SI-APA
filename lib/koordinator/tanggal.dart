import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:intl/intl.dart';
import 'package:siapa/koordinator/judulmahasiswa.dart';
import 'package:siapa/koordinator/tanggal.dart';
import 'package:siapa/koordinator/rekapstatusdiambil.dart';
import 'package:siapa/login.dart';

class Tanggal extends StatefulWidget {
  const Tanggal({Key? key}) : super(key: key);

  @override
  State<Tanggal> createState() => _TanggalState();
}

class _TanggalState extends State<Tanggal> {
  List<String> data = [
    "Brazil",
    "Italia (Disabled)",
    "Tunisia",
    "Canada",
    "Thailand",
    'Malaysia'
  ];

  TextEditingController dateinputawal = TextEditingController();

  @override
  void initStateAwal() {
    dateinputawal.text = ""; //set the initial value of text field
    super.initState();
  }

  TextEditingController timeinput = TextEditingController();
  //text editing controller for text field

  @override
  void initState() {
    timeinput.text = ""; //set the initial value of text field
    super.initState();
  }

  Future<Null> _selectTanggalAwal(BuildContext context) async {
    DateTime? _datePickerAwal = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
    );

    if (_datePickerAwal != null) {
      print(
          _datePickerAwal); //pickedDate output format => 2021-03-10 00:00:00.000
      String formattedDate = DateFormat('yyyy-MM-dd').format(_datePickerAwal);
      print(
          formattedDate); //formatted date output using intl package =>  2021-03-16

      setState(() {
        dateinputawal.text =
            formattedDate; //set output date to TextField value.
      });
    } else {
      print("Date is not selected");
    }
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryHeight = MediaQuery.of(context).size.height;
    final MediaQueryWidth = MediaQuery.of(context).size.width;
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
                    // height: 40.0,
                    child: DropdownSearch<String>(
                        mode: Mode.MENU,
                        // showSelectedItem: true,
                        items: data,
                        hint: "country in menu mode",
                        // popupItemDisabled: (String s) => s.startsWith('I'),
                        onChanged: print,
                        selectedItem: "Brazil"),
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
                    // height: 40.0,
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
                    margin: EdgeInsets.fromLTRB(0, 17, 223, 6),
                    child: Text(
                      "Tanggal Mulai",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ),
                  TextField(
                    readOnly: true,
                    controller: dateinputawal,
                    onTap: () {
                      setState(() {
                        _selectTanggalAwal(context);
                      });
                    },
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: false,
                      hintText: "Pilih Tanggal",
                      hintStyle: TextStyle(fontSize: 12),
                      suffixIcon: Icon(Icons.date_range_outlined),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 17, 202, 6),
                    child: Text(
                      "Tanggal Berakhir",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ),
                  TextField(
                    readOnly: true,
                    controller: timeinput,
                    onTap: () async {
                      TimeOfDay? pickedTime = await showTimePicker(
                        initialTime: TimeOfDay.now(),
                        context: context,
                      );
                      if (pickedTime != null) {
                        print(pickedTime.format(context)); //output 10:51 PM
                        DateTime? parsedTime = DateFormat.jm()
                            .parse(pickedTime.format(context).toString());
                        //converting to DateTime so that we can further format on different pattern.
                        print(parsedTime); //output 1970-01-01 22:53:00.000
                        String? formattedTime =
                            DateFormat('hh:mm:ss').format(parsedTime);
                        print(formattedTime); //output 14:59:00
                        //DateFormat() is from intl package, you can format the time on any pattern you need.

                        setState(() {
                          timeinput.text =
                              formattedTime; //set the value of text field.
                        });
                      } else {
                        print("Time is not selected");
                      }
                    },
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: false,
                      hintText: "Pilih Tanggal",
                      hintStyle: TextStyle(fontSize: 12),
                      suffixIcon: Icon(Icons.date_range_outlined),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)),
                    ),
                  ),
                  Container(
                    width: 508,
                    height: 45,
                    margin: EdgeInsets.only(top: 11.0),
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
                        "Login",
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {},
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
