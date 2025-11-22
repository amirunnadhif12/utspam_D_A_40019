import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controller/auth_controller.dart';
import 'register_page.dart';
import '../home/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final userC = TextEditingController();
  final passC = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    const Color primaryGreen = Color(0xFF1AAE6F);
    final auth = Provider.of<AuthController>(context, listen: false);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [Color(0xFFe8f7f0), Color(0xFFffffff)], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: Column(
              children: [
                const SizedBox(height: 8),
                // Logo / avatar
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white, boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)]),
                  child: const Icon(Icons.local_pharmacy, color: primaryGreen, size: 44),
                ),
                const SizedBox(height: 18),
                const Text('Welcome Back', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                const Text('Login to continue to your account', style: TextStyle(color: Colors.black54)),
                const SizedBox(height: 20),

                // Card with form
                Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: userC,
                            decoration: const InputDecoration(prefixIcon: Icon(Icons.person), labelText: 'Username', filled: true, fillColor: Colors.white),
                            validator: (v) => v == null || v.isEmpty ? 'Wajib diisi' : null,
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: passC,
                            obscureText: _obscure,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.lock),
                              labelText: 'Password',
                              filled: true,
                              fillColor: Colors.white,
                              suffixIcon: IconButton(icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility), onPressed: () => setState(() => _obscure = !_obscure)),
                            ),
                            validator: (v) => v == null || v.length < 6 ? 'Minimal 6 karakter' : null,
                          ),
                          const SizedBox(height: 18),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: _loading ? null : () async {
                                if (!_formKey.currentState!.validate()) return;
                                setState(() => _loading = true);
                                final ok = await auth.login(userC.text.trim(), passC.text.trim());
                                setState(() => _loading = false);
                                if (!ok) {
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Username atau password salah')));
                                } else {
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomePage()));
                                }
                              },
                              style: ElevatedButton.styleFrom(backgroundColor: primaryGreen, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                              child: _loading ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)) : const Text('Login', style: TextStyle(fontSize: 16)),
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterPage())), child: const Text("Don't have an account? Sign Up")),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12),
                const Text('Or continue with', style: TextStyle(color: Colors.black54)),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton.icon(onPressed: () {}, icon: const Icon(Icons.facebook, color: Color(0xFF1877F2)), label: const Text('Facebook')),
                    const SizedBox(width: 10),
                    OutlinedButton.icon(onPressed: () {}, icon: const Icon(Icons.g_mobiledata, color: Colors.red), label: const Text('Google')),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
