// To parse this JSON data, do
//
//     final status = statusFromJson(jsonString);

import 'dart:convert';

Status statusFromJson(String str) => Status.fromJson(json.decode(str));

String statusToJson(Status data) => json.encode(data.toJson());

class Status {
    Status({
        required this.status,
    });

    String status;

    factory Status.fromJson(Map<String, dynamic> json) => Status(
        status: json["STATUS"],
    );

    Map<String, dynamic> toJson() => {
        "STATUS": status,
    };

    @override
    String toString() => status;
}
