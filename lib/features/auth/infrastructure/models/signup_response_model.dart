class SignupResponseModel {
  final int id;
  final String username;
  final String email;

  SignupResponseModel({
    required this.id,
    required this.username,
    required this.email,
  });

  factory SignupResponseModel.fromJson(Map<String, dynamic> json) =>
      SignupResponseModel(
        id: json["id"],
        username: json["username"],
        email: json["email"],
      );
}
