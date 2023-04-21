import 'package:flutter/cupertino.dart';

class SettingsModel{
  final IconData icon;
  final VoidCallback onTap;
  final String title;
  final String subtitle;

  const SettingsModel({
    required this.icon,
    required this.onTap,
    required this.title,
    required this.subtitle,
  });
}