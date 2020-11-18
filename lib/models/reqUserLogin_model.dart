// To parse this JSON data, do
//
//     final reqLoginUser = reqLoginUserFromJson(jsonString);

import 'dart:convert';

ReqLoginUser reqLoginUserFromJson(String str) => ReqLoginUser.fromJson(json.decode(str));

String reqLoginUserToJson(ReqLoginUser data) => json.encode(data.toJson());

class ReqLoginUser {
    ReqLoginUser({
        this.email,
        this.password,
    });

    String email;
    String password;

    factory ReqLoginUser.fromJson(Map<String, dynamic> json) => ReqLoginUser(
        email: json["email"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
    };
}
