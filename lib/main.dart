import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'data/database/database_helper.dart';
import 'providers/auth_provider.dart';
import 'providers/koleksi_provider.dart';
import 'providers/kuis_provider.dart';
import 'providers/narasi_provider.dart';
import 'presentation/screens/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi awal database agar langsung aktif & terbaca di App Inspection
  try {
    await DatabaseHelper.instance.database;
  } catch (e) {
    debugPrint('Gagal menginisialisasi database di awal: $e');
  }

  runApp(const BharataWayangApp());
}

class BharataWayangApp extends StatelessWidget {
  const BharataWayangApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => KoleksiProvider()),
        ChangeNotifierProvider(create: (_) => KuisProvider()),
        ChangeNotifierProvider(create: (_) => NarasiProvider()),
      ],
      child: MaterialApp(
        title: 'BharataWayang',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        home: const SplashScreen(),
      ),
    );
  }
}
