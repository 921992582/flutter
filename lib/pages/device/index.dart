import 'package:flutter/material.dart';

class DeviceView extends StatefulWidget {
  const DeviceView({super.key});

  @override
  State<DeviceView> createState() => _DeviceViewState();
}

class _DeviceViewState extends State<DeviceView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('设备页')),
      body: const Center(child: Text('这是设备页')),
    );
  }
}
