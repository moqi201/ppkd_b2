class ModelHewan {
  int? id;
  String nama;
  String jenis;
  int umur;
  double berat;
  String foto; // path gambar

  ModelHewan({
    this.id,
    required this.nama,
    required this.jenis,
    required this.umur,
    required this.berat,
    required this.foto,
  });

  factory ModelHewan.fromMap(Map<String, dynamic> map) {
    return ModelHewan(
      id: map['id'],
      nama: map['nama'],
      jenis: map['jenis'],
      umur: map['umur'],
      berat: map['berat']?.toDouble() ?? 0.0,
      foto: map['foto'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama': nama,
      'jenis': jenis,
      'umur': umur,
      'berat': berat,
      'foto': foto,
    };
  }
}
