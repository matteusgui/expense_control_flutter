import 'package:flutter/material.dart';
import 'add_conta_forms.dart';

class AddConta extends StatelessWidget {
  const AddConta({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nova Conta"),
      ),
      body: const SafeArea(child: AddContaForms()),
    );
  }
}