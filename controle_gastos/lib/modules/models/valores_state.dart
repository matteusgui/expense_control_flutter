import 'package:flutter/material.dart';

import '../repositories/db.dart';
import 'conta.dart';
import 'conta_db.dart';

/// This class is responsible for controlling the whole appState
/// 
/// This was done because it simplifies and concentrate the app's logic.
/// This could be done because of the simplicity this code has.
/// 
/// This class is together with the [ContaDB] class responsible for isolating the rendering from the data logic.
class ValoresState extends ChangeNotifier {
  List<Conta> contas = [];  // Contas list to monitoring the contas in the database without needing to fetch it all the time
  double valorAtual = 0;

  ///Adds a [Conta] Instance to the app state and the database
  void addConta({required Conta conta}) {
    contas.add(conta);
    valorAtual += conta.price;
    DBProvider.db.insertConta(ContaDB.fromConta(conta));
    notifyListeners();
  }

  /// Removes a [Conta] instance from the app state and the database
  void removeConta({required Conta conta}) {
    if (contas.contains(conta)) {
      contas.remove(conta);  // Removing conta from the vector of data
    }
    valorAtual -= conta.price;  // Updating the value
    DBProvider.db.deleteConta(ContaDB.fromConta(conta)); // Remove conta from the database
    notifyListeners();
  }

  ///This method loads [Conta]s from database to the appState
  ///
  /// This method should run only one time on the build method of [_ControlPageState]
  void loadContasInit() {
    List<Conta> novasContas = [];
    DBProvider.db.getAllContas().then((value) {
      for (var contaDb in value) {
        novasContas.add(Conta.fromContaDB(contaDb));
      }
    });
    var newContas = contas.toSet().union(novasContas.toSet()).toList();
    contas = newContas;
    double novoValor = 0;
    for (var element in contas) {
      novoValor += element.price;
    }
    valorAtual = novoValor;
    notifyListeners();
  }
}