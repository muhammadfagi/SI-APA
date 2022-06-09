// To parse this JSON data, do
//
//     final dataJudul = dataJudulFromJson(jsonString);

import 'dart:convert';

DataJudul dataJudulFromJson(String str) => DataJudul.fromJson(json.decode(str));

String dataJudulToJson(DataJudul data) => json.encode(data.toJson());

class DataJudul {
    DataJudul({
        required this.nomor,
        required this.judul,
    });

    String nomor;
    String judul;

    factory DataJudul.fromJson(Map<String, dynamic> json) => DataJudul(
        nomor: json["NOMOR"],
        judul: json["JUDUL"],
    );

    Map<String, dynamic> toJson() => {
        "NOMOR": nomor,
        "JUDUL": judul,
    };
}
