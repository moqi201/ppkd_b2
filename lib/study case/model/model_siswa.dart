class Siswa{
  final int? id;
  final String name;
  final int umur;
  Siswa({
    this.id,
    required this.name,
    required this.umur,
  });
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'umur': umur,
    };
  }
  factory Siswa.fromMap(Map<String, dynamic> map) {
    return Siswa(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] as String,
      umur: map['umur'] as int,
    );
  }
}