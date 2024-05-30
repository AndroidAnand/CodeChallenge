class States {
  final int id;
  final String name;

  States({required this.id, required this.name});

  factory States.fromJson(Map<String, dynamic> json) {
    return States(
      id: json['id'],
      name: json['value'],
    );
  }
}