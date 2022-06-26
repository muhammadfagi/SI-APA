// To parse this JSON data, do
//
//     final dataJudul = dataJudulFromJson(jsonString);

import 'dart:convert';

Program ProgramFromJson(String str) => Program.fromJson(json.decode(str));

String ProgramToJson(Program data) => json.encode(data.toJson());

class Program {
    Program({
        required this.nomor,
        required this.program,
    });

    String nomor;
    String program;

    factory Program.fromJson(Map<String, dynamic> json) => Program(
        nomor: json["NOMOR"],
        program: json["PROGRAM"],
    );

    Map<String, dynamic> toJson() => {
        "NOMOR": nomor,
        "PROGRAM": program,
    };
}
