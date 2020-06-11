// To parse this JSON data, do
//
//     final userSum = userSumFromMap(jsonString);

import 'dart:convert';

class UserSum {
    UserSum({
        this.id,
        this.unreadNotificationsCount,
        this.postsCount,
        this.viewsCount,
        this.followsCount,
        this.followersCount,
        this.marksCount,
        this.upsCount,
        this.upedCount,
    });

    final String id;
    final int unreadNotificationsCount;
    final int postsCount;
    final int viewsCount;
    final int followsCount;
    final int followersCount;
    final int marksCount;
    final int upsCount;
    final int upedCount;

    factory UserSum.fromJson(String str) => UserSum.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory UserSum.fromMap(Map<String, dynamic> json) => UserSum(
        id: json["id"] == null ? null : json["id"],
        unreadNotificationsCount: json["unreadNotificationsCount"] == null ? null : json["unreadNotificationsCount"],
        postsCount: json["postsCount"] == null ? null : json["postsCount"],
        viewsCount: json["viewsCount"] == null ? null : json["viewsCount"],
        followsCount: json["followsCount"] == null ? null : json["followsCount"],
        followersCount: json["followersCount"] == null ? null : json["followersCount"],
        marksCount: json["marksCount"] == null ? null : json["marksCount"],
        upsCount: json["upsCount"] == null ? null : json["upsCount"],
        upedCount: json["upedCount"] == null ? null : json["upedCount"],
    );

    Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "unreadNotificationsCount": unreadNotificationsCount == null ? null : unreadNotificationsCount,
        "postsCount": postsCount == null ? null : postsCount,
        "viewsCount": viewsCount == null ? null : viewsCount,
        "followsCount": followsCount == null ? null : followsCount,
        "followersCount": followersCount == null ? null : followersCount,
        "marksCount": marksCount == null ? null : marksCount,
        "upsCount": upsCount == null ? null : upsCount,
        "upedCount": upedCount == null ? null : upedCount,
    };
}
