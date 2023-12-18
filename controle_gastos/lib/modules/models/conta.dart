import 'package:controle_gastos/modules/models/conta_db.dart';


/// Class to store data of debt.
/// 
/// This class is to be used on the INTERFACE only.
/// 
/// For use in the database the class to be used is [ContaDB].
/// 
/// At the moment the classes [Conta] and [ContaDB] does not have a super class.
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


  /// Creates a Conta instace from a ContaDB instance.
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
