import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/home_screen.dart';

void main() {
  // Kriteria 7: Memastikan state tidak hilang saat rotasi.
  // Untuk awal, kita bisa membatasi rotasi, tapi State management (Provider/Bloc/Riverpod)
  // akan dibutuhkan untuk menyimpan progres. Disini kita gunakan SystemChrome
  // untuk menstabilkan tampilan awal.
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // Kriteria 5: Menggunakan font kustom. Ganti 'Poppins' dengan nama font kustom Anda.
      theme: ThemeData(
        fontFamily: 'Poppins', 
        primarySwatch: Colors.blue,
      ),
      title: 'Smartify App',
      home: const HomeScreen(),
    );
  }
}