
import 'dart:convert';

import 'Post.dart';

class PostsData {
    final List<Post> posts;

    PostsData({
        this.posts,
    });

    factory PostsData.fromJson(String str) => PostsData.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory PostsData.fromMap(Map<String, dynamic> json) => PostsData(
        posts: json["posts"] == null ? null : List<Post>.from(json["posts"].map((x) => Post.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "posts": posts == null ? null : List<dynamic>.from(posts.map((x) => x.toMap())),
    };
}
