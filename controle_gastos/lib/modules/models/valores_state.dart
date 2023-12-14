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
  List<Conta> contas = [];
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
      contas.remove(conta);
    }
    valorAtual -= conta.price;
    DBProvider.db.deleteConta(ContaDB.fromConta(conta));
    notifyListeners();
  }

  ///This method loads Contas from database to the appState
  ///
  /// This method should run only one time on the build method of [_ControlPageState]
  void addContasInit({required List<Conta> novasContas}) {
    // Made to create contas from DataBase
    /**
     * This method should run 1 and only 1 time
     * In the initial run of the build method of _ControlPageState
     */
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