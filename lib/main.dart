import 'package:flutter/material.dart';
import 'package:utspemob/screens/home_screen.dart';
import 'package:provider/provider.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  bool get isDarkMode => _themeMode == ThemeMode.dark;

  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
  
  void setSystemTheme(BuildContext context) {
    if (_themeMode == ThemeMode.system) {
       final brightness = MediaQuery.of(context).platformBrightness;
       _themeMode = brightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light;
    }
  }
}

class ThemeColors extends ThemeExtension<ThemeColors> {
  const ThemeColors({
    required this.homeButtonColor,
    required this.scoreGreen,
    required this.scoreRed,
    required this.cardColor,
  });

  final Color homeButtonColor;
  final Color scoreGreen;
  final Color scoreRed;
  final Color cardColor;

  static const ThemeColors defaults = ThemeColors(
    homeButtonColor: Color(0xFFAD89E7),
    scoreGreen: Color(0xFF4CAF50),
    scoreRed: Color(0xFFF44336),
    cardColor: Colors.white,
  );

  @override
  ThemeColors copyWith({Color? homeButtonColor, Color? scoreGreen, Color? scoreRed, Color? cardColor}) {
    return ThemeColors(
      homeButtonColor: homeButtonColor ?? this.homeButtonColor,
      scoreGreen: scoreGreen ?? this.scoreGreen,
      scoreRed: scoreRed ?? this.scoreRed,
      cardColor: cardColor ?? this.cardColor,
    );
  }

  @override
  ThemeColors lerp(ThemeExtension<ThemeColors>? other, double t) {
    if (other is! ThemeColors) return this;
    return ThemeColors(
      homeButtonColor: Color.lerp(homeButtonColor, other.homeButtonColor, t)!,
      scoreGreen: Color.lerp(scoreGreen, other.scoreGreen, t)!,
      scoreRed: Color.lerp(scoreRed, other.scoreRed, t)!,
      cardColor: Color.lerp(cardColor, other.cardColor, t)!,
    );
  }
}

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const Color primaryBlue = Color(0xFF3F9ED1);
  static const Color accentBlue = Color(0xFF3B89A3);
  static const Color darkText = Color(0xFF2E4E6A);
  static const Color successGreen = Color(0xFF4CAF50);
  static const Color errorRed = Color(0xFFF44336);
  static const Color purpleAccent = Color(0xFFAD89E7);

  ThemeData get lightTheme => ThemeData(
        brightness: Brightness.light,
        primaryColor: primaryBlue,
        colorScheme: const ColorScheme.light(
          primary: primaryBlue,
          secondary: accentBlue,
          surface: Colors.white,
          background: Color(0xFFECF8FF),
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: darkText,
          error: errorRed,
          onBackground: darkText,
        ),
        fontFamily: 'DM Sans',
        scaffoldBackgroundColor: const Color(0xFFECF8FF),
        appBarTheme: const AppBarTheme(
          backgroundColor: primaryBlue,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        extensions: const <ThemeExtension<dynamic>>[
          ThemeColors(homeButtonColor: purpleAccent, scoreGreen: successGreen, scoreRed: errorRed, cardColor: Colors.white),
        ],
      );

  ThemeData get darkTheme => ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFF1E88E5),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF1E88E5),
          secondary: Color(0xFF29B6F6),
          surface: Color(0xFF3A3A3A),
          background: Color(0xFF121212),
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: Colors.white,
          error: Color(0xFFFF5252),
          onBackground: Colors.white,
        ),
        fontFamily: 'DM Sans',
        scaffoldBackgroundColor: const Color(0xFF121212),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1E88E5),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        extensions: const <ThemeExtension<dynamic>>[
          ThemeColors(homeButtonColor: Color(0xFFC7A7FF), scoreGreen: Color(0xFF81C784), scoreRed: Color(0xFFFF8A80), cardColor: Color(0xFF1E1E1E)),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Smartify Quiz',
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: themeProvider.themeMode,
          home: const HomeScreen(),
        );
      },
    );
  }
}
