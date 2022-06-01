import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String email;
  final String localId;
  final String token;

  const User({
    required this.email,
    required this.localId,
    required this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'],
      localId: json['localId'],
      token: 'Bearer ${json['idToken']}',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['localId'] = localId;
    data['idToken'] = token;
    return data;
  }

  @override
  List<Object?> get props => [email, localId, token];
}
