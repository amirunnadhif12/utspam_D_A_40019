import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controller/auth_controller.dart';
import 'controller/obat_controller.dart';
import 'controller/transaksi_controller.dart';
import 'view/auth/welcome_page.dart';
import 'database/database_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool dbOk = true;
  try {
    await DatabaseHelper.instance.database; // inisialisasi DB & create tables
  } catch (e) {
    dbOk = false;
    debugPrint('Gagal inisialisasi database: $e');
  }
  runApp(MyApp(dbInitialized: dbOk));
}

class MyApp extends StatelessWidget {
  final bool dbInitialized;
  const MyApp({super.key, required this.dbInitialized});

  @override  
  Widget build(BuildContext context) {
    if (!dbInitialized) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Apotek UTS - SQLite',
        theme: ThemeData(primarySwatch: Colors.green),
        home: const _DatabaseErrorPage(),
      );
    }

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthController()),
        ChangeNotifierProvider(create: (_) => ObatController()),
        ChangeNotifierProvider(create: (_) => TransaksiController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Apotek UTS - SQLite',
        theme: ThemeData(primarySwatch: Colors.green),
        home: const WelcomePage(),
      ),
    );
  }
}

class _DatabaseErrorPage extends StatelessWidget {
  const _DatabaseErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kesalahan')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.error_outline, size: 64, color: Colors.red),
              SizedBox(height: 16),
              Text(
                'Gagal menginisialisasi database.\nSilakan periksa koneksi/storage dan coba lagi.',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
