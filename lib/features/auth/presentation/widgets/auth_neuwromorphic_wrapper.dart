import 'package:flutter/material.dart';

Widget softField({required Widget child}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.grey[200],
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          offset: Offset(2, 2),
          blurRadius: 6,
          color: Colors.black.withValues(alpha: 0.10),
        ),
        BoxShadow(
          offset: Offset(-2, -2),
          blurRadius: 6,
          color: Colors.white.withValues(alpha: 0.7),
        ),
      ],
    ),
    child: child,
  );
}
