import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main.dart'; 

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context); 
    final isDarkMode = themeProvider.isDarkMode;

    return IconButton(
      icon: Icon(
        isDarkMode ? Icons.light_mode : Icons.dark_mode,
        color: Colors.white,
      ),
      onPressed: themeProvider.toggleTheme,
    );
  }
}