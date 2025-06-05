class ModelHewan {
  int id;
  String nama;
  String jenis;
  int umur;
  double berat;
  String foto;

  ModelHewan({
    required this.id,
    required this.nama,
    required this.jenis,
    required this.umur,
    required this.berat,
    required this.foto,
  });

  factory ModelHewan.fromMap(Map<String, dynamic> map) {
    double beratFromMap(dynamic berat) {
      if (berat == null) return 0.0;
      if (berat is int) return berat.toDouble();
      if (berat is double) return berat;
      return 0.0;
    }

    return ModelHewan(
      id: map['id'] ?? 0,
      nama: map['nama'] ?? '',
      jenis: map['jenis'] ?? '',
      umur: map['umur'] ?? 0,
      berat: beratFromMap(map['berat']),
      foto: map['foto'] ?? '',
    );
  }
}
