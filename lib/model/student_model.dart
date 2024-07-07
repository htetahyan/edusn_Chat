class Student {
  final String? name;
  final String id;
  final int? age;
  final String? address;
  final List<String>? subjects;

  Student({
    this.name,
    required this.id,
    this.age,
    this.address,
    this.subjects,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
        name: json['name'],
        id: json['id'],
        age: json['age'],
        address: json['address'],
        subjects: json['subjects']);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id,
      'age': age,
      'address': address,
      'subjects': subjects,
    };
  }
}
