// To parse this JSON data, do
//
//     final Filter = FilterFromJson(jsonString);

import 'dart:convert';

Filter FilterFromJson(String str) => Filter.fromJson(json.decode(str));

String FilterToJson(Filter data) => json.encode(data.toJson());

class Filter {
  Filter({
    required this.program,
    required this.jurusan,
    required this.tahun,
  });

  var program;
  var jurusan;
  var tahun;

  factory Filter.fromJson(Map<String, dynamic> json) => Filter(
        program: json["PROGRAM"],
        jurusan: json["JURUSAM"],
        tahun: json["TAHUN"],
      );

  Map<String, dynamic> toJson() => {
        "PROGRAM": program,
        "JURUSAN": jurusan,
        "TAHUN": tahun,
      };

  // @override
  // String toString() => jurusan;
}
