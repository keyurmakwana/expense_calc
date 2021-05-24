class Transaction {
  final String id, title;
  final DateTime date;
  final double amount;

  Transaction(
      {required this.amount,
      required this.date,
      required this.id,
      required this.title});
}
