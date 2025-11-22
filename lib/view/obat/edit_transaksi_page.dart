import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/transaksi_model.dart';
import '../../controller/transaksi_controller.dart';

class EditTransaksiPage extends StatefulWidget {
  final TransaksiModel transaksi;

  const EditTransaksiPage({required this.transaksi, super.key});

  @override
  State<EditTransaksiPage> createState() => _EditTransaksiPageState();
}

class _EditTransaksiPageState extends State<EditTransaksiPage> {
  final _formKey = GlobalKey<FormState>();
  late int jumlah;
  late String metode;
  String? nomorResep;
  String? catatan;

  @override
  void initState() {
    super.initState();
    jumlah = widget.transaksi.jumlah;
    metode = widget.transaksi.metode;
    nomorResep = widget.transaksi.nomorResep;
    catatan = widget.transaksi.catatan;
  }

  @override
  Widget build(BuildContext context) {
    const primaryGreen = Color(0xFF1AAE6F);
    final trxCtrl = Provider.of<TransaksiController>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Transaksi"),
        backgroundColor: primaryGreen,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Container(
                padding: const EdgeInsets.all(14),
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
                  children: [
                    TextFormField(
                      initialValue: jumlah.toString(),
                      decoration: const InputDecoration(
                        labelText: "Jumlah Pembelian",
                        prefixIcon: Icon(Icons.format_list_numbered),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (v) {
                        if (v == null || v.isEmpty) return 'Harus diisi';
                        final n = int.tryParse(v);
                        if (n == null || n <= 0) return 'Harus angka > 0';
                        return null;
                      },
                      onSaved: (v) => jumlah = int.parse(v!),
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
                        setState(() {
                          metode = v!;
                          if (metode != 'resep') nomorResep = null;
                        });
                      },
                    ),
                    const SizedBox(height: 14),

                    if (metode == "resep")
                      TextFormField(
                        initialValue: nomorResep,
                        decoration: const InputDecoration(
                          labelText: "Nomor Resep",
                          prefixIcon: Icon(Icons.receipt_long),
                        ),
                        validator: metode == "resep"
                            ? (v) {
                                if (v == null || v.length < 6) {
                                  return "Minimal 6 karakter";
                                }
                                return null;
                              }
                            : null,
                        onSaved: (v) => nomorResep = v,
                      ),

                    const SizedBox(height: 14),

                    TextFormField(
                      initialValue: catatan,
                      decoration: const InputDecoration(
                        labelText: "Catatan (opsional)",
                        prefixIcon: Icon(Icons.edit_note),
                      ),
                      onSaved: (v) => catatan = v,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: primaryGreen, width: 1.8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        "Batal",
                        style: TextStyle(
                          color: primaryGreen,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryGreen,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      onPressed: () async {
                        if (!_formKey.currentState!.validate()) return;
                        _formKey.currentState!.save();

                        final updatedTotal =
                            widget.transaksi.hargaSatuan * jumlah;

                        final updated = TransaksiModel(
                          id: widget.transaksi.id,
                          obatId: widget.transaksi.obatId,
                          obatNama: widget.transaksi.obatNama,
                          hargaSatuan: widget.transaksi.hargaSatuan,
                          jumlah: jumlah,
                          total: updatedTotal,
                          namaPembeli: widget.transaksi.namaPembeli,
                          metode: metode,
                          nomorResep:
                              metode == "resep" ? nomorResep : null,
                          catatan: catatan,
                          tanggal: widget.transaksi.tanggal,
                        );

                        await trxCtrl.updateTransaksi(updated);
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Simpan Perubahan",
                        style:
                            TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
