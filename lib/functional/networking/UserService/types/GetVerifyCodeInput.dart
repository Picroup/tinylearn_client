// To parse this JSON data, do
//
//     final getVerifyCodeInput = getVerifyCodeInputFromJson(jsonString);

import 'dart:convert';

class GetVerifyCodeInput {
    final String phone;

    GetVerifyCodeInput({
        this.phone,
    });

    factory GetVerifyCodeInput.fromJson(String str) => GetVerifyCodeInput.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory GetVerifyCodeInput.fromMap(Map<String, dynamic> json) => GetVerifyCodeInput(
        phone: json["phone"] == null ? null : json["phone"],
    );

    Map<String, dynamic> toMap() => {
        "phone": phone == null ? null : phone,
    };
}
