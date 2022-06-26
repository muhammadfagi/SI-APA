// To parse this JSON data, do
//
//     final dataJudul = dataJudulFromJson(jsonString);

import 'dart:convert';

Jurusan JurusanFromJson(String str) => Jurusan.fromJson(json.decode(str));

String JurusanToJson(Jurusan data) => json.encode(data.toJson());

class Jurusan {
    Jurusan({
        required this.nomor,
        required this.jurusan,
    });

    String nomor;
    String jurusan;

    factory Jurusan.fromJson(Map<String, dynamic> json) => Jurusan(
        nomor: json["NOMOR"],
        jurusan: json["JURUSAN"],
    );

    Map<String, dynamic> toJson() => {
        "NOMOR": nomor,
        "JURUSAN": jurusan,
    };
}
