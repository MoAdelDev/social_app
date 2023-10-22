import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String uid;
  final String name;
  final String email;
  final String photo;
  final String phone;
  final String gender;

  const User({
    required this.uid,
    required this.name,
    required this.email,
    required this.photo,
    required this.phone,
    required this.gender,
  });

  @override
  List<Object> get props => [
        uid,
        name,
        email,
        photo,
        phone,
        gender,
      ];
}
