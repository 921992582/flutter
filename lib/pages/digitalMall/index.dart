import 'package:flutter/material.dart';

class DigitalMallView extends StatefulWidget {
  const DigitalMallView({super.key});

  @override
  State<DigitalMallView> createState() => _DigitalMallViewState();
}

class _DigitalMallViewState extends State<DigitalMallView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('社区页')),
      body: const Center(child: Text('这是社区页')),
    );
  }
}
