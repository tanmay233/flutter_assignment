class Order {
  final String time;
  final String client;
  final String ticker;
  final String side;
  final String product;
  final int executed;
  final int total;
  final double price;

  Order({
    required this.time,
    required this.client,
    required this.ticker,
    required this.side,
    required this.product,
    required this.executed,
    required this.total,
    required this.price,
  });
}
