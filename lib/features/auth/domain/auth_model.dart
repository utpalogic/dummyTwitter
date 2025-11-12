class AuthModel {
  final String uid;
  final String email;
  final String name;

  AuthModel({required this.uid, required this.email, required this.name});

  factory AuthModel.fromJson(Map<String, dynamic> json) =>
      AuthModel(uid: json['uid'], email: json['email'], name: json['name']);

  Map<String, dynamic> toJson() => {'uid': uid, 'email': email, 'name': name};
}
