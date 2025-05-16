class DataBocor {
  String id;
  String judul;
  String kategori;
  String ukuran;
  String sumber;
  String status;
  int harga;
  String keterangan;

  DataBocor({
    required this.id,
    required this.judul,
    required this.kategori,
    required this.ukuran,
    required this.sumber,
    required this.status,
    required this.harga,
    required this.keterangan,
  });

  factory DataBocor.fromMap(Map<String, dynamic> data, String docId) {
    return DataBocor(
      id: docId,
      judul: data['judul'],
      kategori: data['kategori'],
      ukuran: data['ukuran'],
      sumber: data['sumber'],
      status: data['status'],
      harga: data['harga'],
      keterangan: data['keterangan'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'judul': judul,
      'kategori': kategori,
      'ukuran': ukuran,
      'sumber': sumber,
      'status': status,
      'harga': harga,
      'keterangan': keterangan,
    };
  }
}
