class UserApp {
  final String uid;
  final String? name;
  final String? email;
  final String? linkImage;
  final int role;
  const UserApp({
    required this.uid,
    this.name,
    this.email,
    this.linkImage,
    required this.role,
  });

  static UserApp fromJson(Map<dynamic, dynamic> json) {
    return UserApp(
      uid: json['uid'],
      name: json['name'],
      email: json['email'],
      linkImage: json['image'],
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "name": name,
      "email": email,
      "image": linkImage,
      "role": role,
    };
  }
}
