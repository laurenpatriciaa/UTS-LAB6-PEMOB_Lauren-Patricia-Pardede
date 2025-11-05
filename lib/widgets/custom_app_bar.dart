import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double screenWidth;
  final double screenHeight;
  final VoidCallback? onBack;

  const CustomAppBar({
    super.key,
    required this.title,
    required this.screenWidth,
    required this.screenHeight,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF3F9ED1),
      elevation: 0,
      centerTitle: true,
      leading: onBack != null
          ? IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: screenWidth * 0.06,
              ),
              onPressed: onBack,
            )
          : null,
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'SmartifyFont', 
          fontSize: screenWidth * 0.06,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(screenHeight * 0.08);
}