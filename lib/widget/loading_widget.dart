import 'package:flutter/material.dart';

class Loadingwidget extends StatelessWidget {
  const Loadingwidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: Colors.orange,
      ),
    );
  }
}
