// To parse this JSON data, do
//
//     final cursorNotifications = cursorNotificationsFromMap(jsonString);

import 'dart:convert';

import 'package:tinylearn_client/models/Notificaion.dart';

class CursorNotifications {
    CursorNotifications({
        this.cursor,
        this.items,
    });

    final dynamic cursor;
    final List<Notification> items;

    factory CursorNotifications.fromJson(String str) => CursorNotifications.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory CursorNotifications.fromMap(Map<String, dynamic> json) => CursorNotifications(
        cursor: json["cursor"],
        items: json["items"] == null ? null : List<Notification>.from(json["items"].map((x) => Notification.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "cursor": cursor,
        "items": items == null ? null : List<dynamic>.from(items.map((x) => x.toMap())),
    };
}