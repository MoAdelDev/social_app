import 'package:social_app/modules/authentication/domain/entities/user.dart';

class UserModel extends User {
  const UserModel(
      {required super.uid,
      required super.name,
      required super.email,
      required super.photo,
      required super.phone});

  factory UserModel.formJson(Map<String, dynamic> json) => UserModel(
      uid: json['uid'],
      name: json['name'],
      email: json['email'],
      photo: json['photo'],
      phone: json['phone']);

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'name': name,
        'email': email,
        'photo': photo,
        'phone': phone,
      };
}
