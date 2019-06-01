import 'package:flutter/material.dart';

class ApplicationThemes {
  
  ///
  /// Global base decoration for all textFields
  ///
  static InputDecoration textFieldDecoration() {
    return InputDecoration(
      contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
    );
  }
}
