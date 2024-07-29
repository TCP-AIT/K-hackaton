import 'package:flutter/material.dart';

class SelfCheckPage extends StatefulWidget {
  const SelfCheckPage({super.key});

  @override
  State<SelfCheckPage> createState() => _SelfCheckPageState();
}

class _SelfCheckPageState extends State<SelfCheckPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Text('SelfCheck'),
    );
  }
}
