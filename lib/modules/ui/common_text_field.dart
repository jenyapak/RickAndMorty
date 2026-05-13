import 'package:flutter/material.dart';
import 'package:rick_and_morty/providers/app_theme_provider.dart';

class CommonTextField extends StatelessWidget {
  const CommonTextField({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        label: Text(label),
        fillColor: AppThemeProvider.colors.textField,
        filled: true,
        prefixIcon: Icon(Icons.search),
        suffixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 30, child: VerticalDivider(width: 2)),
            SizedBox(width: 8),
            Image.asset(
              'assets/images/filter_logo.png',
              width: 20,
              height: 20,
              fit: BoxFit.contain,
            ),
            // Icon(Icons.filter_alt_outlined),
          ],
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(100),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(100),
        ),
      ),
    );
  }
}
