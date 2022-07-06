// To parse this JSON data, do
//
//     final dataJudul = dataJudulFromJson(jsonString);

import 'dart:convert';

Tahun TahunFromJson(String str) => Tahun.fromJson(json.decode(str));

String TahunToJson(Tahun data) => json.encode(data.toJson());

class Tahun {
  Tahun({
    // required this.nomor,
    required this.tahun,
  });

  // String nomor;
  String tahun;

  factory Tahun.fromJson(Map<String, dynamic> json) => Tahun(
    // nomor: json["NOMOR"],
    tahun: json["TAHUN"],
  );

  Map<String, dynamic> toJson() => {
    // "NOMOR": nomor,
    "TAHUN": tahun,
  };
}
