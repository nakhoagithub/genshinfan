import 'package:genshinfan/utils/config.dart';

class UserApp {
  final String uid;
  final String? name;
  final String? email;
  final String? linkImage;
  final int role;

  // version 1.5
  final List<int> roles;
  final bool active;

  const UserApp({
    required this.uid,
    this.name,
    this.email,
    this.linkImage,
    required this.role,
    required this.roles,
    required this.active,
  });

  static UserApp fromJson(Map<dynamic, dynamic> json) {
    return UserApp(
      uid: json['uid'],
      name: json['name'],
      email: json['email'],
      linkImage: json['image'],
      role: json['role'],
      roles: json["roles"] == null
          ? Config.rolesDefault
          : List<int>.from(json["roles"].map((x) => x)),
      active: json['active'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "name": name,
      "email": email,
      "image": linkImage,
      "role": role,
      "roles": List<dynamic>.from(roles.map((x) => x)),
      "active": active,
    };
  }
}
