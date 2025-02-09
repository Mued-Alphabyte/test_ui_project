import 'package:flutter/material.dart';

import '../../utils/colors.dart';

InputDecoration searchInputDecoration({Color? borderColor, Color? hintColor}) {
  return InputDecoration(
    hintText: "Search items here...",
    hintStyle: TextStyle(color: hintColor ?? Colors.grey[400]),
    filled: true,
    fillColor: Colors.white,
    contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 16),
    suffixIcon: Icon(Icons.search, color: hintColor ?? Colors.grey[400]), // Icon on the right
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: textHintColor.withOpacity(0.3), width: 1.5),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: textHintColor.withOpacity(0.3), width: 1.5),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: (hintColor ?? Colors.grey).withOpacity(0.3), width: 1),
    ),
  );
}