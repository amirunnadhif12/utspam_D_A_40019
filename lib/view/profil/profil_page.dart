import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controller/auth_controller.dart';
import '../auth/welcome_page.dart';
import 'edit_profile_page.dart';

class ProfilPage extends StatelessWidget {
  const ProfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthController>(context);
    const primaryGreen = Color(0xFF1AAE6F);

    final user = auth.user;

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0, foregroundColor: Colors.black87, title: const Text('Profile')),
      backgroundColor: const Color(0xFFF6FBFF),
      body: user == null
          ? const Center(child: Text('Data user tidak ditemukan 😅'))
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  // Avatar with edit badge
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      CircleAvatar(
                        radius: 56,
                        backgroundColor: primaryGreen.withAlpha(30),
                        child: ClipOval(
                            child: Builder(builder: (_) {
                          final fallback = 'https://avatars.dicebear.com/api/avataaars/${Uri.encodeComponent(user.nama)}.png?background=%23ffffff';
                          final avatar = (user.avatarUrl != null && user.avatarUrl!.isNotEmpty) ? user.avatarUrl! : fallback;
                          return Image.network(
                            avatar,
                            width: 108,
                            height: 108,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => const Icon(Icons.person, size: 64, color: Colors.white),
                          );
                        })),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 8,
                        child: GestureDetector(
                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const EditProfilePage())),
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(color: primaryGreen, shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 2)),
                            child: const Icon(Icons.edit, color: Colors.white, size: 18),
                          ),
                        ),
                      )
                    ],
                  ),

                  const SizedBox(height: 12),
                  Text(user.nama, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  const Text('Buyer', style: TextStyle(color: Colors.black54)),

                  const SizedBox(height: 20),

                  // Options
                  Expanded(
                    child: ListView(
                      children: [
                        _optionTile(context, Icons.edit, 'Edit Profile', () => Navigator.push(context, MaterialPageRoute(builder: (_) => const EditProfilePage()))),
                        _optionTile(context, Icons.notifications, 'Notification', () {}),
                        _optionTile(context, Icons.location_on, 'Shipping Address', () {}),
                        _optionTile(context, Icons.lock, 'Change Password', () {}),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),

                  // Sign out
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        await auth.logout();
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const WelcomePage()), (route) => false);
                      },
                      icon: const Icon(Icons.logout, color: Colors.white),
                      label: const Text('Sign Out', style: TextStyle(fontSize: 16, color: Colors.white)),
                      style: ElevatedButton.styleFrom(backgroundColor: primaryGreen, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
    );
  }

  Widget _optionTile(BuildContext context, IconData icon, String title, VoidCallback onTap) {
    const primaryGreen = Color(0xFF1AAE6F);
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(backgroundColor: primaryGreen, child: Icon(icon, color: Colors.white)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}
