class TransaksiModel {
  int? id;
  String? obatId;
  String obatNama;
  int hargaSatuan;
  int jumlah;
  int total;
  String namaPembeli;
  String metode;
  String? nomorResep;
  String? catatan;
  String tanggal;

  TransaksiModel({
    this.id,
    this.obatId,
    required this.obatNama,
    required this.hargaSatuan,
    required this.jumlah,
    required this.total,
    required this.namaPembeli,
    required this.metode,
    this.nomorResep,
    this.catatan,
    required this.tanggal,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'obatId': obatId,
        'obatNama': obatNama,
        'hargaSatuan': hargaSatuan,
        'jumlah': jumlah,
        'total': total,
        'namaPembeli': namaPembeli,
        'metode': metode,
        'nomorResep': nomorResep,
        'catatan': catatan,
        'tanggal': tanggal,
      };

  factory TransaksiModel.fromMap(Map<String, dynamic> m) => TransaksiModel(
        id: m['id'] as int?,
        obatId: m['obatId']?.toString(),
        obatNama: m['obatNama'] ?? '',
        hargaSatuan: m['hargaSatuan'] ?? 0,
        jumlah: m['jumlah'] ?? 0,
        total: m['total'] ?? 0,
        namaPembeli: m['namaPembeli'] ?? '',
        metode: m['metode'] ?? '',
        nomorResep: m['nomorResep'],
        catatan: m['catatan'],
        tanggal: m['tanggal'] ?? '',
      );

  Map<String, dynamic> toJson() => toMap();

  factory TransaksiModel.fromJson(Map<String, dynamic> m) => TransaksiModel.fromMap(m);
}
