import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controller/auth_controller.dart';
import '../../controller/obat_controller.dart';
import '../obat/beli_obat_page.dart';
import '../transaksi/riwayat_page.dart';
import '../profil/profil_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  String _search = '';
  String? _selectedCategory;
  final Set<String> _favorites = {};

  @override
  Widget build(BuildContext context) {
    const Color primaryGreen = Color(0xFF1AAE6F);
    final auth = Provider.of<AuthController>(context);
    final obatCtrl = Provider.of<ObatController>(context);

    final categories = <String>{'Semua'}..addAll(obatCtrl.list.map((e) => e.kategori));

    final filtered = obatCtrl.list.where((o) {
      final matchesSearch = _search.isEmpty || o.nama.toLowerCase().contains(_search.toLowerCase());
      final matchesCat = _selectedCategory == null || _selectedCategory == 'Semua' || o.kategori == _selectedCategory;
      return matchesSearch && matchesCat;
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF6FBFF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black87,
        toolbarHeight: 80,
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.grey.shade200,
              child: ClipOval(
                child: Builder(builder: (_) {
                  final name = auth.user?.nama ?? 'User';
                  final fallback = 'https://avatars.dicebear.com/api/avataaars/${Uri.encodeComponent(name)}.png?background=%23ffffff';
                  final avatar = (auth.user?.avatarUrl != null && auth.user!.avatarUrl!.isNotEmpty) ? auth.user!.avatarUrl! : fallback;
                  return Image.network(
                    avatar,
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const Icon(Icons.person, color: Colors.white),
                  );
                }),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Welcome Back', style: TextStyle(fontSize: 12, color: Colors.black54)),
                  Text(auth.user?.nama ?? 'User', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.shopping_cart_outlined),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
            // Search
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Cari obat, mis. Paracetamol",
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: const Icon(Icons.search),
                      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                    ),
                    onChanged: (v) => setState(() => _search = v),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.tune),
                  ),
                )
              ],
            ),

            const SizedBox(height: 12),

            // Category chips
            SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: categories.map((c) {
                  final selected = (_selectedCategory == null && c == 'Semua') || _selectedCategory == c;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(c),
                      selected: selected,
                      onSelected: (_) => setState(() => _selectedCategory = c == 'Semua' ? null : c),
                      selectedColor: primaryGreen,
                      backgroundColor: Colors.white,
                      labelStyle: TextStyle(color: selected ? Colors.white : Colors.black87),
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 16),

            // Promo banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: primaryGreen,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [BoxShadow(color: Colors.black12.withAlpha(10), blurRadius: 8, offset: const Offset(0, 4))],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Get 20% OFF', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 6),
                        const Text('Promo untuk obat bebas pilihan. Belanja sekarang!', style: TextStyle(color: Colors.white70)),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: primaryGreen,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                              ),
                              onPressed: () {
                                setState(() {
                                  _search = '';
                                  _selectedCategory = null;
                                });
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Menampilkan semua produk')));
                              },
                              child: const Text('Shop Now', style: TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            const SizedBox(width: 8),
                            OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Colors.white70),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                              onPressed: () {},
                              child: const Text('Details'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    child: Container(
                      height: 70,
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(24),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                            child: const Center(
                              child: Icon(Icons.percent, color: Color(0xFF1AAE6F), size: 28),
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text('30% OFF', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Featured header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Featured Products', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                TextButton(onPressed: () {}, child: const Text('See all')),
              ],
            ),

            // Featured horizontal list
            SizedBox(
              height: 180,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: filtered.length,
                itemBuilder: (context, i) {
                  final o = filtered[i];
                  return GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => BeliObatPage(preselectedObatId: o.id))),
                    child: Container(
                      width: 150,
                      margin: const EdgeInsets.only(right: 12),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
                                child: o.gambar.isNotEmpty
                                    ? Image.asset(o.gambar, width: 150, height: 100, fit: BoxFit.cover)
                                    : Container(width: 150, height: 100, color: Colors.grey.shade200, child: const Icon(Icons.medical_services)),
                              ),
                              Positioned(
                                top: 8,
                                right: 8,
                                child: CircleAvatar(
                                  radius: 14,
                                  backgroundColor: Colors.white,
                                  child: IconButton(
                                    padding: EdgeInsets.zero,
                                    icon: Icon(_favorites.contains(o.id) ? Icons.favorite : Icons.favorite_border, size: 16, color: Colors.red),
                                    onPressed: () => setState(() => _favorites.contains(o.id) ? _favorites.remove(o.id) : _favorites.add(o.id)),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(o.nama, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.bold)),
                                const SizedBox(height: 6),
                                Text('Rp ${o.harga}', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87)),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 12),

            // Grid for more products (shrink-wrapped so the whole page can scroll)
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: filtered.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.78, mainAxisSpacing: 12, crossAxisSpacing: 12),
              itemBuilder: (context, i) {
                final o = filtered[i];
                return Container(
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: o.gambar.isNotEmpty ? Image.asset(o.gambar, width: double.infinity, fit: BoxFit.cover) : Container(color: Colors.grey.shade200),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(o.nama, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text(o.kategori, style: const TextStyle(color: Colors.black54, fontSize: 12)),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Rp ${o.harga}', style: const TextStyle(fontWeight: FontWeight.bold)),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: primaryGreen, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => BeliObatPage(preselectedObatId: o.id))),
                            child: const Text('Beli', style: TextStyle(fontSize: 12)),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: primaryGreen,
        unselectedItemColor: Colors.black54,
        onTap: (i) async {
          setState(() => _currentIndex = i);
          if (i == 1) {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const RiwayatPage()));
          } else if (i == 2) {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfilPage()));
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.receipt_long), label: 'Orders'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
