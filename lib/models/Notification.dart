// To parse this JSON data, do
//
//     final notification = notificationFromMap(jsonString);

import 'dart:convert';

import 'package:tinylearn_client/models/Post.dart';

import 'Tag.dart';
import 'User.dart';

class Notification {
    Notification({
        this.id,
        this.created,
        this.kind,
        this.readed,
        this.followUserUser,
        this.followUserTag,
        this.upPostUser,
        this.upPostPost,
        this.markPostUser,
        this.markPostPost,
    });

    final String id;
    final int created;
    final String kind;
    final bool readed;
    final User followUserUser;
    final Tag followUserTag;
    final User upPostUser;
    final Post upPostPost;
    final User markPostUser;
    final Post markPostPost;

    factory Notification.fromJson(String str) => Notification.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Notification.fromMap(Map<String, dynamic> json) => Notification(
        id: json["id"] == null ? null : json["id"],
        created: json["created"] == null ? null : json["created"],
        kind: json["kind"] == null ? null : json["kind"],
        readed: json["readed"] == null ? null : json["readed"],
        followUserUser: json["followUserUser"] == null ? null : User.fromMap(json["followUserUser"]),
        followUserTag: json["followUserTag"] == null ? null : Tag.fromMap(json["followUserTag"]),
        upPostUser: json["upPostUser"] == null ? null : User.fromMap(json["upPostUser"]),
        upPostPost: json["upPostPost"] == null ? null : Post.fromMap(json["upPostPost"]),
        markPostUser: json["markPostUser"] == null ? null : User.fromMap(json["markPostUser"]),
        markPostPost: json["markPostPost"] == null ? null : Post.fromMap(json["markPostPost"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "created": created == null ? null : created,
        "kind": kind == null ? null : kind,
        "readed": readed == null ? null : readed,
        "followUserUser": followUserUser == null ? null : followUserUser.toMap(),
        "followUserTag": followUserTag == null ? null : followUserTag.toMap(),
        "upPostUser": upPostUser == null ? null : upPostUser.toMap(),
        "upPostPost": upPostPost == null ? null : upPostPost.toMap(),
        "markPostUser": markPostUser == null ? null : markPostUser.toMap(),
        "markPostPost": markPostPost == null ? null : markPostPost.toMap(),
    };
}
