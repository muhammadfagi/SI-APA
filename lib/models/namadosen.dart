// To parse this JSON data, do
//
//     final namaDosen = namaDosenFromJson(jsonString);

import 'dart:convert';

NamaDosen namaDosenFromJson(String str) => NamaDosen.fromJson(json.decode(str));

String namaDosenToJson(NamaDosen data) => json.encode(data.toJson());

class NamaDosen {
    NamaDosen({
        required this.nomor,
        required this.nama,
        required this.gelarDpn,
        required this.gelarBlk,
    });

    var nomor;
    var nama;
    var gelarDpn;
    var gelarBlk;

    factory NamaDosen.fromJson(Map<String, dynamic> json) => NamaDosen(
        nomor: json["NOMOR"],
        nama: json["NAMA"],
        gelarDpn: json["GELAR_DPN"],
        gelarBlk: json["GELAR_BLK"],
    );

    Map<String, dynamic> toJson() => {
        "NOMOR": nomor,
        "NAMA": nama,
        "GELAR_DPN": gelarDpn,
        "GELAR_BLK": gelarBlk,
    };

    @override
    String toString() => nama;
}
