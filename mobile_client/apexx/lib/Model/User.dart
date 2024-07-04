// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  final String email;
  final String name;
  final String userID;
  final String token;
  User({
    required this.email,
    required this.name,
    required this.userID,
    required this.token,
  });

  User copyWith({
    String? email,
    String? userID,
    String? name,
    String? token,
  }) {
    return User(
      email: email ?? this.email,
      userID: userID ?? this.userID,
      name: name ?? this.name,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'name': name,
      'userID': userID,
      'token': token,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
        userID: map['_id'] as String,
        token: map['token'] as String,
        email: "",
        name: "");
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.email == email &&
        other.name == name &&
        other.userID == userID &&
        other.token == token;
  }

  @override
  int get hashCode {
    return email.hashCode ^ userID.hashCode ^ name.hashCode ^ token.hashCode;
  }
}
