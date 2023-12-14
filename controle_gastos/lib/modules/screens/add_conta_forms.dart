import 'package:controle_gastos/modules/models/conta.dart';
import 'package:controle_gastos/modules/models/currency_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class AddContaForms extends StatefulWidget {
  const AddContaForms({super.key});

  @override
  State<AddContaForms> createState() => AddContaFormsState();
}

class AddContaFormsState extends State<AddContaForms> {
  String titulo = "";
  double valor = 0;
  String descricao = '';
  int? selectedOption = 1;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    setState(() {
      selectedOption = 1;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: [
          const SizedBox(
            height: 16,
          ),
          TextFormField(
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(16),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                labelText: "Conta"),
            onChanged: (value) {
              setState(() {
                titulo = value;
              });
            },
            validator: (value) {
              var validation = textValidation(value);
              return validation;
            },
          ),
          const SizedBox(
            height: 16,
          ),
          TextFormField(
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(16),
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              labelText: "Valor",
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              CurrencyInputFormatter(),
            ],
            onChanged: (value) {
              double? novoValor = stringPunctToDouble(value: value);
              if (novoValor != null) {
                setState(() {
                  valor = novoValor;
                });
              } else {
                setState(() {
                  valor = 0;
                });
              }
            },
            validator: (value) {
              if (value == null ||
                  value.isEmpty ||
                  stringPunctToDouble(value: value) == 0) {
                return "Insira um número diferente de 0";
              }
              return null;
            },
          ),
          const SizedBox(
            height: 16,
          ),
          TextFormField(
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(16),
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              labelText: "Descrição",
            ),
            onChanged: (value) {
              setState(() {
                descricao = value;
              });
            },
            validator: (value) {
              var validation = textValidation(value);
              return validation;
            },
          ),
          const SizedBox(
            height: 16,
          ),
          RadioListTile(
            title: const Text("Conta"),
            value: 1,
            groupValue: selectedOption,
            onChanged: (value) {
              setState(() {
                selectedOption = value;
              });
            },
          ),
          const SizedBox(
            height: 16,
          ),
          RadioListTile(
            title: const Text("Recebimento"),
            value: 2,
            groupValue: selectedOption,
            onChanged: (value) {
              setState(() {
                selectedOption = value;
              });
            },
          ),
          const SizedBox(
            height: 16,
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                if (selectedOption == 1) {
                  setState(() {
                    valor = valor * -1;
                  });
                }
                Conta conta = Conta(
                  id: const Uuid().v1(),
                    title: titulo,
                    price: valor,
                    description: descricao,
                    time: DateTime.now());
                Navigator.pop(
                  context,
                  conta,
                );
              }
            },
            style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(48)),
            child: const Text("Enviar"),
          )
        ],
      ),
    );
  }

  String? textValidation(String? value) {
    if (value == null || value.isEmpty) {
      return "Insira um texto";
    }
    return null;
  }

  double? stringPunctToDouble({required String value}) {
    String stringValor = value.replaceAll(r".", r"");
    stringValor = stringValor.replaceAll(r",", r".");
    double? newValor = double.tryParse(stringValor);
    return newValor;
  }
}
