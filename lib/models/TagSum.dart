// To parse this JSON data, do
//
//     final tagSum = tagSumFromMap(jsonString);

import 'dart:convert';

class TagSum {
    TagSum({
        this.name,
        this.postsCount,
        this.postsViewsCount,
        this.followersCount,
    });

    final String name;
    final int postsCount;
    final int postsViewsCount;
    final int followersCount;

    factory TagSum.fromJson(String str) => TagSum.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory TagSum.fromMap(Map<String, dynamic> json) => TagSum(
        name: json["name"] == null ? null : json["name"],
        postsCount: json["postsCount"] == null ? null : json["postsCount"],
        postsViewsCount: json["postsViewsCount"] == null ? null : json["postsViewsCount"],
        followersCount: json["followersCount"] == null ? null : json["followersCount"],
    );

    Map<String, dynamic> toMap() => {
        "name": name == null ? null : name,
        "postsCount": postsCount == null ? null : postsCount,
        "postsViewsCount": postsViewsCount == null ? null : postsViewsCount,
        "followersCount": followersCount == null ? null : followersCount,
    };
}
