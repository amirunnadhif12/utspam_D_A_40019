import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controller/transaksi_controller.dart';
import 'detail_transaksi_page.dart';

class RiwayatPage extends StatelessWidget {
  const RiwayatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final trxCtrl = Provider.of<TransaksiController>(context);
    const primaryGreen = Color(0xFF1AAE6F);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Riwayat Pembelian'),
        backgroundColor: primaryGreen,
      ),
      body: trxCtrl.list.isEmpty
          ? const Center(
              child: Text(
                'Belum ada riwayat transaksi',
                style: TextStyle(color: Colors.black54, fontSize: 16),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: trxCtrl.list.length,
              itemBuilder: (context, i) {
                final t = trxCtrl.list[i];
                final date = t.tanggal.split('T').first;

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12.withAlpha(20),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(14),
                    leading: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: primaryGreen.withAlpha(38),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.medication_liquid,
                        color: primaryGreen,
                        size: 26,
                      ),
                    ),
                    title: Text(
                      t.obatNama,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Rp ${t.total}', style: const TextStyle(fontWeight: FontWeight.w600)),
                          Text(
                            '$date • ${t.jumlah} item',
                            style: const TextStyle(color: Colors.grey, fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                    trailing: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryGreen,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DetailTransaksiPage(transaksi: t),
                          ),
                        );
                      },
                      child: const Text(
                        "Detail",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
