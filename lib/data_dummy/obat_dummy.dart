import '../models/obat_model.dart';

final List<ObatModel> obatDummy = [
  // Analgesik (5)
  ObatModel(id: 'o1', nama: 'Paracetamol', kategori: 'Analgesik', gambar: 'assets/images/obat_paracetamol.png', harga: 5000),
  ObatModel(id: 'o2', nama: 'Ibuprofen', kategori: 'Analgesik', gambar: '', harga: 8000),
  ObatModel(id: 'o3', nama: 'Obat Sakit Tenggorokan', kategori: 'Analgesik', gambar: '', harga: 8000),
  ObatModel(id: 'o4', nama: 'Pain Relief Forte', kategori: 'Analgesik', gambar: '', harga: 12000),
  ObatModel(id: 'o5', nama: 'Analgesik Anak', kategori: 'Analgesik', gambar: '', harga: 7000),

  // Antibiotik (3)
  ObatModel(id: 'o6', nama: 'Amoxicillin', kategori: 'Antibiotik', gambar: 'assets/images/obat_amoxicillin.png', harga: 15000),
  ObatModel(id: 'o7', nama: 'Antibiotik Topikal', kategori: 'Antibiotik', gambar: '', harga: 14000),
  ObatModel(id: 'o8', nama: 'Ciprofloxacin', kategori: 'Antibiotik', gambar: '', harga: 22000),

  // Suplemen (4)
  ObatModel(id: 'o9', nama: 'Vitamin C', kategori: 'Suplemen', gambar: 'assets/images/obat_vitamin.png', harga: 10000),
  ObatModel(id: 'o10', nama: 'Multivitamin Dewasa', kategori: 'Suplemen', gambar: '', harga: 25000),
  ObatModel(id: 'o11', nama: 'Kalsium + D3', kategori: 'Suplemen', gambar: '', harga: 22000),
  ObatModel(id: 'o12', nama: 'Suplemen Omega-3', kategori: 'Suplemen', gambar: '', harga: 35000),

  // Obat Kulit (3)
  ObatModel(id: 'o13', nama: 'Salep Antijamur', kategori: 'Obat Kulit', gambar: '', harga: 15000),
  ObatModel(id: 'o14', nama: 'Salep Kortikosteroid', kategori: 'Obat Kulit', gambar: '', harga: 20000),
  ObatModel(id: 'o15', nama: 'Krim Pelembap', kategori: 'Obat Kulit', gambar: '', harga: 17000),

  // Obat Mata (3)
  ObatModel(id: 'o16', nama: 'Tetes Mata Artificial', kategori: 'Obat Mata', gambar: '', harga: 18000),
  ObatModel(id: 'o17', nama: 'Obat Mata Merah', kategori: 'Obat Mata', gambar: '', harga: 9000),
  ObatModel(id: 'o18', nama: 'Salep Mata Antibiotik', kategori: 'Obat Mata', gambar: '', harga: 20000),

  // Gastrointestinal (3)
  ObatModel(id: 'o19', nama: 'Omeprazole', kategori: 'Gastrointestinal', gambar: '', harga: 20000),
  ObatModel(id: 'o20', nama: 'Loperamide', kategori: 'Gastrointestinal', gambar: '', harga: 9000),
  ObatModel(id: 'o21', nama: 'Metoclopramide', kategori: 'Gastrointestinal', gambar: '', harga: 12000),

  // Respiratory (4)
  ObatModel(id: 'o22', nama: 'Salbutamol Inhaler', kategori: 'Respiratory', gambar: '', harga: 45000),
  ObatModel(id: 'o23', nama: 'Obat Batuk Ekspektoran', kategori: 'Respiratory', gambar: '', harga: 11000),
  ObatModel(id: 'o24', nama: 'Obat Batuk Sedatif', kategori: 'Respiratory', gambar: '', harga: 10000),
  ObatModel(id: 'o25', nama: 'Cetirizine', kategori: 'Respiratory', gambar: '', harga: 7000),
];
