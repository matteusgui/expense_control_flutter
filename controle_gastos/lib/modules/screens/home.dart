import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/valores_state.dart';
import 'add_conta.dart';

class ControlPage extends StatefulWidget {
  const ControlPage({super.key});

  @override
  State<ControlPage> createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {
  int currentPageIndex = 0;
  bool validaInicio = true;

  @override
  Widget build(BuildContext context) {
    // Lógica utilizada para que o trecho de código seja executado somente uma vez
    // Necessário pois adContasInit chama setState que chama build, que chamaria setState novamente, gerando um loop infinito
    var appState = context.watch<ValoresState>();
    if (validaInicio) {
      appState.loadContasInit();
      validaInicio = false;
    }

    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int value) {
          setState(() {
            currentPageIndex = value;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.account_balance_outlined),
            label: "Valor Final",
            selectedIcon: Icon(Icons.account_balance),
          ),
          NavigationDestination(
            icon: Icon(Icons.account_balance_wallet_outlined),
            label: "Contas",
            selectedIcon: Icon(Icons.account_balance_wallet),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateAndDisplaySelection(context, appState: appState);
        },
        tooltip: "Adicionar",
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: <Widget>[
          const PageValor(),
          const PageContas(),
        ][currentPageIndex],
      ),
    );
  }
}

class PageValor extends StatelessWidget {
  const PageValor({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<ValoresState>();
    return Column(
      children: [
        Expanded(
          child: Center(
            child: Text(
              appState.valorAtual.toStringAsFixed(2),
              style: const TextStyle(
                fontSize: 40,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class PageContas extends StatelessWidget {
  const PageContas({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<ValoresState>();

    if (appState.contas.isEmpty) {
      return const Center(
        child: Text("Sem Contas ainda"),
      );
    }

    return ListView.builder(
      itemCount: appState.contas.length,
      prototypeItem: Card(
        child: ListTile(
          title: Text(appState.contas.first.title),
          subtitle: Text(appState.contas.first.price.toStringAsFixed(2)),
          trailing: IconButton(
            icon: const Icon(Icons.delete_outline_outlined),
            onPressed: () {},
          ),
        ),
      ),
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text(appState.contas[index].title),
            subtitle: Text(appState.contas[index].price.toStringAsFixed(2)),
            trailing: IconButton(
                onPressed: () {
                  appState.removeConta(conta: appState.contas[index]);
                },
                icon: const Icon(Icons.delete_outline_outlined)),
          ),
        );
      },
    );
  }
}

Future<void> _navigateAndDisplaySelection(BuildContext context,
    {required ValoresState appState}) async {
  final result = await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const AddConta(),
    ),
  );
  if (result != null) {
    appState.addConta(conta: result);
  }
}
