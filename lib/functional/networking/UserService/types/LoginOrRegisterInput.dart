class LoginOrRegisterInput {
    final String phone;
    final String code;

    LoginOrRegisterInput({
        this.phone,
        this.code,
    });

    factory LoginOrRegisterInput.fromMap(Map<String, dynamic> json) => LoginOrRegisterInput(
        phone: json["phone"] == null ? null : json["phone"],
        code: json["code"] == null ? null : json["code"],
    );

    Map<String, dynamic> toMap() => {
        "phone": phone == null ? null : phone,
        "code": code == null ? null : code,
    };
}