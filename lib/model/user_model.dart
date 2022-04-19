class UserModel {
  final String name;
  final String phone;
  String? about;
  String? dpImage;
  String? id;
  UserModel({
    required this.name,
    required this.phone,
    this.id,
    this.about,
    this.dpImage,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'phone': phone,
        'about': about,
        'dpImage': dpImage,
        'id':id,
      };

  static UserModel fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      phone: json['phone'],
      about: json['about'],
      dpImage: json['dpImage'],
      id:json['id'],
    );
  }
}
