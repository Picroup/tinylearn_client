// To parse this JSON data, do
//
//     final postSum = postSumFromMap(jsonString);

import 'dart:convert';

class PostSum {
    PostSum({
        this.id,
        this.viewsCount,
        this.upsCount,
        this.marksCount,
    });

    final String id;
    final int viewsCount;
    final int upsCount;
    final int marksCount;

    factory PostSum.fromJson(String str) => PostSum.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory PostSum.fromMap(Map<String, dynamic> json) => PostSum(
        id: json["id"] == null ? null : json["id"],
        viewsCount: json["viewsCount"] == null ? null : json["viewsCount"],
        upsCount: json["upsCount"] == null ? null : json["upsCount"],
        marksCount: json["marksCount"] == null ? null : json["marksCount"],
    );

    Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "viewsCount": viewsCount == null ? null : viewsCount,
        "upsCount": upsCount == null ? null : upsCount,
        "marksCount": marksCount == null ? null : marksCount,
    };
}
