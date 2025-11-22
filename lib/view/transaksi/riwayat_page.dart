import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controller/transaksi_controller.dart';
import 'detail_transaksi_page.dart';

String _formatCurrency(int amount) {
  // simple thousands separator
  final s = amount.toString();
  final buffer = StringBuffer();
  int count = 0;
  for (int i = s.length - 1; i >= 0; i--) {
    buffer.write(s[i]);
    count++;
    if (count == 3 && i != 0) {
      buffer.write('.');
      count = 0;
    }
  }
  final rev = buffer.toString().split('').reversed.join();
  return 'Rp $rev';
}

class RiwayatPage extends StatelessWidget {
  const RiwayatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final trxCtrl = Provider.of<TransaksiController>(context);
    const primaryGreen = Color(0xFF1AAE6F);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Riwayat Pembelian', style: TextStyle(color: Colors.white)),
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

                String statusLabel;
                Color statusColor;
                // derive a friendly status from payment method
                if (t.metode.toLowerCase().contains('cod') || t.metode.toLowerCase().contains('cash')) {
                  statusLabel = 'Completed';
                  statusColor = Colors.green;
                } else if (t.metode.toLowerCase().contains('transfer') || t.metode.toLowerCase().contains('atm')) {
                  statusLabel = 'Paid';
                  statusColor = Colors.blue;
                } else {
                  statusLabel = 'Processing';
                  statusColor = Colors.orange;
                }

                String formattedTotal = _formatCurrency(t.total);

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    elevation: 4,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(14),
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DetailTransaksiPage(transaksi: t))),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            // Image / icon
                            Container(
                              width: 64,
                              height: 64,
                              decoration: BoxDecoration(
                                color: primaryGreen.withAlpha(30),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Center(child: Icon(Icons.medication, color: primaryGreen, size: 30)),
                            ),
                            const SizedBox(width: 12),

                            // middle info
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(t.obatNama, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold), maxLines: 1, overflow: TextOverflow.ellipsis),
                                      ),
                                      const SizedBox(width: 8),
                                      Chip(
                                        label: Text(statusLabel, style: const TextStyle(color: Colors.white, fontSize: 12)),
                                        backgroundColor: statusColor,
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  Text('$date • ${t.jumlah} item', style: const TextStyle(color: Colors.black54)),
                                  const SizedBox(height: 8),
                                  Text(formattedTotal, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                                ],
                              ),
                            ),

                            // action
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                IconButton(
                                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DetailTransaksiPage(transaksi: t))),
                                  icon: const Icon(Icons.chevron_right, color: Colors.black45),
                                ),
                                const SizedBox(height: 8),
                                Text(t.metode, style: const TextStyle(color: Colors.black54, fontSize: 12)),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
