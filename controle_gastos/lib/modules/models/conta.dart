import 'package:controle_gastos/modules/models/conta_db.dart';

class Conta {
  final String id;
  final double price;
  final String description;
  final String title;
  final DateTime time;

  const Conta({
    required this.id,
    required this.price,
    required this.title,
    required this.description,
    required this.time,
  });

  factory Conta.fromContaDB(ContaDB conta) {
    /**
     * Creates a Conta instance from a ContaDB instance
     * Creates an Isolation from the database to the screens using the ContaDB type
     */
    return Conta(
      id: conta.id,
      price: conta.price,
      title: conta.title,
      description: conta.description,
      time: conta.time,
    );
  }
}
