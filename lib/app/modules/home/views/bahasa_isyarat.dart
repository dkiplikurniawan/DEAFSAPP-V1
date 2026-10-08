import 'package:flutter/material.dart';

void main() {
  runApp(const BahasaIsyarat());
}
class BahasaIsyarat extends StatelessWidget {
  const BahasaIsyarat({super.key});
  
   @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hello World',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Hello World'),
        ),
        body: const Center(
          child: Text(
            'Hello, World!',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}