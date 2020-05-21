
import 'dart:convert';

class Post {
    final String id;
    final String content;
    final int created;

    Post({
        this.id,
        this.content,
        this.created,
    });

    factory Post.fromJson(String str) => Post.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Post.fromMap(Map<String, dynamic> json) => Post(
        id: json["id"] == null ? null : json["id"],
        content: json["content"] == null ? null : json["content"],
        created: json["created"] == null ? null : json["created"],
    );

    Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "content": content == null ? null : content,
        "created": created == null ? null : created,
    };
}
