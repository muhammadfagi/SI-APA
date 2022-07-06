// To parse this JSON data, do
//
//     final StatusMahasiswa = StatusMahasiswaFromJson(jsonString);

import 'dart:convert';

StatusMahasiswa StatusMahasiswaFromJson(String str) => StatusMahasiswa.fromJson(json.decode(str));

String StatusMahasiswaToJson(StatusMahasiswa data) => json.encode(data.toJson());

class StatusMahasiswa {
  StatusMahasiswa({
    required this.kode,
    required this.status,
  });

  var kode;
  var status;

  factory StatusMahasiswa.fromJson(Map<String, dynamic> json) => StatusMahasiswa(
    status: json["STATUS"],
    kode: json["KODE"],

  );

  Map<String, dynamic> toJson() => {
    "STATUS": status,
    "KODE": kode,

  };

}
