import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controller/auth_controller.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  String? _nama;
  String? _username;
  String? _telepon;
  String? _alamat;
  String? _password;
  String? _avatarUrl;

  @override
  void initState() {
    super.initState();
    final auth = Provider.of<AuthController>(context, listen: false);
    final u = auth.user;
    _nama = u?.nama;
    _username = u?.username;
    _telepon = u?.telepon;
    _alamat = u?.alamat;
    _avatarUrl = u?.avatarUrl;
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthController>(context);
    final user = auth.user;
    const primaryGreen = Color(0xFF1AAE6F);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        backgroundColor: primaryGreen,
      ),
      body: user == null
        ? const Center(child: Text('User tidak ditemukan'))
        : Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  const SizedBox(height: 8),
                  TextFormField(
                    initialValue: _nama,
                    decoration: const InputDecoration(labelText: 'Name', filled: true, fillColor: Colors.white),
                    validator: (v) => v == null || v.isEmpty ? 'Harus diisi' : null,
                    onSaved: (v) => _nama = v,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    initialValue: _avatarUrl,
                    decoration: const InputDecoration(labelText: 'Avatar URL (optional)', filled: true, fillColor: Colors.white),
                    onSaved: (v) => _avatarUrl = v,
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.teal, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                      onPressed: () async {
                        // generate cute avatar URL using DiceBear avataaars
                        final nameForUrl = Uri.encodeComponent(user.nama);
                        final generated = 'https://img.lovepik.com/png/20231109/profile-pic-vector-cartoon-sticker-but-pic_545336_wh860.png';
                        final ok = await auth.updateUser(
                          id: user.id!,
                          nama: user.nama,
                          username: user.username,
                          telepon: user.telepon,
                          alamat: user.alamat,
                          avatarUrl: generated,
                        );
                        if (ok) {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Avatar lucu disimpan ke profil')));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Gagal menyimpan avatar')));
                        }
                      },
                      icon: const Icon(Icons.emoji_emotions),
                      label: const Text('Use Cute Avatar'),
                    ),
                  ),
                  TextFormField(
                    initialValue: _username,
                    decoration: const InputDecoration(labelText: 'Username', filled: true, fillColor: Colors.white),
                    validator: (v) => v == null || v.isEmpty ? 'Harus diisi' : null,
                    onSaved: (v) => _username = v,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    initialValue: _telepon,
                    decoration: const InputDecoration(labelText: 'Phone Number', filled: true, fillColor: Colors.white),
                    onSaved: (v) => _telepon = v,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    initialValue: _alamat,
                    decoration: const InputDecoration(labelText: 'Address', filled: true, fillColor: Colors.white),
                    onSaved: (v) => _alamat = v,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'New Password (optional)', filled: true, fillColor: Colors.white),
                    obscureText: true,
                    onSaved: (v) => _password = v,
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: primaryGreen, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                      onPressed: () async {
                        if (!_formKey.currentState!.validate()) return;
                        _formKey.currentState!.save();
                        final ok = await auth.updateUser(
                          id: user.id!,
                          nama: _nama!.trim(),
                          username: _username!.trim(),
                          telepon: _telepon ?? '',
                          alamat: _alamat ?? '',
                          password: (_password != null && _password!.isNotEmpty) ? _password : null,
                          avatarUrl: (_avatarUrl != null && _avatarUrl!.isNotEmpty) ? _avatarUrl : null,
                        );
                        if (ok) {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Profil berhasil diperbarui')));
                          Navigator.pop(context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Gagal memperbarui profil (username mungkin sudah dipakai)')));
                        }
                      },
                      child: const Text('Save', style: TextStyle(fontSize: 16)),
                    ),
                  )
                ],
              ),
            ),
          ),
    );
  }
}
