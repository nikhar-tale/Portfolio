import 'package:flutter/material.dart';

class Expertise {
  const Expertise({
    required this.icon,
    required this.title,
    required this.description,
  });

  factory Expertise.fromMap(Map<String, dynamic> map) {
    return Expertise(
      icon: map['icon'] as IconData,
      title: map['title'] as String,
      description: map['description'] as String,
    );
  }
  final IconData icon;
  final String title;
  final String description;
}
