import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controller/obat_controller.dart';
import '../../controller/transaksi_controller.dart';
import '../../models/transaksi_model.dart';
import '../../models/obat_model.dart';

class BeliObatPage extends StatefulWidget {
  final String? preselectedObatId;
  const BeliObatPage({this.preselectedObatId, super.key});

  @override
  State<BeliObatPage> createState() => _BeliObatPageState();
}

class _BeliObatPageState extends State<BeliObatPage> {
  final _form = GlobalKey<FormState>();

  String? namaPembeli;
  ObatModel? selected;
  int jumlah = 1;
  String metode = "langsung";
  String nomorResep = "";
  String catatan = "";

  @override
  void initState() {
    super.initState();
    final obatCtrl = Provider.of<ObatController>(context, listen: false);
    if (widget.preselectedObatId != null) {
      selected = obatCtrl.findById(widget.preselectedObatId!);
    }
  }

  @override
  Widget build(BuildContext context) {
    const primaryGreen = Color(0xFF1AAE6F);
    final obatCtrl = Provider.of<ObatController>(context);
    final trxCtrl = Provider.of<TransaksiController>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryGreen,
        title: const Text("Form Pembelian Obat"),
      ),
      backgroundColor: Colors.white,
      body: Form(
        key: _form,
        child: ListView(
          padding: const EdgeInsets.all(18),
          children: [
            // Card Data Pembeli
            _buildCard(
              children: [
                const Text(
                  "Data Pembeli",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 14),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Nama Pembeli",
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (v) => v == null || v.isEmpty ? "Harus diisi" : null,
                  onSaved: (v) => namaPembeli = v,
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Card Data Obat
            _buildCard(
              children: [
                const Text(
                  "Data Obat",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 14),
                DropdownButtonFormField<ObatModel>(
                  decoration: const InputDecoration(
                    labelText: "Pilih Obat",
                    prefixIcon: Icon(Icons.medication),
                  ),
                  value: selected,
                  items: obatCtrl.list.map((o) {
                    return DropdownMenuItem(
                      value: o,
                      child: Text("${o.nama} - Rp ${o.harga}"),
                    );
                  }).toList(),
                  onChanged: (v) {
                    setState(() => selected = v);
                  },
                  validator: (v) => v == null ? "Pilih obat" : null,
                ),
                const SizedBox(height: 14),
                TextFormField(
                  initialValue: "1",
                  decoration: const InputDecoration(
                    labelText: "Jumlah",
                    prefixIcon: Icon(Icons.add_shopping_cart),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (v) {
                    if (v == null || v.isEmpty) return "Harus diisi";
                    final n = int.tryParse(v);
                    if (n == null || n <= 0) return "Harus angka > 0";
                    return null;
                  },
                  onSaved: (v) => jumlah = int.parse(v!),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Card Metode & Opsional
            _buildCard(
              children: [
                const Text(
                  "Detail Pembelian",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 14),
                DropdownButtonFormField<String>(
                  value: metode,
                  decoration: const InputDecoration(
                    labelText: "Metode Pembelian",
                    prefixIcon: Icon(Icons.local_hospital),
                  ),
                  items: ["langsung", "resep"]
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (v) {
                    setState(() => metode = v!);
                  },
                ),
                const SizedBox(height: 14),
                if (metode == "resep")
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Nomor Resep",
                      prefixIcon: Icon(Icons.receipt),
                    ),
                    validator: metode == "resep"
                        ? (v) =>
                            v == null || v.length < 6 ? "Min 6 karakter!" : null
                        : null,
                    onSaved: (v) => nomorResep = v ?? "",
                  ),
                const SizedBox(height: 14),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Catatan (opsional)",
                    prefixIcon: Icon(Icons.edit),
                  ),
                  onSaved: (v) => catatan = v ?? "",
                ),
              ],
            ),

            const SizedBox(height: 30),

            // Button Checkout
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryGreen,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                ),
                onPressed: () async {
                  if (!_form.currentState!.validate()) return;
                  _form.currentState!.save();

                  final total = selected!.harga * jumlah;

                  final t = TransaksiModel(
                    obatId: selected!.id,
                    obatNama: selected!.nama,
                    hargaSatuan: selected!.harga,
                    jumlah: jumlah,
                    total: total,
                    namaPembeli: namaPembeli!,
                    metode: metode,
                    nomorResep: metode == 'resep' ? nomorResep : null,
                    catatan: catatan,
                    tanggal: DateTime.now().toIso8601String(),
                  );

                  await trxCtrl.addTransaksi(t);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Transaksi berhasil!')),
                  );
                  Navigator.pop(context);
                },
                child: const Text(
                  "Checkout",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard({required List<Widget> children}) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withAlpha(15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        children: children,
      ),
    );
  }
}
