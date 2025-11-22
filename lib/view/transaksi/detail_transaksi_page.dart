import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/transaksi_model.dart';
import '../../controller/transaksi_controller.dart';
import '../obat/edit_transaksi_page.dart';

class DetailTransaksiPage extends StatelessWidget {
  final TransaksiModel transaksi;
  const DetailTransaksiPage({required this.transaksi, super.key});

  @override
  Widget build(BuildContext context) {
    const primaryGreen = Color(0xFF1AAE6F);
    final trxCtrl = Provider.of<TransaksiController>(context, listen: false);
    final date = transaksi.tanggal.split('T').first;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Transaksi'),
        backgroundColor: primaryGreen,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12.withAlpha(20),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _rowInfo('Nama Obat', transaksi.obatNama),
                  _rowInfo('Jumlah', '${transaksi.jumlah} item'),
                  _rowInfo('Harga Satuan', 'Rp ${transaksi.hargaSatuan}'),
                  const Divider(height: 18),
                  _rowInfo('Total', 'Rp ${transaksi.total}', bold: true),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12.withAlpha(20),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _rowInfo('Nama Pembeli', transaksi.namaPembeli),
                  _rowInfo('Metode', transaksi.metode),
                  if (transaksi.nomorResep != null)
                    _rowInfo('Nomor Resep', transaksi.nomorResep!),
                  if (transaksi.catatan != null && transaksi.catatan!.isNotEmpty)
                    _rowInfo('Catatan', transaksi.catatan!),
                  _rowInfo('Tanggal', date),
                ],
              ),
            ),

            const Spacer(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () =>
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                EditTransaksiPage(transaksi: transaksi),
                          ),
                        ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: primaryGreen, width: 1.7),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    // TextStyle dibuat const sehingga Text bisa tetap const
                    child: const Text(
                      'Edit',
                      style: TextStyle(
                        fontSize: 16,
                        color: primaryGreen,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        if (transaksi.id == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('ID transaksi tidak tersedia')),
                          );
                          return;
                        }
                        await trxCtrl.deleteTransaksi(transaksi.id!);
                        Navigator.pop(context);
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Gagal menghapus transaksi')),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    // TextStyle dibuat const sehingga Text bisa tetap const
                    child: const Text('Batalkan',
                        style: TextStyle(fontSize: 16)),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _rowInfo(String title, String value, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(color: Colors.black87)),
          Text(
            value,
            style: TextStyle(
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
              fontSize: bold ? 15 : 13,
            ),
          ),
        ],
      ),
    );
  }
}
