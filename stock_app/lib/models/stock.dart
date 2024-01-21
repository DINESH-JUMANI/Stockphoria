class Stock {
  final String symbol;
  final String company;
  final double price;
  final double changeInPrice;

  Stock(
      {required this.symbol,
      required this.company,
      required this.price,
      required this.changeInPrice});
}
