// To parse this JSON data, do
//
//     final notificationsData = notificationsDataFromMap(jsonString);

import 'dart:convert';

import 'package:tinylearn_client/models/CursorNotifications.dart';

class NotificationsData {
    NotificationsData({
        this.notifications,
    });

    final CursorNotifications notifications;

    factory NotificationsData.fromJson(String str) => NotificationsData.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory NotificationsData.fromMap(Map<String, dynamic> json) => NotificationsData(
        notifications: json["notifications"] == null ? null : CursorNotifications.fromMap(json["notifications"]),
    );

    Map<String, dynamic> toMap() => {
        "notifications": notifications == null ? null : notifications.toMap(),
    };
}