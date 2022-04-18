class UserModel {
  final String name;
  final String phone;
  String? about;
  String? dpImage;
  UserModel({
    required this.name,
    required this.phone,
    this.about,
    this.dpImage,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'phone': phone,
        'about': about,
        'dpImage': dpImage,
      };

  static UserModel fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      phone: json['phone'],
      about: json['about'],
      dpImage: json['dpImage'],
    );
  }
}
