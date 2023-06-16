import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class AbonnementScreen extends StatelessWidget {
  const AbonnementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                const Text(
                  'Toutes nos offres',
                  style: TextStyle(fontSize: 24),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
