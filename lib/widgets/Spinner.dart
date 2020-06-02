


import 'package:flutter/material.dart';

class Spinner extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Center(
        child: SizedBox(
          child: CircularProgressIndicator(strokeWidth: 2),
          width: 36,
          height: 36,
        ),
      ),
    );
  }
}