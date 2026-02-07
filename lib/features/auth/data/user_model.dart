class UserModel {
  final String email;
  final String password;
  final String? image;
  final String? token;
  final String? visa;
  final String? address;

  UserModel({
    required this.email,
    required this.password,
    this.image,
    this.token,
    this.visa,
    this.address,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'] ?? "",
      password: json['password'] ?? "",
      image: json['image'] ?? "",
      token: json['token'] ?? "",
      visa: json['Visa'] ?? "",
      address: json['address'] ?? "",
    );
  }
}
