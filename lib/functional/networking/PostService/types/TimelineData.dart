// To parse this JSON data, do
//
//     final timelineData = timelineDataFromMap(jsonString);

import 'dart:convert';

import 'package:tinylearn_client/models/CursorPosts.dart';

class TimelineData {
    TimelineData({
        this.timeline,
    });

    final CursorPosts timeline;

    factory TimelineData.fromJson(String str) => TimelineData.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory TimelineData.fromMap(Map<String, dynamic> json) => TimelineData(
        timeline: json["timeline"] == null ? null : CursorPosts.fromMap(json["timeline"]),
    );

    Map<String, dynamic> toMap() => {
        "timeline": timeline == null ? null : timeline.toMap(),
    };
}