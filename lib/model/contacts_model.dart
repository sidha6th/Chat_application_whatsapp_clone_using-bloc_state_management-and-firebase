class ContactsModel {
  String name;
  String phone;
  final bool isExistingUser;
  ContactsModel({
    this.isExistingUser=false,
    required this.name,
    required this.phone,
  });
}
