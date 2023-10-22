import 'package:social_app/modules/authentication/domain/entities/user.dart';

class UserModel extends User {
  const UserModel(
      {required super.uid,
      required super.name,
      required super.email,
      required super.photo,
      required super.phone,
      required super.gender});

  factory UserModel.formJson(Map<String, dynamic> json) => UserModel(
        uid: json['uid'],
        name: json['name'],
        email: json['email'],
        photo: json['photo'],
        phone: json['phone'],
        gender: json['gender'],
      );

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'name': name,
        'email': email,
        'photo': photo,
        'phone': phone,
        'gender': gender,
      };
}
