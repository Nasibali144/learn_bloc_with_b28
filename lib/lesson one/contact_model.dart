class Contact {
  String id;
  String title;
  String phone;

  Contact({
    required this.id,
    required this.title,
    required this.phone,
  });

  factory Contact.fromJson(Map<String, Object?> json) {
    return Contact(id: json['id'] as String, title: json['name'] as String, phone: json['number'] as String);
  }
}

enum Status {
  read,
  create,
  edit,
}
