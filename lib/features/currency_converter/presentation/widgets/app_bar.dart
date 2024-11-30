import 'package:flutter/material.dart';

customAppBar({required String title}) {
  return AppBar(
    title: Text(
      title,
      style: const TextStyle(
          fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
    ),
    centerTitle: true,
    backgroundColor: const Color(0xFF43A047), // Material green color
    elevation: 4.0,
  );
}
