import 'package:controle_gastos/modules/models/conta.dart';

/// This class serves the purpose of being a isolation from the screens
/// that uses the [Conta] class to render and the Database
/// creating a certain isolation between the rendering and the data
class ContaDB {
  final String id;
  final double price;
  final String description;
  final String title;
  final DateTime time;

  // Creates a ContaDB
  ContaDB({
    required this.id,
    required this.price,
    required this.description,
    required this.title,
    required this.time,
  });

  // Create a ContaDB instance from a Map of strings
  factory ContaDB.fromMap(Map<String, dynamic> map) {
    return ContaDB(
      id: map['id'],
      price: map['price'],
      description: map['description'],
      title: map['title'],
      time: DateTime.parse(map['time']),
    );
  }

  // Create a ContaDB instance from a Conta instance
  factory ContaDB.fromConta(Conta conta) {
    return ContaDB(
        id: conta.id,
        price: conta.price,
        description: conta.description,
        title: conta.title,
        time: conta.time);
  }

  /// Creates a Map instance from the ContaDB instance
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'price': price,
      'description': description,
      'title': title,
      'time': time.toIso8601String(),
    };
  }
}
