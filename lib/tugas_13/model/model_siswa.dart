// Model/model_siswa.dart
class Siswa {
  int? id;
  String nama;
  String kelas;
  String email;
  String imagePath;

  Siswa({
    this.id,
    required this.nama,
    required this.kelas,
    required this.email,
    required this.imagePath,
  });

  factory Siswa.fromMap(Map<String, dynamic> json) => Siswa(
        id: json['id'],
        nama: json['nama'],
        kelas: json['kelas'],
        email: json['email'],
        imagePath: json['imagePath'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'nama': nama,
        'kelas': kelas,
        'email': email,
        'imagePath': imagePath,
      };
}
