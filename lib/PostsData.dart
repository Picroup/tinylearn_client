// To parse this JSON data, do
//
//     final postsData = postsDataFromJson(jsonString);

import 'dart:convert';

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

class Post {
    final String id;
    final int created;
    final String content;

    Post({
        this.id,
        this.created,
        this.content,
    });

    factory Post.fromJson(String str) => Post.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Post.fromMap(Map<String, dynamic> json) => Post(
        id: json["id"] == null ? null : json["id"],
        created: json["created"] == null ? null : json["created"],
        content: json["content"] == null ? null : json["content"],
    );

    Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "created": created == null ? null : created,
        "content": content == null ? null : content,
    };
}
