import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controller/auth_controller.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _form = GlobalKey<FormState>();
  final nameC = TextEditingController();
  final emailC = TextEditingController();
  final teleponC = TextEditingController();
  final alamatC = TextEditingController();
  final userC = TextEditingController();
  final passC = TextEditingController();
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    const Color primaryGreen = Color(0xFF1AAE6F);
    final auth = Provider.of<AuthController>(context, listen: false);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [Color(0xFFffffff), Color(0xFFe8f7f0)], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back)),
                const SizedBox(height: 4),
                const Text('Create Account', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                const Text('Please fill the form to continue', style: TextStyle(color: Colors.black54)),
                const SizedBox(height: 16),

                Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      key: _form,
                      child: Column(
                        children: [
                          TextFormField(controller: nameC, decoration: const InputDecoration(prefixIcon: Icon(Icons.person), labelText: 'Full Name', filled: true, fillColor: Colors.white), validator: (v) => v == null || v.isEmpty ? 'Wajib diisi' : null),
                          const SizedBox(height: 10),
                          TextFormField(controller: emailC, decoration: const InputDecoration(prefixIcon: Icon(Icons.email), labelText: 'Email', filled: true, fillColor: Colors.white), validator: (v) => v == null || !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(v) ? 'Email tidak valid' : null),
                          const SizedBox(height: 10),
                          TextFormField(controller: teleponC, decoration: const InputDecoration(prefixIcon: Icon(Icons.phone), labelText: 'Telepon', filled: true, fillColor: Colors.white), keyboardType: TextInputType.phone, validator: (v) => v == null || v.isEmpty ? 'Wajib diisi' : null),
                          const SizedBox(height: 10),
                          TextFormField(controller: alamatC, decoration: const InputDecoration(prefixIcon: Icon(Icons.home), labelText: 'Alamat', filled: true, fillColor: Colors.white), validator: (v) => v == null || v.isEmpty ? 'Wajib diisi' : null),
                          const SizedBox(height: 10),
                          TextFormField(controller: userC, decoration: const InputDecoration(prefixIcon: Icon(Icons.person_outline), labelText: 'Username', filled: true, fillColor: Colors.white), validator: (v) => v == null || v.isEmpty ? 'Wajib diisi' : null),
                          const SizedBox(height: 10),
                          TextFormField(controller: passC, obscureText: true, decoration: const InputDecoration(prefixIcon: Icon(Icons.lock), labelText: 'Password', filled: true, fillColor: Colors.white), validator: (v) => v == null || v.length < 6 ? 'Minimal 6 karakter' : null),
                          const SizedBox(height: 18),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: _loading ? null : () async {
                                if (!_form.currentState!.validate()) return;
                                setState(() => _loading = true);
                                final ok = await auth.register(
                                  nama: nameC.text.trim(),
                                  telepon: teleponC.text.trim(),
                                  alamat: alamatC.text.trim(),
                                  username: userC.text.trim(),
                                  password: passC.text.trim(),
                                );
                                setState(() => _loading = false);
                                if (ok) {
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Registrasi berhasil')));
                                  Navigator.pop(context);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Gagal registrasi')));
                                }
                              },
                              style: ElevatedButton.styleFrom(backgroundColor: primaryGreen, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                              child: _loading ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)) : const Text('Sign Up', style: TextStyle(fontSize: 16)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
