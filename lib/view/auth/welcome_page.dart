import 'package:flutter/material.dart';
import 'login_page.dart';
import 'register_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});
  @override
  Widget build(BuildContext context) {
    const Color primaryGreen = Color(0xFF1AAE6F);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: -30, left: 0, right: 0,
            height: size.height * 0.70,
            child: Stack(
              children: [
                Image.asset('assets/images/welcome_bg.jpg', fit: BoxFit.cover, width: double.infinity, height: double.infinity),
                Container(color: Colors.black.withAlpha(3)),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: size.height * 0.48,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(46), topRight: Radius.circular(46)),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 12, offset: Offset(0, -6))],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 28),
                child: Column(
                  children: [
                    Container(width: 64, height: 64, decoration: BoxDecoration(color: primaryGreen, shape: BoxShape.circle), child: const Icon(Icons.local_pharmacy, color: Colors.white, size: 34)),
                    const SizedBox(height: 12),
                    const Text("SELAMAT DATANG", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    const Text('Solusi Kesehatan Anda, Mudah & Cepat di akses', textAlign: TextAlign.center, style: TextStyle(color: Colors.black54, fontSize: 14)),
                    const SizedBox(height: 22),
                    SizedBox(width: double.infinity, height: 54, child: ElevatedButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginPage())), style: ElevatedButton.styleFrom(backgroundColor: primaryGreen, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))), child: const Text('Login', style: TextStyle(fontSize: 18)))),
                    const SizedBox(height: 12),
                    SizedBox(width: double.infinity, height: 54, child: OutlinedButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterPage())), style: OutlinedButton.styleFrom(side: BorderSide(color: primaryGreen, width: 1.6), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))), child: const Text('Sign Up', style: TextStyle(fontSize: 16, color: Color(0xFF1AAE6F))))),
                    const SizedBox(height: 10),
                    const Text('By continuing you agree to our Terms & Privacy', style: TextStyle(fontSize: 11, color: Colors.black45), textAlign: TextAlign.center),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
