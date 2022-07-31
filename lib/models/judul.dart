
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'dart:async';
import 'package:flutter_session_manager/flutter_session_manager.dart';

ListJudul ListJudulFromJson(String str) => ListJudul.fromJson(json.decode(str));

String ListJudulToJson(ListJudul data) => json.encode(data.toJson());

class ListJudul {
  ListJudul({
    // required this.nomor,
    required this.judul,
  });

  // String nomor;
  String judul;

  static ListJudul fromJson(Map<String, dynamic> json) => ListJudul(
    // nomor: json["NOMOR"],
    judul: json["JUDUL"],
  );

  Map<String, dynamic> toJson() => {
    // "NOMOR": nomor,
    "JUDUL": judul,
  };
}

class ApiJudul {
  static Future<List<ListJudul>> viewJudulOrangLain(String query) async {
    // try {
    int nrp = await SessionManager().get('nrp');
    String nrpQuery = nrp.toString();
    var url = Uri.https(
        'project.mis.pens.ac.id',
        '/mis112/siapa/mahasiswa/api/content/juduloranglainjudul.php/',
        {'nrp': nrpQuery});

    var response = await http.get(url);

    if (response.statusCode == 200) {
      final List jsonData = convert.jsonDecode(response.body);
      print(jsonData);
      // print(jsonData['data'] as double);
      // var judulDataFromJson = jsonData['data'];
      // List<String> userData = List<String>.from(judulDataFromJson);
        return jsonData.map((json) => ListJudul.fromJson(json)).where((tes) {
          final judulLower = tes.judul.toLowerCase();
          final queryLower = query.toLowerCase();

          return judulLower.contains(queryLower);
        }).toList();
    } else {
      throw Exception();
    }
    // } catch (e) {
    //   print("error catchnya $e");
    //   // return null;
    // }
  }
}
