class Peserta {
  final int? id;
  final String name;
  final String email;
  final String event;
  final String kota;
  Peserta({
    this.id,
    required this.name,
    required this.email,
    required this.event,
    required this.kota,
  });
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'event': event,
      'kota': kota,
    };
  }
  factory Peserta.fromMap(Map<String, dynamic> map) {
    return Peserta(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] as String,
      email: map['email'] as String,
      event: map['event'] as String,
      kota: map['kota'] as String,
    );
  }
}
