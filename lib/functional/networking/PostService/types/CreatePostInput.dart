// To parse this JSON data, do
//
//     final createPostInput = createPostInputFromMap(jsonString);

import 'dart:convert';

class CreatePostInput {
    CreatePostInput({
        this.content,
    });

    final String content;

    CreatePostInput copyWith({
        String content,
    }) => 
        CreatePostInput(
            content: content ?? this.content,
        );

    factory CreatePostInput.fromJson(String str) => CreatePostInput.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory CreatePostInput.fromMap(Map<String, dynamic> json) => CreatePostInput(
        content: json["content"] == null ? null : json["content"],
    );

    Map<String, dynamic> toMap() => {
        "content": content == null ? null : content,
    };
}
